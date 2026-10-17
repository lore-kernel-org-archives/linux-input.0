Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EA1C861D
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202622; cv=none; b=Pes3wYIxpKg0S0DP4bBYsvTnu80F9yyKmeWAODo39HxDTHnyrIeyYv6YFRiQczA9iQxpn7eNSt03R0XtrB9Gi1va/6eaFFVTvloeH4SA5lzdB8zWmWjCuI7Om9wjASqFsgBc49HmrCA58lHAHn798R/H0+tJ/s9s/ZL//kClpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202622; c=relaxed/simple;
	bh=CxEjGuPTI+JDNdYdPJ6O4paEx9x3Nf6FZdjCk22BQA0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AC249nLMc8K/vROia3dHd0PDefSl9zVkf+OsmHcVW9H3CLx3RcVLg8DVMkSlpF1X2tPtgQy5O+1mQxa+x+sftuI1aZ3w6jB70XvkXHQXCWowjo6GMItQfPpRMod3OTcl1K7atSGCVgKFiGZDCmowOYugmWLJDB7exX6klVFFZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok+fR7wn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok+fR7wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283CA1F000C5;
	Sat, 17 Oct 2026 02:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202621;
	bh=RcOswYnp0i87Qd0zRVWxfD3jJBBYT7FIGJW/LpwMxBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ok+fR7wnwPnXXgAM/WXb6Svh4BawNzP03mmEZfREDOt396CSY897egInp3rPFyNQn
	 i0Dtw6hM7d7ghPqYmMgg5RFkwKIGire9j87EnUoHddP+a2z29H3MPqUoEnUn7zvzCT
	 2n3C5cOMpzv4u6pcEyyC4EtwhOHpOlgfxdUa7nX8lKwn5vNO0SCuwUtLchTIp1kmoH
	 oJ1veT3DnOjUZSUOkbKYyXaglbCxZUM5z3a6bn/KHQhaPJPvGxKr2uoLIRYdn2ng7o
	 kWxvS0OkcRDLNHtfMhXd5peUmM8nD5wsuj2N6XBnb6SLGAkLpbZqiTlpdeizhiXPIU
	 F0YGq+rzcM15Q==
Message-ID: <sashiko-outbox-175174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] HID: hid-lenovo-go-s: Add suspend function and
 gate access under bool.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017013956.2440130-7-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
 <20261017013956.2440130-7-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:03:40 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: hid-lenovo-go-s: missing resume callback after hid_gos_susp=
end()
--

commit 321a5a0af7e8cc8645f93abe71148630082f227b
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Add suspend function and gate access under bool.

This patch adds a suspend callback to cancel the initial configuration
delayed work if the device suspends before setup finishes, and gates
sysfs and LED brightness access behind registration flags set when
cfg_setup() completes.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index ed08200e3571a..14aeddd65704b 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
[ ... ]
> @@ -1455,9 +1564,24 @@ static void hid_gos_cfg_remove(struct hid_device *=
hdev)
> =20
>  static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
>  {
> +	bool gp_registered, rgb_registered;
>  	u8 os_mode =3D drvdata.os_mode;
>  	int ret;
> =20
> +	/* Pairs with smp_store_release from gos_cfg_setup */
> +	gp_registered =3D smp_load_acquire(&drvdata.gp_registered);
> +	/* Pairs with smp_store_release from gos_cfg_setup */
> +	rgb_registered =3D smp_load_acquire(&drvdata.rgb_registered);
> +	if (!gp_registered || !rgb_registered) {
> +		ret =3D schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies=
(2));
> +		if (!ret) {
> +			dev_err(&hdev->dev, "Failed to schedule startup delayed work\n");
> +			return -ENODEV;
> +		}
> +
> +		return 0;
> +	}
> +
>  	ret =3D mcu_property_out(drvdata.hdev, SET_GAMEPAD_CFG,
>  			       FEATURE_OS_MODE, &os_mode, 1);
>  	if (ret < 0)
> @@ -1546,6 +1670,30 @@ static int hid_gos_reset_resume(struct hid_device =
*hdev)
>  	return 0;
>  }
> =20
> +static int hid_gos_cfg_suspend(void)
> +{
> +	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
> +
> +	return 0;
> +}
> +
> +static int hid_gos_suspend(struct hid_device *hdev, pm_message_t msg)
> +{
> +	int ret;
> +	u8 ep;
> +
> +	/* Safe assumption. SET_INTERFACE ioctl can't be used while driver is b=
ound */
> +	ret =3D get_endpoint_address(hdev);
> +	if (ret <=3D 0)
> +		return 0;
> +
> +	ep =3D ret;
> +	if (ep =3D=3D GO_S_CFG_INTF_IN)
> +		return hid_gos_cfg_suspend();
> +
> +	return 0;
> +}
> +
>  static const struct hid_device_id hid_gos_devices[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_QHE,
>  			 USB_DEVICE_ID_LENOVO_LEGION_GO_S_XINPUT) },
> @@ -1562,6 +1710,7 @@ static struct hid_driver hid_lenovo_go_s =3D {
>  	.remove =3D hid_gos_remove,
>  	.raw_event =3D hid_gos_raw_event,
>  	.reset_resume =3D pm_ptr(hid_gos_reset_resume),
> +	.suspend =3D pm_ptr(hid_gos_suspend),
>  };
>  module_hid_driver(hid_lenovo_go_s);

[Severity: Medium]
What happens if the device suspends before cfg_setup() finishes and then
resumes via a normal non-reset resume?

In hid_gos_cfg_probe(), drvdata.gos_cfg_setup is scheduled with a 2ms
delay. If a system suspend where USB bus power is maintained, runtime
autosuspend, or an aborted suspend rollback in usbhid occurs before
cfg_setup() sets drvdata.gp_registered and drvdata.rgb_registered,
hid_suspend() calls:

  hid_driver_suspend()
    -> hid_gos_suspend()
      -> hid_gos_cfg_suspend()
        -> cancel_delayed_work_sync(&drvdata.gos_cfg_setup)

When the device subsequently resumes without a USB port reset (or rolls
back from a failed suspend), usbhid calls:

  hid_resume()
    -> hid_resume_common()
      -> hid_driver_resume()

which invokes hdev->driver->resume rather than hdev->driver->reset_resume.

Because hid_lenovo_go_s only sets .reset_resume and leaves .resume NULL,
drvdata.gos_cfg_setup is never rescheduled on that path. Would that leave
drvdata.gp_registered and drvdata.rgb_registered permanently false (and in
the later patch "HID: hid-lenovo-go-s: Move sysfs group creation into
delayed work", prevent the sysfs groups and LED device from ever being
registered)?

Should hid_lenovo_go_s also wire up a .resume callback to reschedule
drvdata.gos_cfg_setup when gp_registered or rgb_registered is false?

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017013956.2440=
130-1-derekjohn.clark@gmail.com?part=3D6
