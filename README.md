# Text Generation Stack (OCI Resource Manager) – Auto User & Groups

A one-click **OCI Resource Manager** (ORM) stack that prepares identity and guardrails for Gen‑AI / Text Generation projects:
- (Optional) **Project Compartment**
- **Two IAM Groups** (e.g., GenAI Admins & GenAI Users)
- **OCI IAM User** (auto‑created) with optional email + description
- **Policies** granting the groups/user access as defined in the stack

> ✅ Terraform files are already structured for ORM. Commit them to a public GitHub repo and use the **Deploy to Oracle Cloud** button below.

---

## Deploy with One Click

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/ou-developers/GenAI-TextVisual-Sandbox-Stack/archive/refs/heads/main.zip)

**Alternative (no tag yet):**
```
https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/SaurabhOCI/GenAI-Text-Visual-Sandbox/archive/refs/tags/GenAI-Text-Visual-Sandbox.zip
```

> Tip: Open your `zipUrl` in an **incognito** window—the link must download a `.zip` with no login prompt. Make sure your `.tf` files are committed at the **repo root** of that tag/branch.

---

## Prerequisites

- OCI tenancy + permissions to create **Resource Manager** stacks and Identity resources (Compartment, Groups, User, Policies).
- Your **Tenancy OCID** and **Deployment region** (you’ll choose region in Console).
- (Optional) Email address for the new user.
- (Optional) If you need custom tags, prepare your tag keys/values.

---

## Inputs (common variables)

> See `variables.tf` and `variables_user.tf` for full list. Typical variables include:

- `tenancy_ocid` *(string, required)* – Your tenancy OCID.
- `region` *(string, required)* – Target region (e.g., `ap-mumbai-1`).
- **Compartment options**
  - `create_compartment` *(bool, default: true)*
  - `project_compartment_name` *(string)*
  - `project_compartment_description` *(string)*
- **Groups**
  - `create_groups` *(bool, default: true)*
  - `genai_admin_group_name` *(string, default suggestion: `GenAI-Admins`)*
  - `genai_user_group_name` *(string, default suggestion: `GenAI-Users`)*
- **User (auto‑create)**
  - `user_name` *(string, required)* – Login/username for the new IAM user.
  - `user_email` *(string, optional)* – For notifications / identity email.
  - `user_description` *(string, default: "Created by ORM stack")*
- **Tagging (optional)**
  - `enable_tagging` *(bool)*, `project_tag` *(string)*, `common_freeform_tags` *(map(string))*

> Names and booleans above match what this stack expects. Adjust defaults to your policy/namespace conventions.

---

## Optional: Prefill values in the button

Append `zipUrlVariables=` with **URL‑encoded JSON** (leave `region` out if you prefer choosing it in Console). Example:

**JSON:**
```json
{
  "create_compartment": true,
  "project_compartment_name": "genai-textgen",
  "create_groups": true,
  "genai_admin_group_name": "GenAI-Admins",
  "genai_user_group_name": "GenAI-Users",
  "user_name": "genai.stack.user",
  "user_email": "user@example.com",
  "user_description": "Created by Quick-Create"
}
```

**URL‑encoded to append:**
```
&zipUrlVariables=%7B%22create_compartment%22%3Atrue%2C%22project_compartment_name%22%3A%22genai-textgen%22%2C%22create_groups%22%3Atrue%2C%22genai_admin_group_name%22%3A%22GenAI-Admins%22%2C%22genai_user_group_name%22%3A%22GenAI-Users%22%2C%22user_name%22%3A%22genai.stack.user%22%2C%22user_email%22%3A%22user%40example.com%22%2C%22user_description%22%3A%22Created%20by%20Quick-Create%22%7D
```

---

## What this stack creates

- **Compartment** (when `create_compartment = true`).
- **Groups** for admins and users (when `create_groups = true`). Membership of the new user can be added per policy or post‑create.
- **Policies** granting appropriate permissions to the groups for your project scope.
- **IAM User** created with the provided name/email/description. Retrieve credentials out‑of‑band as per org policy.

> Exact resources are defined in: `compartment.tf`, `groups.tf`, `policies.tf`, `identity_user.tf`, and outputs in `outputs.tf`, `outputs_user.tf`.

---

## Outputs

Open the **Outputs** tab after Apply. Common outputs include:
- Compartment OCID (if created)
- Group names/OCIDs (admins/users)
- IAM User name/OCID (if created)

---

## Post‑Deploy: Verify

- **Identity → Users**: new user exists and email/description are set.
- **Identity → Groups**: admin/user groups exist; add members as needed.
- **Identity → Policies**: policies compiled/applied without errors.

---

## Clean Up

1. In ORM → your stack → **Jobs**, run **Destroy**.
2. Delete the stack (and any manual leftovers if you created resources outside the stack).

---

## How to publish this repo (quick Git steps)

```bash
# inside the folder with these .tf files at top level
git init
git add .
git commit -m "Initial: Text Generation identity stack (auto user & groups)"
git branch -M main
git remote add origin https://github.com/<your-username>/<your-repo>.git
git push -u origin main

# make a stable tag for the Deploy button
git tag -a v1.0.0 -m "Initial release"
git push origin v1.0.0
```
Now your Deploy button (above) works against that tag archive.
