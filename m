Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF74C10D1
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547666; cv=none; b=R51wjZVhc3USRZa6IkQ7XDqwQgpgX9nP/pG7jCLxIa+U+NTYApi2/EtQSys9DqZ1/pXRO2TT/kwYoWct8FDCMShiWFuK1OilcsFH8lXIAD8eykbaxnB7ANqdYZFomGWV35Hgm9ZNm8QWuICGVSvzG+TVmZUSDcZclR/fSWe1gVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547666; c=relaxed/simple;
	bh=aHCyUK6iiGQGjCAwdsbsj8LmT18pjkgVJDlT+cJfH6c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mZR5pi6xe2xZ36HFh1IBGaAxknZ1Tb8YbIFVhSJVT2YcwnxmTnWuDHf13ohjyyh+dEknlp84BhfKksN7ZsMLGlx+2A46qqiz2R9lZCXOlcwTDR225yVa062bbVpngySA+Iix+OFZbjOCp8VQaTf7GsKY6iOOOHvYcUFlweO5xaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6CQKyLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6CQKyLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611331F000FF;
	Fri,  9 Oct 2026 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547661;
	bh=DQsXgW1R2YEXCmQ+stNzWuxpePQElGUsLoBP64627s8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6CQKyLiUMC9lVPEO1K9MJPuaTviD0z5gTrta9qGfBztZRcPd4PhaCA6OYQYQuGEh
	 veP3oOYQwg7bSSy4R5zxfqzTboOD0dCjr9ezHoQmMPcgWkQAqYNivLMPa3iZBtgPV8
	 /2gkX5KEB9WAaUpkS7/HXu2ozahkhFM2YqZ0zWCZZnjDHfG7tsDXffuJX8ti3eSSkZ
	 PepbFfPjvHcn26Hrz2iR0CvAH5XIHXbXTgwN59A5Wvm1uN9ePfPXkPMvPsmYD6p9ED
	 b0WhDBRMhVZlpQYfFS9Uux/TtbPh/ZkSzPmrx8VHjmZqoyt5QaW0gu+ygVXJOuOZcZ
	 Q77grmQvLBDHQ==
Message-ID: <sashiko-outbox-165480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] HID: asus: reinitialize the device after exiting
 a sleep state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009114921.5242-3-denis.benato@linux.dev>
References: <20261009114921.5242-1-denis.benato@linux.dev>
 <20261009114921.5242-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:07:40 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: asus: missing backlight and OOBE restoration in reset_resume
--

commit fec26e5b201c893ff8605557f1064dad33a366a5
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: reinitialize the device after exiting a sleep state

This commit adds report initialization logic when resuming from s2idle to
handle cases where the firmware completely turns off the USB device, such
as on the ROG Ally. It introduces an asus_initialize_reports() helper
called during probe and reset_resume.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index baa8589d45ae2..e6218abdac49c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1403,6 +1425,9 @@ static int __maybe_unused asus_reset_resume(struct =
hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> =20
> +	if (!drvdata->tp)
> +		asus_initialize_reports(hdev);
> +
>  	if (drvdata->tp)
>  		return asus_start_multitouch(hdev);
> =20
>  	return 0;
>  }

[Severity: Medium]
Does this miss restoring the backlight and OOBE disablement state?

When the system enters sleep and the USB device loses power, the USB PM
core will invoke asus_reset_resume() instead of asus_resume() upon waking.
While this commit adds report re-initialization here, it appears to miss
the backlight restoration and OOBE disablement.

For example, asus_resume() restores the keyboard backlight:

static int __maybe_unused asus_resume(struct hid_device *hdev)
{
	...
	if (drvdata->listener.brightness_set)
		asus_kbd_backlight_set(&drvdata->listener,
		                       drvdata->kbd_backlight_brightness);

	return 0;
}

Since asus_reset_resume() does not include this restoration, the keyboard
backlight may fail to turn back on after a hard reset or power loss during
sleep. Can we safely mirror the restore sequence from asus_resume() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114921.5242=
-1-denis.benato@linux.dev?part=3D2
