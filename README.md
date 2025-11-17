## Set up

Set AWS profile

```bash
export AWS_PROFILE=
```

Move to project dir

```bash
cd lesson-5
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

Destroy bucket if needed

```bash
terraform destroy
```

Return back to root terraform project folder

```bash
cd ..
```

---

## Manage project

Initialize project (make sure you are in the lesson-5)

```bash
terraform init
```

Check planned changes

```bash
terraform plan
```

Apply changes to create resources

```bash
terraform apply
```

Destroy resources if needed

```bash
terraform destroy
```
