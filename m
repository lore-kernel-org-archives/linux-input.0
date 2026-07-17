Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAC2F7AD2
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264870; cv=none; b=I2Z7IfemEYuh8/v2UP5UuXlHC7n4zhpV2FXzOg0YPtA2jwdyTySfTGpWM/P8qfj1e4zwMQTs9tgU7rqUUa701fPI1/G0ya0VqBGTiazhtkarDvCgCUUxaq66vzanTvTTvQ22srodZIqY8tP+IDpdZS1h5X6TomJDhQArfmc86KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264870; c=relaxed/simple;
	bh=BkrrOCLe3Qxd/033iYhyeVsdO2qDnb2aLINH9kJEPdE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qCDU9ntA4k41YPtKlTa6wtFOiRSTDJZDozORqiODWmDmYFZ6+2H+x5L37dmBqRhfzaFXcmCtVqp8QSG1YP1XJEBR4j/MIynxXgKEqIefx5U3VrZBEGZe7X7pBVwqhAA+LqGulVhi95U6mCZ4BnSxSPNV/814uGqRBgseAH9Q7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsEJ0e6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsEJ0e6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC071F000E9;
	Fri, 17 Jul 2026 05:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784264868;
	bh=2TAQEF5y+9FesZtVTyg2KfSho5jZQzhD7DEcbb2wUTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsEJ0e6rtEDLmLAcYPWv+PJVHdZ1lm4WuFflNWL1PCDkpnFL7DJAzYvQZsfjmoHVy
	 NGtheYaRXcEo81JIBICw/ldbeyCQo4YEh1BQlAYZz1H/rRNgwT2q/DzZhui4FmA/+N
	 yOC8uux1TMsUMGyNgzmWO5cu7K45cEWw/HytoPRpJgU0bB3E54V1ho5CSx89hrx9xl
	 10ca76g3yNz5ss/pExAuqSYxNOVfsj9V963RH1T4xNWKfn2bTqkK3kk8I1WOH0jzzC
	 EF560vJ+3vAJ9//awsnCLn8DO4+mAXOXMvazyOgELKLiWps+K1MWHxnflxOJpzYvES
	 6l1VP8WJIxKWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: uinput/uhid - disallow control characters in
 phys paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Hutterer" <peter.hutterer@who-t.net>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
References: <20260717-wip-uinput-sanitize-phys-v1-1-f6459542ce4b@who-t.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:07:47 +0000
Message-Id: <20260717050748.5DC071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch provides an incomplete mitigation for CVE-2026-50292. It=
 sanitizes the `phys` property to prevent udev property injection via contr=
ol characters (newlines), but completely fails to sanitize the `name` and `=
uniq` properties, which are also exported to uevents and controlled by user=
space.
--

--- Patch [1]: [PATCH] Input: uinput/uhid - disallow control characters in =
phys paths ---
commit 1a76e90e7acc09a84a52efddc46e598419020a19
Author: Peter Hutterer <peter.hutterer@who-t.net>

Input: uinput/uhid - disallow control characters in phys paths

This commit sanitizes the phys property in uinput and uhid devices to repla=
ce
control characters with '?'. This prevents userspace from injecting malicio=
us
udev properties via newlines, which previously triggered CVE-2026-50292.

> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 37b60c3aaf66a..baf1fe8290f75 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -518,6 +518,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>  	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
>  	BUILD_BUG_ON(sizeof(hid->phys) !=3D sizeof(ev->u.create2.phys));
>  	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> +	input_sanitize_phys(hid->phys);
>  	BUILD_BUG_ON(sizeof(hid->uniq) !=3D sizeof(ev->u.create2.uniq));
>  	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));

[Severity: High]
This isn't a bug introduced by this patch, but while this successfully miti=
gates
CVE-2026-50292 for the phys property, does it still leave the name and uniq
properties vulnerable?

In uhid_dev_create2(), the user-controlled ev->u.create2.name and
ev->u.create2.uniq strings are copied directly without passing through a
similar sanitization function.

Additionally, in drivers/input/misc/uinput.c:uinput_dev_setup(), the name
property is also set without sanitization:

    dev->name =3D kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);

If a user with write access to /dev/uinput or /dev/uhid sets the name or un=
iq
properties to strings containing newlines, wouldn't this still allow the
injection of arbitrary udev environment variables when INPUT_ADD_HOTPLUG_VAR
formats them for uevents?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-wip-uinput=
-sanitize-phys-v1-1-f6459542ce4b@who-t.net?part=3D1
