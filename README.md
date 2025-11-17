## Set AWS profile

```bash
export AWS_PROFILE=
```

---

## Create backend bucket

```bash
cd s3-backend-bootstrap/
terraform init
```

Check planned changes

```bash
terraform plan
```

Apply changes to create bucket

```bash
terraform apply
```

Destroy bucket if neede

```bash
terraform destroy
```

Return back to root terraform project folder

```bash
cd ..
```
