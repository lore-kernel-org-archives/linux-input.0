Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9D2C0296
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411476; cv=none; b=sO8iofd7xACUVlnm7Gfb5RMSHAfsu6zFAk41/PIdbROG++I8k0+fLlFIPK0VVwtrHOqenSFnTk1PAzHBQAt6V/qWD+dPVS/K8/fUnI9yURfiEYAefBMyAaVRUi9ZIriGom6tl1qQz2B/9PBtSup9jqCPGIwnn+LLIVDxuzM88Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411476; c=relaxed/simple;
	bh=tlm1iqHkYW0+5WoWmli7ppsJccbg0eL6nKoyYa53jNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJMEQ9Mj5HEYCy9R+BgbsU6SXOIXUHEDA3AtBHWx5lwRvuZvS8R/JhgLR7Fy86p5SMQMYx9QjQ5GWtchf0CmViX1gzoXH0v7vCPGcUiKG3Qnb7ximHePQP/iBUN4Xnb4ac3nOi1eaEfN1KQTp3jmEDe6ZSlTyOY6Fos84fya3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjGCw+Xs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjGCw+Xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D5B1F000E9;
	Tue,  7 Jul 2026 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411474;
	bh=/HeldCAQyVFaR/ec//dGYB7MmTAt0NKlZ/QOKRaNa9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DjGCw+XsUxk45+L8WJC4JEVHcEtsn4Vps4Xtls2m22SNcUf4UXTCUJkGP/l2ttHZc
	 g3LwI3g0NbGfwu+1z8n5KkSX0Zft8HL7x86XTiYpIjrkdgn/PIMZI0bVkJ4KOUyCkW
	 Ld9wCAGGwEJuVAxegxzoQkZF6pNM/iBnF7R7p1B04euCgOmSMGF7mumMADDjhrCEk7
	 W34qazXIisg56qNzMBEqpHGCKiwCuzzA2fALDbywKvu/t+YuitbB8SnS62kKLFyvWq
	 HjVcnQ8L2EOj06jrPX7ey3MrPpk7lhG9u9te+eH5qXMuJwvf3qPZTWqJLpVzAA3wUm
	 i81w1Nj4txVFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] HID: sensor: custom: Fix field sysfs group
 cleanup on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707071545.3087073-3-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
 <20260707071545.3087073-3-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:04:33 +0000
Message-Id: <20260707080434.50D5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lifetime mismatch between `devm_kzalloc` allocated `sensor_inst` a=
nd `miscdevice` file operations leads to a Use-After-Free.
- [High] Race condition in `hid_sensor_custom_remove()` between event callb=
ack removal and kfifo destruction allows Use-After-Free.
--

--- Patch [2]: [PATCH v3 2/2] HID: sensor: custom: Fix field sysfs group cl=
eanup on failure ---
commit aa8aaa0518fc58fa29db9643742276c6a56cafe6
Author: Haoxiang Li <haoxiang_li2024@163.com>

HID: sensor: custom: Fix field sysfs group cleanup on failure
   =20
hid_sensor_custom_add_attributes() creates one sysfs group for each
custom sensor field. If sysfs_create_group() fails after some groups
have already been created, the function returns the error without
removing the previously created groups.
   =20
Add a local unwind path to remove the groups that were already created.
With enable_sensor exposed only after the field attributes are ready,
this path can free sensor_inst->fields without leaving enable_sensor
able to access pointers into that array.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index 6b0da2e0e1c93..c2b425afd951b 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -609,7 +609,7 @@ static int hid_sensor_custom_add_attributes(struct hi=
d_sensor_custom
[ ... ]
>  	return ret;
> +
> +err_remove_groups:
> +	while (--i >=3D 0)
> +		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> +				   &sensor_inst->fields[i].hid_custom_attribute_group);
> +	kfree(sensor_inst->fields);
> +	return ret;
>  }
> =20
>  static void hid_sensor_custom_remove_attributes(struct hid_sensor_custom=
 *

[Severity: High]
This is a pre-existing issue, but is there a lifetime mismatch between the
devm_kzalloc() allocated sensor_inst and the miscdevice file operations?

In hid_sensor_custom_probe(), sensor_inst is allocated with device-managed
memory:

    sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
                               GFP_KERNEL);

When the device is unbound, devres will automatically free sensor_inst.
However, misc_deregister() does not revoke existing open file descriptors.

If a user has the character device open, unbinds the device, and then
interacts with the file descriptor, could this lead to a use-after-free?

For example, hid_sensor_custom_read() accesses the freed pointer:

    sensor_inst =3D container_of(file->private_data,
                               struct hid_sensor_custom, custom_dev);

Similarly, closing the file calls hid_sensor_custom_release() which modifies
the freed memory:

    clear_bit(0, &sensor_inst->misc_opened);

[Severity: High]
This is a pre-existing issue, but is there a race condition in
hid_sensor_custom_remove() during device teardown?

The function first frees the data buffer:

    hid_sensor_custom_dev_if_remove(sensor_inst); // calls kfifo_free()

It removes the callback later in the function:

    sensor_hub_remove_callback(hsdev, hsdev->usage);

If the sensor hub receives an asynchronous hardware event between these two
calls, wouldn't the still-active callback invoke hid_sensor_capture_sample()
and write incoming hardware data to the freed data_fifo?

    kfifo_in(&sensor_inst->data_fifo, (unsigned char *)raw_data,
             raw_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707071545.3087=
073-1-haoxiang_li2024@163.com?part=3D2
