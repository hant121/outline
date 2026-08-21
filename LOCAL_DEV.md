# Local Outline development (Windows)

Theo [Local development](https://docs.getoutline.com/s/hosting/doc/local-development-5hEhFRXow7).

## Đã setup

| Thành phần | Trạng thái |
|---|---|
| `.env` | Secrets/OIDC/S3 lấy từ server `10.171.131.142` |
| `.env.development` | `URL=https://local.outline.dev:3000` + DB/Redis local |
| Postgres + Redis | `docker compose up -d` |
| mkcert SSL | `server/config/certs/*` + hosts `local.outline.dev` |
| Yarn 4.11.0 | `tools/yarn.cmd` (corepack system bị EPERM) |
| DB migrate | Đã chạy |
| App | Backend: `https://local.outline.dev:3000` |

## Mỗi lần mở máy

```powershell
cd D:\work\Gitlab\outline
$env:Path = "D:\work\Gitlab\outline\tools;$env:Path"
docker compose up -d redis postgres
yarn dev:watch
```

Mở: https://local.outline.dev:3000

## MinIO (upload local)

```powershell
docker compose up -d redis postgres minio
docker compose run --rm minio-init
```

- API: **https://minio.outline.dev:9000** (bucket `outline`) — HTTPS bắt buộc (tránh mixed content)
- Console: https://minio.outline.dev:9001 — `minioadmin` / `minioadmin`
- Hosts: `127.0.0.1 minio.outline.dev`
- Certs: `server/config/certs/minio/`
- Env: `.env.development` + `NODE_EXTRA_CA_CERTS` trỏ mkcert root CA

Khi chạy yarn:
```powershell
$env:NODE_EXTRA_CA_CERTS = "C:/Users/capta/AppData/Local/mkcert/rootCA.pem"
yarn dev:watch
```

- `build.js` đã patch copy/rm cross-platform (upstream dùng `rm`/`cp` Unix).
- `vite.config.ts` ignore watch `build/**` để tránh `EBUSY` khi backend rebuild.
- Nên thêm `tools/` vào PATH session; không cần cài yarn system-wide.
