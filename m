Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4663BFAEE
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027766; cv=none; b=jKTytv8WqHVt+9UdAFGjs5R/gR4tQGrOu9XDHqhRPnOT+iqt8gHS6fgTS/fVm5VJvt4jtgT1+10B9u5VwmKYoTedbMdvn4F/O0v9ey+MR+2n24bhER1hGVZpNH6rF9Mo518+iMf210cPmCzsCedj2k5rCC66UC482Ut4W00NUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027766; c=relaxed/simple;
	bh=UoMMXpuohfl3dOzLGjXCC5E5g4QE5okvOv27Kkq4V5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGLoxt06c81gR+x/l9sdF14UKn7xC0MT+6qJA5uSxE+5sSXyDWHDoY6ruxZUfac/kOsGGXZfPlAUYGMjXZVcJWhLGyL1v7ntFcHZEnI88qBncNvrF4CjpatZxCXqtZOarDq4kuwsRPW6iPpvQZWTrS9TMB7rIuRt08Ti7WqEfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mljgGpb+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mljgGpb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CA4C2BCB8;
	Sun, 17 May 2026 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027764;
	bh=UoMMXpuohfl3dOzLGjXCC5E5g4QE5okvOv27Kkq4V5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mljgGpb+02cQk0Qm84zwMk7kZmsJe6a9r7uQt4iwZ32QjMB6D89zlq1hC2/xhfKoM
	 2ZULPqyZetpKeXISXPJpMEE8y1jAcBBJMxpgC3I2qNHoTQQiYbKMziBFlVtIKS2Iot
	 qVchnQaSXVQWMo95o+Mq/Fc0un/ZJ2x2jCAVIOGvVzccGL4rwmfqnUE4k1jjC/+/N4
	 a1HKBx32eD9H3apwE454HcAEpOJfOsWOQ2IL4Z6KPDge048DLtVZGiqaRc+6NtXqZR
	 4Vh22kIMHSudxy1rR8QxM0m+zWB+uEAJT5WBdbbkROG85IQzT1KXh2GnHNXkqDlXTL
	 BO0p4OI/J0ORQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: wacom: validate report length for PL and PTU
 handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260517135215.2220117-2-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-2-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 14:22:43 +0000
Message-Id: <20260517142244.A8CA4C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete Fix / Unhandled OOB Reads for Multiple Device Types
--

commit 4ac677c30d7590ff24c2b6674eafbe8d0fff6898
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: validate report length for PL and PTU handlers

This commit adds minimum length checks before dispatching HID reports to
the PL and PTU handlers. This prevents slab-out-of-bounds reads when a
malicious device sends an artificially small report.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..6d06842b64080 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3453,6 +3453,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, siz=
e_t len)
>  		break;
> =20
>  	case PL:
> +		if (len < 8)
> +			return;
>  		sync =3D wacom_pl_irq(wacom_wac);
>  		break;
> =20

[ ... ]

> @@ -3464,6 +3466,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, siz=
e_t len)
>  		break;
> =20
>  	case PTU:
> +		if (len < 8)
> +			return;
>  		sync =3D wacom_ptu_irq(wacom_wac);
>  		break;
> =20

While this successfully prevents out-of-bounds reads for PL and PTU devices,
do other handlers called from wacom_wac_irq() remain vulnerable to the same
issue?

For example, wacom_graphire_irq() unconditionally accesses data[8] for
WACOM_MO:

wacom_wac_irq()
  wacom_graphire_irq()
    case WACOM_MO:
      prox =3D (data[7] & 0xf8) || data[8];

Similarly, wacom_remote_irq() ignores its len argument and accesses up to
data[12], and wacom_intuos_pro2_bt_battery() can access data[284].

If a device spoofing these other types sends an undersized report, could it
bypass the checks added here and still trigger a slab-out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517135215.2220=
117-1-jinmo44.yang@gmail.com?part=3D1
