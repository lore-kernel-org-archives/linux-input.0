Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A617B506
	for <linux-input@vger.kernel.org>; Sat, 16 May 2026 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778912501; cv=none; b=EaJgxcXG2/vHsLpuYYqZw07wLkjI0UUhBrTGuOB2XtWKtBivqUGQZIUrXdyNP0R526o7CmygquezDAZXpKgNQ+RWeCRg+NnDpNpkJQivbMxm8dBSniwHoyGU8SMNr4qmduYKxohO1C/9+WdILecZr/VRQdOZ3mDSBP2t1h2qD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778912501; c=relaxed/simple;
	bh=941Boe63nI5hcehCJLpa088Ja3zgBnMigr6b+IWVQIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HqWCW+dODWwxGbEm3WjKCXmmmFbG8nb4vmceq1Rr/5ZLFT2hE01cofcWgFr/Zfd3xJ8qFqERtJr41ARIii8sNVKs7ElQKN31mZ1+QAhKS/WUhrfspw3PAW0sMxwis5snz+hwuWLimvQfT/OOQSpBAz55tAx5CXDPeBbb8Bw0gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/nyOYFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/nyOYFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D9C19425;
	Sat, 16 May 2026 06:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778912501;
	bh=941Boe63nI5hcehCJLpa088Ja3zgBnMigr6b+IWVQIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S/nyOYFbRW/KbwGzM9yPdupsx84yBWLEtt2vypw7V5fYpyUF8G+spxVA6eg6HUTuz
	 ceS1N845OE5rjjii0vtqRt89cXaUSifQfEJnVM2jkdWftE7WqnvBJ9eoNigrs3KxTx
	 fkG+EeWtJXCvtphD7cxKPWDBCVMToENnZronA/7ttm2ikfLr6XLUhuFytBGU1uCdVr
	 kE/Nl57xYBawcCKg6ZcbFpBbF1fhV979qXYu60qLAqarQEeC1xeVJ/oqMPMbpHWOlw
	 1ZF74BjT3tSpWEm/4S0mEXRkxTdSxXKC2k21S5+W6W9qMhCydrS4KIQ0Fy0Tk9S50G
	 fiON3grP5jRhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260516042841.500299-5-derekjohn.clark@gmail.com>
References: <20260516042841.500299-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 06:21:41 +0000
Message-Id: <20260516062141.822D9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] State machine desynchronization and data corruption due to lockles=
s `profile_pending` and lack of request sequence verification.
- [Medium] Undocumented and broken modification to button mapping functiona=
lity.
- [Medium] Data race on `rumble_intensity_left` and `rumble_intensity_right=
` variables due to inconsistent locking.
--

commit e2268bfaf4019b28116f3a16f5112af6d91c10d6
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

This commit adds sysfs attributes to adjust the left and right rumble
intensity for MSI claw devices.

> Adds intensity adjustment for the left and right rumble motors.

The commit message states this patch only adds intensity adjustment for the
left and right rumble motors, but it introduces undocumented changes to the
button mapping functionality.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
> @@ -234,6 +236,7 @@ static const struct {
>  	{ 0xcc, "BTN_EXTRA" },
>  	{ 0xcd, "REL_WHEEL_UP" },
>  	{ 0xce, "REL_WHEEL_DOWN" },
> +	{ 0xff, "DISABLED" },
>  };

[ ... ]

> @@ -678,6 +695,9 @@ static const char *button_mapping_code_to_name(u8 cod=
e)
>  {
>  	int i;
> =20
> +	if (code =3D=3D 0xff)
> +		return NULL;
> +

Does this logic prevent the newly added "DISABLED" mapping from ever being
returned? By explicitly returning NULL here, will callers print "(null)" to
userspace instead of the intended "DISABLED" string?

[ ... ]

> @@ -400,6 +411,12 @@ static int claw_profile_event(struct claw_drvdata *d=
rvdata, struct claw_command_
>  			drvdata->led_mc.subled_info[2].intensity =3D frame->zone_data.zone[0]=
.blue;
>  		}
> =20
> +		break;
> +	case CLAW_RUMBLE_LEFT_PENDING:
> +		drvdata->rumble_intensity_left =3D cmd_rep->data[4];
> +		break;
> +	case CLAW_RUMBLE_RIGHT_PENDING:
> +		drvdata->rumble_intensity_right =3D cmd_rep->data[4];
>  		break;

Are these assignments exposed to a data race?

This function updates the rumble intensity variables asynchronously without
holding any locks. However, the variables are read and written elsewhere
using entirely different locks:

rumble_intensity_left_store():
    guard(mutex)(&drvdata->rom_mutex);
    ...
    drvdata->rumble_intensity_left =3D val;

rumble_intensity_left_show():
    guard(mutex)(&drvdata->profile_mutex);
    ...
    return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_left);

Additionally, is there a risk of cross-talk if a delayed hardware ACK arriv=
es
after a timeout?

If rumble_intensity_left_show() times out while waiting for
claw_hw_output_report(), it resets profile_pending to CLAW_NO_PENDING and
drops profile_mutex. The hardware command is not aborted.

If rumble_intensity_right_show() is subsequently called, it sets
profile_pending to CLAW_RUMBLE_RIGHT_PENDING.

If the delayed left motor ACK arrives at this exact moment, it appears
claw_profile_event() will observe CLAW_RUMBLE_RIGHT_PENDING.

Since this function does not verify the response address for rumble
requests, could it incorrectly assign the incoming left motor data to
drvdata->rumble_intensity_right?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516042841.5002=
99-1-derekjohn.clark@gmail.com?part=3D4
