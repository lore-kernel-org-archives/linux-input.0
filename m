Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9E484236
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632910; cv=none; b=IJQNXgMj0p/g96JFbk7542/PPpjb6oBJFSvtSY/2f8mYOFX84MeObGCmgKs+tDB9CrVcMAoB0pScUlmv2G9pzk8lZTjD2RUAk4xNGHdsdP2LombOEH9WeZkwRJXpUgWMxe6NyHGkDXBIaD+vJGGcb757Iif1aYW/N8TdOrn6muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632910; c=relaxed/simple;
	bh=HldqrYl0kyaX77/rlIEMt+RcQL0rmepee0zp6awzb/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bH6Mm0JYkjav6uOEyaZLPq9aV8jg4tGO0PG35/yVkcVNoqNA2vWYw9eBRREIbL99Sy1ylQkS2CWAox1o3EQMtqzoXImF24ZD+OgIzR0LK3S+uyH6pU1ppZWNo4jxAPkJhIoOywlM2GVO+3vWVPC8VlfgZMY0xhA9152WvEZ+c2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/6gg67V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/6gg67V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFED1F00A3A;
	Thu, 13 Aug 2026 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786632908;
	bh=5LDxHiGllzdGlkRC9kYUN5i9v1/DwMP6RyxuSChK3PI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/6gg67VVEgQ8G/Ql4b+GyuSDUoff1pyYKMJsC6+cDSn7g2rI6VP8ImPI/G0kdsxx
	 Kzpx94lZV2QSGv5O4TQomMTj4sKOJlGaLE2wO38fAyCTq675pMf/SDB4Z/Y0DKp6xx
	 bZzdH4rnuuPEud/Z0+2kr0M0z+yNa9DncwCWQMwfqTcd/ACBALd7syykt7yJLOD9vG
	 /PaU4o1uAAGYywpAc2lKM0814MT39envVi79XNy35LRzDsA26eH9eLY/5nJag75y4P
	 ztlV4/cwJXj5f9f1wQX7HOP+PIwuE5+Jv1L+nhX7F+W0MRz77Uwkpj107QwmkLpHiS
	 +6L0/Tc9EQeVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] HID: asus: reinitialize the device after exiting
 a sleep state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-2-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:55:07 +0000
Message-Id: <20260813145508.2EFED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added error handling blocks in `asus_probe()` and `asus_r=
eset_resume()` are completely dead code because `asus_initialize_reports()`=
 unconditionally returns 0.
--

--- Patch [1]: [PATCH 01/12] HID: asus: reinitialize the device after exiti=
ng a sleep state ---
commit 0ca493a924cc77202a10af1860055debe0b725bc
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: reinitialize the device after exiting a sleep state

This patch extracts keyboard initialization into a helper function and
calls it during reset resume, ensuring devices like the ROG ally have
their EC string sent back after s2idle.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1360,6 +1360,22 @@ static int asus_start_multitouch(struct hid_device=
 *hdev)
>  	return 0;
>  }
> =20
> +static int asus_initialize_reports(struct hid_device *hdev)
> +{
> +	int ret;
> +
> +	for (int r =3D 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> +		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> +			ret =3D asus_kbd_init(hdev, asus_report_id_init[r]);
> +			if (ret < 0)
> +				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> +					 asus_report_id_init[r], ret);
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
Does this helper function need to return the error code?=20

Because it unconditionally returns 0, the error codes captured in the ret
variable from asus_kbd_init() are dropped after the warning is printed.

>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret;
> +
> +	ret =3D asus_initialize_reports(hdev);
> +	if (ret) {
> +		hid_err(hdev, "Asus initialize reports failed: %d\n", ret);
> +		goto asus_reset_resume_err;
> +	}

[Severity: Low]
Since asus_initialize_reports() unconditionally returns 0, does that make
this error path dead code?=20

If the intent was to abort on initialization failure, should the helper ret=
urn
the error code instead?

[ ... ]

> @@ -1493,13 +1518,10 @@ static int asus_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		return ret;
>  	}
> =20
> -	for (int r =3D 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> -		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> -			ret =3D asus_kbd_init(hdev, asus_report_id_init[r]);
> -			if (ret < 0)
> -				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> -					 asus_report_id_init[r], ret);
> -		}
> +	ret =3D asus_initialize_reports(hdev);
> +	if (ret) {
> +		hid_err(hdev, "Asus initialize reports failed: %d\n", ret);
> +		goto err_stop_hw;
>  	}

[Severity: Low]
Similar to the check in asus_reset_resume(), is this error handling reachab=
le?

The original code in asus_probe() only printed a warning on failure and
continued, so returning 0 preserves the old behavior, but it leaves this new
goto err_stop_hw path inaccessible.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D1
