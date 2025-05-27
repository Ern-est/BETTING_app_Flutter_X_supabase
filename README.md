# BetMate 

A simple Flutter betting app powered by Supabase. Users can place bets, track their bet history, and manage their account securely.

## Features
- User authentication
- Place bets on matches
- View personal bet history
- Supabase as backend (Database + Auth)

## Tech Stack
- **Flutter** (Frontend)
- **Supabase** (Backend: Auth, Database)
- **Dart** (Logic)

## Getting Started
1. Clone the repo
2. Set up your Supabase project with a `bets` table
3. Add your Supabase URL and anon key in `main.dart`
4. Run the app on your emulator or device

## Table: `bets`
| Column     | Type     |
|------------|----------|
| id         | UUID (PK)|
| user_id    | UUID     |
| team1      | Text     |
| team2      | Text     |
| selected   | Text     |
| amount     | Float    |
| status     | Text     |
| created_at | Timestamp|

✅ Don’t forget to enable RLS and add a policy to allow users to read their own bets!

---

Made with ❤️ using Flutter & Supabase

![betting1](https://github.com/user-attachments/assets/473e1ade-4bdf-4847-ad2c-90e47725dc4d)

![betting5](https://github.com/user-attachments/assets/ed8cb2e5-cf4b-4a41-ab5f-c4cf6d76b4ae)

![betting4](https://github.com/user-attachments/assets/1d3d6a16-968a-4fa2-b419-ce043f713fa4)

![betting6](https://github.com/user-attachments/assets/e00c3d06-e7a3-43b7-9681-d7c90dde4192)

![betting3](https://github.com/user-attachments/assets/c35b2266-fdc6-4e9c-8203-916f92ffcb3a)

![betting2](https://github.com/user-attachments/assets/68de28c2-6126-4d45-9828-81f882442144)

