# Robot Framework Restful Booker Platform Tests

Automated API and UI test suite using Robot Framework, Python, RequestsLibrary and Browser Library against the public [Restful Booker Platform](https://www.automationintesting.online) demo application.

## Stack

- [Robot Framework](https://robotframework.org/) 7.x
- [RequestsLibrary](https://github.com/MarketSquare/robotframework-requests) — API testing
- [Robot Framework Browser](https://robotframework-browser.org/) — UI testing (Playwright-based)
- [Faker](https://faker.readthedocs.io/) — test data generation
- [jsonschema](https://python-jsonschema.readthedocs.io/) — JSON contract validation
- GitHub Actions — CI/CD

## Highlights

- API and UI automated tests covering the full Restful Booker Platform
- Authentication flow using **dynamic token generation** (no hardcoded tokens)
- Positive, negative and **contract-style JSON schema** validations
- **Page Object** style organization for UI tests
- **Reusable keyword libraries** for API tests
- **Faker-based data factory** for realistic, randomized test data
- CI execution with GitHub Actions (push + PR triggers)
- Native Robot Framework HTML reports as pipeline artifacts
- Tag-based test selection: `smoke`, `regression`, `negative`, `e2e`, `admin`

## Project Structure

```
tests/
  api/    auth_tests, room_tests, booking_tests
  ui/     home_tests, booking_flow_tests, admin_login_tests
resources/
  api/    auth_keywords, room_keywords, booking_keywords
  ui/     browser_keywords, home_page, admin_page
  variables.robot
libraries/
  data_factory.py
  schema_validator.py
.github/workflows/robot-tests.yml
```

## Local Setup

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

pip install -r requirements.txt
rfbrowser init
```

## Running Tests

```bash
# All tests
robot -d results tests/

# API tests only
robot -d results tests/api

# UI tests only
robot -d results tests/ui

# Smoke tests only (fast feedback)
robot --include smoke -d results tests/

# Negative scenarios only
robot --include negative -d results tests/
```

Open `results/report.html` in your browser after a run.

## Test Cases

### API

| ID | Description | Tags |
|----|-------------|------|
| AUTH-001 | Health check da API de autenticação | smoke |
| AUTH-002 | Login com credenciais válidas | smoke |
| AUTH-003 | Login com credenciais inválidas | negative |
| ROOM-001 | Listar rooms disponíveis | smoke |
| ROOM-002 | Criar room com token válido | regression |
| ROOM-003 | Não criar room sem token | negative |
| ROOM-004 | Não criar room com payload inválido | negative |
| BOOKING-001 | Criar booking com dados válidos | smoke |
| BOOKING-002 | Consultar booking criado | regression |
| BOOKING-003 | Não criar booking com datas inválidas | negative |
| BOOKING-004 | Não criar booking sem dados obrigatórios | negative |

### UI

| ID | Description | Tags |
|----|-------------|------|
| UI-001 | Carregar home pública | smoke |
| UI-002 | Exibir rooms disponíveis | smoke |
| UI-003 | Abrir detalhes de um room | regression |
| UI-004 | Criar reserva pela interface | regression, e2e |
| UI-005 | Acessar tela de login admin | smoke, admin |
| UI-006 | Logar no admin com credenciais válidas | smoke, admin |
| UI-007 | Não logar com credenciais inválidas | negative, admin |
