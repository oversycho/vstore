# Vision Store (vstore)

A Flutter-based mobile marketplace application where users can browse and purchase products, and admins can manage listings — built with a Supabase backend.

## ✨ Features

- 🔐 **Authentication** — email/password login & registration via Supabase Auth (Google & Discord OAuth planned)
- 🛍️ **Product Browsing** — category filters, product details, banners/slider
- 🛒 **Cart** — add to cart, view cart with live pricing, shipping cost calculation
- 💬 **Comments** — per-product user reviews
- 💳 **Checkout** — payment gateway integration via WebView (planned)
- 🛠️ **Admin Panel** — manage products, orders, and users (planned)
- 🌗 **Light & Dark Themes** — fully themed UI with custom color palettes

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State Management | flutter_bloc |
| Networking | Dio |
| Backend | Supabase (Auth + PostgREST + RPC) |
| Icons | Cupertino Icons, simple_icons |

## 📁 Project Structure

```
lib/
├── common/
│   └── http_client.dart        # Dio instances (REST + Auth clients)
├── data/
│   ├── product.dart            # ProductEntity
│   ├── cart_item.dart          # CartItemEntity
│   ├── cart_response.dart      # CartResponse
│   ├── comment.dart            # CommentEntity
│   ├── auth_info.dart          # AuthInfo
│   ├── source/                 # Remote data sources (Dio calls)
│   └── repo/                   # Repositories (business logic layer)
├── ui/
│   ├── auth/                   # Login / Register screen
│   ├── home/                   # Home screen + bloc
│   ├── product/                # Product details + bloc + comments
│   ├── widgets/                # Shared widgets (image loader, slider, etc.)
│   └── cart/                   # Cart screen
├── theme.dart                  # Light & dark theme configs
└── main.dart
```

## 🏗️ Architecture

The app follows a simple layered architecture:

```
UI (Widgets/Bloc) → Repository → Remote Data Source → Supabase (REST/RPC)
```

- **Data Source** — raw Dio calls to Supabase REST/RPC endpoints, implements an interface (e.g. `ICartDataSource`)
- **Repository** — implements a domain interface (e.g. `ICartRepository`), delegates to the data source
- **Bloc** — consumes repositories, exposes state to the UI
- **UI** — `BlocProvider` / `BlocBuilder` / `BlocListener` wire blocs to widgets

## 🔌 Backend Setup (Supabase)

1. Create a Supabase project.
2. Set your project URL and anon key in `lib/common/http_client.dart`.
3. Enable **Email** auth provider under **Authentication → Providers**.
4. Run the SQL in [`supabase/functions.sql`](#) to create the `get_cart()` RPC function (returns cart items with computed subtotal, shipping cost, and payable price).
5. Ensure Row Level Security (RLS) policies are set on `products`, `cart`, and `comments` tables so users can only access their own cart data.

### Key endpoints used

| Purpose | Endpoint |
|---|---|
| Login | `POST /auth/v1/token?grant_type=password` |
| Register | `POST /auth/v1/signup` |
| Refresh token | `POST /auth/v1/token?grant_type=refresh_token` |
| Products | `GET /rest/v1/products` |
| Comments | `GET /rest/v1/comments?product_id=eq.{id}` |
| Cart (with totals) | `POST /rest/v1/rpc/get_cart` |
| Add to cart | `POST /rest/v1/cart` |

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Requirements
- Flutter SDK (stable channel)
- A configured Supabase project (see [Backend Setup](#-backend-setup-supabase))

## 🗺️ Roadmap

- [ ] Google & Discord OAuth login
- [ ] Payment gateway integration (WebView-based)
- [ ] Admin panel (product/order/user management)
- [ ] Push notifications for order status
- [ ] Order history screen
- [ ] Settings page with theme toggle (light/dark/system)

## 📄 License

Private project — not licensed for public distribution yet.
