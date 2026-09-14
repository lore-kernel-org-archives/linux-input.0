Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0839B4A5
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428718; cv=none; b=iNUCylMKKjfBocwqQuL1+pnjnD1WTa478nVDsipMYPDENe9MZ3d7Rp/7t2LbtKhFQeWLxalYoB/GBtbvO/H+Fw9k0QUXDMepfR9dieExyhkAUu2RfllT0/m2Dw3LgElAqgkpMOnoJhlHX96GQKbmRTYFja9KSCaZITs4NLg3PE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428718; c=relaxed/simple;
	bh=NDiy3N6S3poDStA9n+6acdTVELVqZJYrrW7I1sjzIrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/ctkDRKh+ju3IRrTmr5QagEn3Zua1TbhU2plsP21KWFNmRyOEu3j5S+cahFD6yQvGmg8WxjS8q4T2cVA4h2fVoLQ4+DBBwhiLGRZZwrQX7I1FGrBftZuUh0IPKjIvsl/o1CEB/00mcMqsaWPt7QfhabetRHs0yMpmo8h6Vepko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkmSQaqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkmSQaqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B31F000FF;
	Mon, 14 Sep 2026 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428717;
	bh=ncXlF/fSY4KudngzDpzt8R2nWmnBmoWP1b4ukb0+m0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SkmSQaqqULaWD8ufzYviz8lRLe/bZ4RI9Gxt7RDMUcoWGaOWhEr/eAZYOye13qBrA
	 /wKXuilgqEWBapqmCLfDwn87J+6575xxcHjQTwnD7bt2mKUqBamP2W5uIvWEVkmF9X
	 +x55Fbj0DSOc0/H6Y/1FxO0x6kZ1QekXCWUsuDoQ8KbNC+b9YM/cmV6utkdA154xDM
	 MHXAWO9MUGTfH7+2DJ06uWCG0aIJIrB7MgsuNPQlmZKoJ90uoPaFoR6RuBJ+GIs/z4
	 hPw/BM3etP6yqqcdOwqyu+lLa9gJ3osPJFUKrE8YxAd1/lZkFxPgaffNZN6GLBKp1M
	 kA/mOKPqsoYBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] HID: hid-lenovo-go-s: Add suspend function and
 gate access under bool.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260914225303.868569-7-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
 <20260914225303.868569-7-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:31:56 +0000
Message-Id: <20260914233157.144B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: hid-lenovo-go-s: Suspend callback permanently disables setup =
work, breaking resume
- [Medium] hid: hid-lenovo-go-s: Transient MCU query failures permanently l=
ock out sysfs configuration
--

commit 4cf4113a0e592276fc9988337678d1232b964a33
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Add suspend function and gate access under bool.

This commit adds a suspend function to cancel pending delayed work during
system sleep. It also introduces boolean flags to prevent sysfs attribute
access prior to the configuration setup completing.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 712823e22beae..6d98fff6d987e 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c

[ ... ]

>  static void cfg_setup(struct work_struct *work)
>  {
>  	int ret;
> =20
>  	/* MCU */
>  	ret =3D mcu_property_out(drvdata.hdev, GET_MCU_ID, FEATURE_NONE, NULL, =
0);
>  	if (ret) {
>  		dev_err(&drvdata.hdev->dev, "Failed to retrieve MCU ID: %i\n",
>  			ret);
>  		return;

[Severity: Medium]
If one of these initial MCU queries fails due to a transient error or timeo=
ut,
does this early return prevent the gp_registered and rgb_registered flags f=
rom
ever being set? Since there is no retry mechanism here, this could leave the
sysfs configuration permanently returning -ENODEV until the device is
replugged.

>  	}

[ ... ]

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

[ ... ]

> +static int hid_gos_cfg_suspend(void)
> +{
> +	disable_delayed_work_sync(&drvdata.gos_cfg_setup);

[Severity: High]
Does using disable_delayed_work_sync() here permanently disable the work
queue since there is no matching enable_delayed_work() call?

If the work queue is permanently disabled, schedule_delayed_work() in
hid_gos_cfg_reset_resume() will return false. Would treating a false return
from schedule_delayed_work() as a fatal error cause the resume operation to
abort unconditionally with -ENODEV?

Could cancel_delayed_work_sync() be used instead to cancel the work without
disabling it?

> +
> +	return 0;
> +}

[ ... ]

While looking at this driver, I noticed a pre-existing issue in
hid_gos_probe():

>  static int hid_gos_probe(struct hid_device *hdev,
>  			 const struct hid_device_id *id)
>  {
[ ... ]
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>  	if (ret) {
>  		hid_err(hdev, "Failed to start HID device\n");
>  		return ret;
>  	}
> =20
>  	ret =3D hid_hw_open(hdev);
>  	if (ret) {
>  		hid_err(hdev, "Failed to open HID device\n");
>  		hid_hw_stop(hdev);
>  		return ret;
>  	}
> =20
>  	ep =3D get_endpoint_address(hdev);
>  	if (ep !=3D GO_S_CFG_INTF_IN) {
>  		dev_dbg(&hdev->dev, "Started interface %x as generic HID device.\n", e=
p);
>  		return 0;
>  	}
> =20
>  	ret =3D hid_gos_cfg_probe(hdev, id);
>  	if (ret)
>  		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interfac=
e");
> =20
>  	dev_dbg(&hdev->dev, "Started interface %x as Go S configuration interfa=
ce\n", ep);
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but if hid_gos_cfg_probe() fails,
does this error path return without calling hid_hw_stop() and hid_hw_close(=
)?
This would leave the hardware active and leak resources since the HID core
does not automatically invoke the .remove() callback on a probe failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914225303.8685=
69-1-derekjohn.clark@gmail.com?part=3D6
