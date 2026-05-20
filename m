Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97A348465
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247439; cv=none; b=DdY7J9WzvNFojYrBtXKumxLyzgfnDGihrEWQJIPMKKFPmUccg/vOBzevMSSNvuWKsFECzA6AQYwMqBQuO063DxBcXvXpcz5rMdcQpp7KnMrpP5dDdwyGUX7vlwZM1IwAOHuMXjaIWhui+uFYHTCzw3rVgjqmx81R95rtqHuY3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247439; c=relaxed/simple;
	bh=GtqL0f01lof5rBMmJWfkRVBNBg8ICEZ2DxMC0ywDHPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A20K4CADT8ogEYjmO0ZSMSixxFSjEjYRxA5GXCMc9f7ucmwNTjv8nv/VJgd2pVkCXdeYR06X7IeihSH0Lh5SH0ahN3po2NrgIJ3XoTahKZzXsQPtNgIgz4A0qvEBsSz6+iBbfLdXCPRl7BaxfCkw6t7XtbMsJ1J7K5o12ojp+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWHV/vIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWHV/vIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FB21F00893;
	Wed, 20 May 2026 03:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779247438;
	bh=yjUOnqsjchTs4P5i70gDs6DP+Hzz8SiITafCZd7bflA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWHV/vIaVzxhs0/aibSziKYzqcZqKZMcvQvlxcoW31mDA+jDZBsHx+AOuBe52Rxnd
	 HFMgX2nfQbWv+bPp8NAlxw8w/rEr+ZlvCArjFYPXa4MSbNmED+QJsFSxImzLfszXIS
	 3s9gGzRIEUi/eGR4JQgcaMlD66p9Ovt8cdoCHNW55nqNzh/xP1LvGrXoNX1jOMhs3G
	 FOPXLHqTrN/x/BC4fFffaf+8zEC97h4Egbnlu8IheT9zy4N61GYYEne3niSUzdX2PP
	 fovJCYPbiHy5j3ptCOR8m5/kvV79Psf24HWOzhCH+ZImnbiRwvjIq1C5EHlWmj8Ymf
	 Rptcho2T2yZqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520013158.3633277-4-derekjohn.clark@gmail.com>
References: <20260520013158.3633277-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 03:23:57 +0000
Message-Id: <20260520032357.F0FB21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A race condition in `claw_remove()` allows the `rgb_queue` delayed=
 work to be re-armed after it is cancelled, leading to a Use-After-Free.
- [High] Failing to unregister the LED class device if `device_add_group()`=
 fails leaves it registered but sets `rgb_registered =3D false`, causing li=
st corruption upon retry.
--

commit 35b79b95f2f2fd70b7faaa568ae55b37643edb83
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface
   =20
Adds RGB control interface for MSI Claw devices. The MSI Claw uses a
fairly unique RGB interface. It has 9 total zones (4 per joystick ring
and 1 for the ABXY buttons), and supports up to 8 sequential frames of
RGB zone data.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 193435ec9386c..61917902e38d3 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -871,31 +960,521 @@ static const struct attribute_group claw_gamepad_a=
ttr_group =3D {

[ ... ]

> +try_rgb:
> +	/* Add and enable RGB interface once we have the device state */
> +	/* Pairs with smp_store_release from below */
> +	if (!smp_load_acquire(&drvdata->rgb_registered) && rgb_ready) {
> +		ret =3D devm_led_classdev_multicolor_register(&drvdata->hdev->dev, &dr=
vdata->led_mc);
> +		if (ret) {
> +			dev_err(&drvdata->hdev->dev,
> +				"Failed to create led device: %d\n", ret);
> +			goto update_kobjects;
> +		}
> +
> +		ret =3D device_add_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_=
group);
> +		if (ret) {
> +			dev_err(&drvdata->hdev->dev,
> +				"Failed to create RGB attrs: %d\n", ret);
> +			goto update_kobjects;
> +		}

[Severity: High]
If device_add_group() fails here, we jump to update_kobjects without rolling
back the devm_led_classdev_multicolor_register() call, and rgb_registered
remains false.

On a subsequent system resume, cfg_resume_fn() will see rgb_registered is
false and schedule cfg_setup_fn() again:

    if (!smp_load_acquire(&drvdata->rgb_registered))
        schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500));

Will the second call to devm_led_classdev_multicolor_register() with the ex=
act
same drvdata->led_mc structure corrupt the leds_list, since led_cdev->node
is already in the list from the first call?

> +
> +		/* Pairs with smp_load_acquire in attribute show/store functions */
> +		smp_store_release(&drvdata->rgb_registered, true);
> +	}

[ ... ]

> @@ -1021,11 +1622,15 @@ static void claw_remove(struct hid_device *hdev)
>  		return;
>  	}
> =20
> +	/* Block writes to brightness/multi_intensity during teardown */
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
> =20
>  	/* Pairs with smp_load_acquire in attribute show/store functions */
>  	smp_store_release(&drvdata->gamepad_registered, false);
> +	/* Pairs with smp_load_acquire in attribute show/store functions */
> +	smp_store_release(&drvdata->rgb_registered, false);

[Severity: High]
Could setting rgb_registered to false after cancelling the delayed work
cause a use-after-free here?

Because sysfs attributes are managed by devres, they remain active until
claw_remove() returns. A concurrent sysfs write could check rgb_registered
and then get preempted:

    /* in effect_store() */
    if (!smp_load_acquire(&drvdata->rgb_registered))
        return -ENODEV;
    /* Preempted here */

Meanwhile, claw_remove() runs:

    cancel_delayed_work_sync(&drvdata->rgb_queue);
    smp_store_release(&drvdata->rgb_registered, false);

Then the sysfs writer resumes and queues the work again:

    mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));

After claw_remove() returns, devres will free drvdata. When the queued work
eventually executes claw_rgb_queue_fn(), will it access the freed drvdata?

Would clearing rgb_registered before calling cancel_delayed_work_sync()
prevent the work from being re-queued?

> =20
>  	hid_hw_close(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520013158.3633=
277-1-derekjohn.clark@gmail.com?part=3D3
