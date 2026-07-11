Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0962F39C7
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755675; cv=none; b=m8cLNpZSDHu46IVHgD4vWRhzlotwYjlYDMeUcXEvxb/ThbJgihDcaKo8a8oGRzQsccAD2E6o6SWn1uK06r47n1yUhYBpLYDcpQXCOQQU4pP0xm4rhvND2izA4zwwlzNrlsogT/3rfX80mIkqzM2vupSfRlcJoVmiZXsrYgwAv2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755675; c=relaxed/simple;
	bh=DlEMRGq1cTQTHgR2xcjieIp660mOTJyRSRx41syk8lI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JgZdpBfey7xOf2cixHHNVn3+9jplKjMh9hAse04QhfhUHOaPPxEoqeb6CmskG6gn2q3wTbIEF1wCtoAlbx5/MMFvtNvRjWZYkBpz86p2OKglpGhbzQAfT9GSnZL9Y7JUg2jq8uTu464tAGMYyz001UNyd+OK4RCC+zeFDBWBfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzH/lkWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzH/lkWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B8A1F000E9;
	Sat, 11 Jul 2026 07:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783755674;
	bh=t//ZvP+LlcjuQEQCRapTDwh90mvIbolw26qcf1QR/9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzH/lkWgNML8TzrWk6RioRYlNHDsnSv5xi/PVqkJIAjOOkOrX1qiyQZ3cVLFwhVdZ
	 V60+vOyALjd6Rh6wZ5SlekP9xfSKfwr3KmJ86XBdzF0A/d40STUdEcnMvHDnw9hEHf
	 Uk6KuFfoJfgPxsRvn9l3tdAxAzbCsCpGkf3TjVdPJwt38f0w+rzJmcjUHVFfRNwqfv
	 jnEBN6EradA0TfDTIF440OapGfA/+/8Zjg0RUkGRlhrujVZ2Y2euxmn+RHS7TYhLMo
	 WfZR4oAE6m1sOzOXLnzXZRJvTqDpNwolCw9le4dVFiqD9G70D6jzotJWjzkLBCAgL4
	 4k+op7+/oCa/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: uclogic: fix UAF on inrange_timer at driver unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711073003.71012-1-doruk@0sec.ai>
References: <20260711073003.71012-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 07:41:13 +0000
Message-Id: <20260711074114.32B8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Moving timer_shutdown_sync() after hid_hw_stop() introduces a =
Use-After-Free of drvdata->pen_input during driver unbind.

Pre-existing issues:
- [Critical] Missing timer cancellation in the uclogic_probe() error path l=
eads to a Use-After-Free if initialization fails after I/O has started.
--

--- Patch [1]: [PATCH] HID: uclogic: fix UAF on inrange_timer at driver unb=
ind ---
commit 0de50e5b91e3a9978c96d85e0aab45d43b0d98d6
Author: Doruk Tan Ozturk <doruk@0sec.ai>

HID: uclogic: fix UAF on inrange_timer at driver unbind

uclogic_remove() drained the in-range emulation timer before calling
hid_hw_stop(), leaving a window where a completing pen report could
re-arm the timer. This commit reorders the operations to call
hid_hw_stop() first, preventing re-arming before shutting down the timer.

> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> index b73f09d26688a..c440013a609fd 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -548,8 +548,8 @@ static void uclogic_remove(struct hid_device *hdev)
>  {
>  	struct uclogic_drvdata *drvdata =3D hid_get_drvdata(hdev);
> =20
> -	timer_delete_sync(&drvdata->inrange_timer);
>  	hid_hw_stop(hdev);
> +	timer_shutdown_sync(&drvdata->inrange_timer);

[Severity: Critical]
Can moving timer_shutdown_sync() after hid_hw_stop() introduce a
use-after-free on drvdata->pen_input?

hid_hw_stop() synchronously unregisters and frees the standard input
devices, which frees the memory pointed to by drvdata->pen_input.

If an incoming report arms the timer just before hid_hw_stop() is called,
the timer will remain active.

When it fires, the callback will unconditionally dereference the freed
pointer:

drivers/hid/hid-uclogic-core.c:uclogic_inrange_timeout()
	struct input_dev *input =3D drvdata->pen_input;

	if (input =3D=3D NULL)
		return;
	input_report_abs(input, ABS_PRESSURE, 0);


[Severity: Critical]
This is a pre-existing issue, but can the uclogic_probe() error path
also lead to a use-after-free if initialization fails?

If hid_hw_start() briefly starts hardware I/O but subsequently fails
internally, an incoming report could trigger uclogic_raw_event_pen() and
arm the timer before the error path is taken:

drivers/hid/hid-uclogic-core.c:uclogic_probe()
	rc =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
	if (rc) {
		hid_err(hdev, "hw start failed\n");
		goto failure;
	}

	return 0;
failure:
	/* Assume "remove" might not be called if "probe" failed */
	if (params_initialized)
		uclogic_params_cleanup(&drvdata->params);
	return rc;

Because this cleanup block does not cancel the inrange_timer, the devm
framework will free the drvdata structure upon probe return.

This leaves the timer armed to execute on freed memory.

>  	kfree(drvdata->desc_ptr);
>  	uclogic_params_cleanup(&drvdata->params);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711073003.7101=
2-1-doruk@0sec.ai?part=3D1
