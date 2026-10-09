Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C960451981
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549670; cv=none; b=Y2kO6kDA1qMUd8oLyqFiNHYnbflPHeovejYypqaaxgwNpY8PgxqPTLHh+1zG4FWantHGxbVp1PW9odTKHYC4f2emsGheaYDPXCK3CRVyM0+2ooOYoHWtw9Xcr0dVUdbUTe+KnOuD0DnGNhrgoUhz3bzesPzSMUlcGmZox3U1Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549670; c=relaxed/simple;
	bh=IVXR/NlPG7wOieaJBzepIEKfMf7yJLLYXMH0wukfAAw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tSnQFYmTxQHAYHdJRiWbB9KCyaea3SjlHY4qM7lx660ZI6EyEWo7hI2aqDejdG/auvzKuQ7VEdw4c4tK2r4c0SvJ8Edn8RfnGtO/7zjp16LKGwk9Bhma29eaSrfjfOzk/hGXIIjumcn/EtSYwnMPfMk22FDMeQCxsSMb0U+7OXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgmGH3X5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgmGH3X5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5A41F000FF;
	Fri,  9 Oct 2026 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549660;
	bh=cJ4L5RgkxPOjDU/QcES+mflMiuj3ZoxrW9GARYdhMp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AgmGH3X5H9euZTu1bouc7ylgsDr74W3wIcTss13RiK+P/uTMMcPZP+hDM1262K38R
	 otDpDUnCtdzjNufATn6vDsxRwngIx79aFI9K7T9hTODpmRVe+bu0RHZ2o0onqfMpzz
	 nYoeijicPPxpkR8t8Ndh+heh74xXcpow9YoIWJ/kCOn3NGgM6qg6d0b9qrs6FHTlmZ
	 +xd92rDP0Rtv6kIu81CFZU6HrWRG3JMSpXZ8WjNb0kwmRd2KAvlRscGQBTkmW1qpFi
	 KrM+Jlz5MInBd9zy2bFQgO46WHnx6UWAktsGwHptL1l45FBeYWNCtVUNf5iQl8jGyF
	 CWea9etZ8VEXw==
Message-ID: <sashiko-outbox-165552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/12] HID: asus: reinitialize the device after
 exiting a sleep state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009122820.7603-2-denis.benato@linux.dev>
References: <20261009122820.7603-1-denis.benato@linux.dev>
 <20261009122820.7603-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:40:59 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: asus: missing backlight restoration in asus_reset_resume
--

commit db57f630fbe7f986dca53a47a7465f75b0c3eaab
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: reinitialize the device after exiting a sleep state

The ROG ally needs to have the EC string sent back after resuming from
s2idle since the USB device can be turned completely off by the firmware
when mcu_powersave firmware-attribute is set to 1. This patch reinitializes
the reports upon device reset resume.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 7dc6417fe2622..1e430ddb8605b 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1379,6 +1401,9 @@ static int __maybe_unused asus_reset_resume(struct =
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

[Severity: Low]
Since this function handles device re-initialization after power is lost
during sleep (e.g., s2idle with mcu_powersave enabled), does it also need
to restore the backlight state?

Looking at asus_resume() in the same file, it explicitly restores the
keyboard backlight:

static int __maybe_unused asus_resume(struct hid_device *hdev)
{
    ...
    if (drvdata->listener.brightness_set)
        asus_kbd_backlight_set(&drvdata->listener,
                               drvdata->kbd_backlight_brightness);
    ...
}

Will the keyboard backlight remain off if the system wakes up from a sleep
state where USB device power was cut and the USB core issues a reset_resume
rather than a standard resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009122820.7603=
-1-denis.benato@linux.dev?part=3D1
