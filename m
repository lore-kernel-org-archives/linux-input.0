Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BA3769E5
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436703; cv=none; b=Nvgced0ZYUj+zzjRJUNAbHOWATZMXXSZymY0sfJkuEHicrixFAuHiLWVyZhbtFECCMO3Hrfc3uR3kxvvPdTW+ZyOtJQuzXWyRVjB2fRNiMZHxAd+wUxzURl5KeUs/P0MMVRe7GNWFL977Ms1DAV7IgdLNGz/v6/iITGjODlZciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436703; c=relaxed/simple;
	bh=Tngbnkf8fnYAdvYFlxVBlk28TXPbJiuKKxD3YNUl3cA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2gbFe7m+MkiDnvJ4YMCqvQ8XEFmlyYTH5hdEVByE1ZCfjRnJGLDelQq9331/9sznl+N1Ptlkpm+sIonHDpmtbX6dEJZ0v2CYdcXKYa4aHuBkvkDqXFuK5NT0cZnQTDasAGU0Wbq+BuF0ferlRTsKqDbn7UrRLJ961sws31YWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCfzuaBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCfzuaBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3C21F00A3D;
	Tue,  7 Jul 2026 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436701;
	bh=bCNcrNrzUH08jpTqK9FRt9qxxBIWNRdR/sNDLLh/2Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCfzuaBHKXwghO2nmv8Ogt1rcKh493FN2tkfyEDVTbzvc6lO1lD6d1kb0437ajpUa
	 dvqHT2GeJ7IlHdKsyaWl8SRtllCaVv8Kq2yuEdEmO66WwWrKllxg8DB3b40a2G0/bk
	 kj0uQdyM69ekB5Fb0+SwWybuKn1f5itnXAqpnmUW/JKQvzwMbs0k20ssmr4Y6s1ggR
	 azYIrcMwtOvd3oBhzPG749EvPgJCL7BqLnUY9q3Qj6lE39dqnIrL4eLzw6BggFlrQk
	 J/KGf6OaOXVG/JaZoA95TWbDIIfFgnMkoX2emjb887i3gsVT8d7sCE3e5yfL1czdPq
	 gioRXWFsUykNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] HID: hid-oxp: Replace system_wq with
 system_dfl_wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Crivellari" <marco.crivellari@suse.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260707145327.313292-2-marco.crivellari@suse.com>
References: <20260707145327.313292-1-marco.crivellari@suse.com>
 <20260707145327.313292-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:05:01 +0000
Message-Id: <20260707150501.BB3C21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver uses a single global statically allocated LED class=
 device, causing list corruption and state clobbering if multiple matching =
devices are connected.
- [High] Inadequate teardown of delayed works causes Use-After-Free vulnera=
bilities during device removal and probe failures.
- [High] Handling a GEN2 status event unconditionally dereferences `drvdata=
.led_mc`, which is NULL on hybrid MCU devices.
- [High] The driver blindly accesses HID event data without validating the =
`size` parameter, leading to out-of-bounds reads.
--

--- Patch [1]: [PATCH RFC 1/2] HID: hid-oxp: Replace system_wq with system_=
dfl_wq ---
commit 17346571c8ccd09d42318cd808c4c65570f51a89
Author: Marco Crivellari <marco.crivellari@suse.com>

    HID: hid-oxp: Replace system_wq with system_dfl_wq
   =20
    The function end up calling __queue_delayed_work(), which set a global
    timer that could fire anywhere, enqueuing the work where the timer fire=
d.
   =20
    Unbound works could benefit from scheduler task placement, to optimize
    performance and power consumption.
   =20
    Since the workqueue work doesn't rely on per-cpu variables, there is no
    obvious reason that justify the use of a per-cpu workqueue. So change t=
he
    workqueue with the new unbound version, system_dfl_wq.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 20a54f337220d..d2ded6b08ce9e 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -398,7 +398,7 @@ static int oxp_hid_raw_event_gen_2(struct hid_device =
*hdev,
>  	 * Re-apply our settings after this has been received.
>  	 */
>  	if (data[3] =3D=3D OXP_EFFECT_MONO_TRUE) {
> -		mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50=
));
> +		mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init, msecs_to_jiffie=
s(50));

[Severity: High]
This isn't a bug introduced by this patch, but does the driver validate the
size parameter before accessing data[0] or data[3] in this function?

It appears that if a device sends a smaller report than expected, we could =
hit
an out-of-bounds read when checking data[3] or when dumping OXP_PACKET_SIZE
bytes in oxp_hid_raw_event().

[Severity: High]
This is a pre-existing issue, but is it possible for drvdata.led_mc to be N=
ULL
here?

If oxp_cfg_probe() jumps to skip_rgb for hybrid MCU devices, drvdata.led_mc
is left uninitialized (NULL). If the device later sends a GEN2 status event,
this function eventually does:

    led_mc->led_cdev.brightness =3D rgb_rep->brightness / 4 * ...

Could this cause a NULL pointer dereference on hybrid devices?

>  		return 0;
>  	}
> =20
[ ... ]
> @@ -1349,7 +1349,7 @@ static void oxp_rgb_brightness_set(struct led_class=
dev *led_cdev,
>  				   enum led_brightness brightness)
>  {
>  	led_cdev->brightness =3D brightness;
> -	mod_delayed_work(system_wq, &drvdata.oxp_rgb_queue, msecs_to_jiffies(50=
));
> +	mod_delayed_work(system_dfl_wq, &drvdata.oxp_rgb_queue, msecs_to_jiffie=
s(50));

[Severity: High]
This is a pre-existing issue, but can this delayed work cause a use-after-f=
ree
during device removal?

Because oxp_hid_remove() uses cancel_delayed_work() instead of the synchron=
ous
cancel_delayed_work_sync(), the work might still be running. Also, when dev=
res
unregisters the LED classdev after remove() finishes, the LED core calls th=
is
function, which unconditionally re-arms the workqueue.

Could the workqueue execute after devres has freed memory structures, leadi=
ng
to a use-after-free?

>  }
> =20
[ ... ]
> @@ -1502,7 +1502,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u=
16 up)
>  	drvdata.rumble_intensity =3D 5;
> =20
>  	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> -	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50)=
);
> +	mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies=
(50));
> =20
>  	ret =3D devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
>  	if (ret)

[Severity: High]
This isn't a bug introduced by this patch, but if devm_device_add_group()
fails here, the probe function returns the error directly.

Does this leave the oxp_mcu_init delayed work scheduled, potentially causin=
g a
use-after-free if the work runs after the device and its devres allocations
have been freed?

[Severity: Critical]
This is a pre-existing issue, but does oxp_cfg_probe() register a single
globally statically allocated led class device?

Earlier in oxp_cfg_probe():

    ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &oxp_cdev_rgb=
);

Since oxp_cdev_rgb is statically allocated, if multiple matching HID devices
are connected, we will call devm_led_classdev_multicolor_register() multiple
times with the same pointer. Could this corrupt the LED subsystem's internal
linked list and cause a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707145327.3132=
92-1-marco.crivellari@suse.com?part=3D1
