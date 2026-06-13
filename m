Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F83624A9
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365365; cv=none; b=CbU6wRXC33re8pIXr0dZo7fYBFVQ7/3oyukfiwE84mA4GLwjCSA27SSbF7312/lvOzqWVXN8TE1nhfU/FwlFy7neoHTiYAztsxA2DYz5qKIJ3g/kQlaD2JBHyq/Q7TX3Rp9LD3QqvfnEF86dvlvM8C7kmFsJzDZ+2GMapmJdYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365365; c=relaxed/simple;
	bh=juXEZoeC4khMDCb2rz2QgdHC976XGDZGAmMPUe9dVHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PfhXo6/codWkCLS/OSd1+UF3BNyOOedG/1vGSVdTg8T3tDq5OaCBbZcfMtoz+SoewDb43HPWWv8Nr6vWyfDsNGrqWkGk9Hck1bpHWWAhh9qMEEJhoYV2nnLbNk1BKVKBmHaFBdqmWi5ruGlN3S0swC1vVok6eOWZX0vd0RIf8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzidHj9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzidHj9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6C31F000E9;
	Sat, 13 Jun 2026 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781365363;
	bh=pPSIKPt/m9cmXTuCBIUsfVH6Y73b/nFm+zMaPtQUIH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzidHj9eqpQJp5kbyqEQjoxHW1se/ssS8PQ/2XFsHshiTBVdBq8OY8XrHfuNWsl6k
	 mlUDx2m22OFRlWM2dxJohxWHIccaALYVJkjSNoHytJ67FVo2wXzOGkcKSv+oKsgCFs
	 /GrN9pjFCyqq0w2bocd+3ZGhkcN8okgNdaKH1S33RIYH1yi3t4K6IbxiRDQcxtA6Ot
	 pPuvrC5ScyKoO962/jAqlZ+dtYZVHw5L0Pm0dRchKq9LAL/Ik5n8Pr4GUfqwRh71uv
	 Z7TtAUZvJSBbaZosnVN2u8dR0xEHoAjw83BPM4dFulnQsjnAo1SDKfBsBVWhiWr+5l
	 aK0WTxJ+EeQzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] HID: asus: cleanup keyboard listener on failure:
 avoid use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260613153029.2559774-5-denis.benato@linux.dev>
References: <20260613153029.2559774-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 15:42:43 +0000
Message-Id: <20260613154243.4D6C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added `err_unregister_backlight` error path frees `drvda=
ta->kbd_backlight` without canceling its associated workqueue, leading to a=
 Use-After-Free.
- [High] The `asus_probe` error path fails to unregister the dynamically re=
gistered `xgm_led` class device, leaving a dangling pointer in the LED subs=
ystem.

Pre-existing issues:
- [High] The `asus_probe` error paths fail to cancel `fn_lock_sync_work` an=
d `wmi_work`, creating a potential Use-After-Free if the works are schedule=
d during probe.
--

commit 6e04c2967d627dea02497ed7471439a5d35c56bc
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: cleanup keyboard listener on failure: avoid use-after-f=
ree

This commit fixes a potential use-after-free by unregistering the keyboard
listener on probe failure. It explicitly adds an error path to unregister
the listener and free the memory when a subsequent initialization step fail=
s.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 95e7dc6a447d8..e3a03f7cf77d0 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1420,11 +1420,17 @@ static int asus_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		if (drvdata->tp) {
>  			ret =3D asus_start_multitouch(hdev);
>  			if (ret)
> -				goto err_stop_hw;
> +				goto err_unregister_backlight;
>  		}
>  	}
> =20
>  	return 0;
> +err_unregister_backlight:
> +	if (drvdata->kbd_backlight) {
> +		asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
> +		devm_kfree(&hdev->dev, drvdata->kbd_backlight);

[Severity: High]
Does this code leave pending work items referencing freed memory?

If concurrent events have queued `drvdata->kbd_backlight->work` (e.g.,
via `asus_kbd_backlight_set()` or `asus_hid_event()`), freeing
`kbd_backlight` without synchronizing via `cancel_work_sync()` might
cause a use-after-free when the workqueue executes.

> +		drvdata->kbd_backlight =3D NULL;
> +	}
>  err_stop_hw:
>  	hid_hw_stop(hdev);
>  	return ret;

[Severity: High]
Could failing to unregister `xgm_led` leave a dangling pointer in the LED
subsystem?

If `asus_xgm_init()` succeeds, it registers `drvdata->xgm_led->cdev` using
`led_classdev_register()`, which is not devres-managed. If `asus_probe()`
subsequently fails and jumps here, the code exits without calling
`led_classdev_unregister()`. Since `drvdata->xgm_led` is devres-managed, it
will be freed, but the LED subsystem will retain a pointer to it,
potentially causing a use-after-free.

[Severity: High]
This is a pre-existing issue, but does this error path also need to cancel
`fn_lock_sync_work` and `wmi_work`?

Once the hardware is started via `hid_hw_start()`, incoming input events
can schedule `drvdata->fn_lock_sync_work` or `drvdata->wmi_work`. If
`asus_probe()` fails and exits here, devres will automatically free
`drvdata`. Since `cancel_work_sync()` is omitted from this error path, any
queued work could execute asynchronously after `drvdata` is freed, leading
to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613153029.2559=
774-1-denis.benato@linux.dev?part=3D4
