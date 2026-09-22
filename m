Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11993FB7E0
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120712; cv=none; b=HLVgfHqTAkxnuO9bk4yklWEuiDfyweK/KVRmgXKoKTaghIx/xU1HHRSgkFdFGAEdo0Mam9WvHl1xQu7eA6e6z7Il8xZ+AglWFUBnWLkVmUekbLgUn5ZIiQ+egSLUip1FnKTR7PZyAc3fDtRgpaYoUpMc4NkFh55qr3Pb1dPXmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120712; c=relaxed/simple;
	bh=b77xzAGwiGhnI14qisyopcfTKc56AC4ZXQM41srFV/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqJlcxg7qEdnKg2CVRjn7e+2h18Iy4ki97pcFC8S2gLkV6ffG3nDo/OO+rsDlALWa93U8+y/1JyFvzIiBJ1ea66cWNzjSzNQ/Wlz7cO07MFR+WU6vyzmrllJbzBYbCfZcA6K7gKQfykR/6MT+kMx8MehtKwFj+SGHkNuAjgY8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gawF8CMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gawF8CMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D23B1F000FF;
	Tue, 22 Sep 2026 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790120711;
	bh=kIeeTX59tXJuMLisOff5etNhQbIV8brHksUlNek5FSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gawF8CMtUpfMC9/5rwGuSVK6S/Uoj0u9WmUCj29jINqnDws+Lcy3D239Myb21axlY
	 J3O3EWGzjEuTt4yuAozW4mbE4j5jF1u79h/2JvJ5q0Uahy4oc4IMuKRQX4bbjpG1Sr
	 QTzuQM2ST1tO8PI3E1E32Cu5vRXfajltZiPRbwDlx9wSn1elMp04a6/5lozTFryKlk
	 L0prW4aSetnLUZzzmZ2+KgwJqNDu+6xF4NxOI/IGLmK44RKUxMeQ5+c0G3dQilDJX2
	 IwdrNJey7msoymaX29QkzHnmHhIeZ9gQ0/DG2k2eRsXFe7s4KpAW39gvLlWAZD8knk
	 Cc0ZS0+9qSLVQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH V2] Input: elan_i2c_smbus - resend ENABLE_TP on wake
 from sleep (NOT TESTED, NEEDS TESTER!) (v2: typo fixes)
Reply-To: sashiko-reviews@lists.linux.dev
To: "R. Larocque" <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922233549.10431-1-rlarocque@disroot.org>
References: <20260922233549.10431-1-rlarocque@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 23:45:10 +0000
Message-Id: <20260922234511.5D23B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: elan_i2c: ENABLE_TP command sent after set_mode() may clo=
bber absolute mode
--

commit 37faf4759d30c6532910d41f48a2708415776398
Author: Rapha=C3=ABl Larocque <rlarocque@disroot.org>
Input: elan_i2c_smbus - resend ENABLE_TP on wake from sleep (NOT TESTED, NE=
EDS TESTER!) (v2: typo fixes)

This commit updates elan_smbus_sleep_control() to resend the
ETP_SMBUS_ENABLE_TP command when waking the controller from sleep.

> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/e=
lan_i2c_smbus.c
> index 0287441cda46d..dd86bd1739c55 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -93,10 +93,25 @@ static int elan_smbus_set_mode(struct i2c_client *cli=
ent, u8 mode)
> =20
>  static int elan_smbus_sleep_control(struct i2c_client *client, bool slee=
p)
>  {
[ ... ]
> +	/*
> +	 * The controller stops touch reporting while asleep; resend
> +	 * ETP_SMBUS_ENABLE_TP on wake, mirroring what is done during
> +	 * elan_smbus_initialize(), so that reporting actually resumes.
> +	 */
> +	error =3D i2c_smbus_write_byte(client, ETP_SMBUS_ENABLE_TP);

[Severity: Medium]
Could this clobber the absolute mode configuration for non-ASUS devices?

Looking at __elan_initialize() in drivers/input/mouse/elan_i2c_core.c,
non-ASUS devices first configure absolute mode via set_mode(), and then
call sleep_control() to wake the device:

	data->mode |=3D ETP_ENABLE_ABS;
	error =3D data->ops->set_mode(client, data->mode);
	if (error) {
		...
	}

	if (!woken_up) {
		error =3D data->ops->sleep_control(client, false);
		...
	}

Since this patch now sends ETP_SMBUS_ENABLE_TP in sleep_control() on
wake, it gets transmitted after set_mode() for these non-ASUS devices.
Could sending this command after configuring absolute mode reset the
hardware to its default relative mode, breaking absolute touch reporting?

> +	if (error) {
> +		dev_err(&client->dev,
> +			"failed to re-enable touchpad after wake: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922233549.1043=
1-1-rlarocque@disroot.org?part=3D1
