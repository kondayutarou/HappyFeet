# 🦶 HappyFeet

A Flask-based web application built for the **Club Happy Feet** community. It supports member management and is deployable to **AWS Elastic Beanstalk**.

---

## 📦 Features

- Member registration and listing (using SQLAlchemy)
- CSRF-protected forms (Flask-WTF)
- Environment-specific configuration via `.env`
- Easy deployment to AWS Elastic Beanstalk
- Pipenv-managed development environment

---

## 🚀 Deployment

### 1. Prerequisites

- Python 3.11+ (`pyenv` recommended)
- [Pipenv](https://pipenv.pypa.io/en/latest/)
- AWS account with Elastic Beanstalk and S3 permissions
- AWS CLI configured (`aws configure`)
- Elastic Beanstalk CLI (`pipenv install awsebcli`)

---

### 2. Setup

```bash
git clone https://github.com/kondayutarou/HappyFeet.git
cd HappyFeet
pipenv install --dev
pipenv shell
