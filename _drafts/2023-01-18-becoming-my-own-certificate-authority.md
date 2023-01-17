---
description: Dabble with signing TLS certificates for home web services
# image:
  # path:
  # alt:
---

```
openssl genpkey \
    -out privkey.pem \
    -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-384 \
    -pkeyopt ec_param_enc:named_curve
```

