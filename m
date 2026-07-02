Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091747CC97
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987379; cv=none; b=cx6Z0hFYo/aBLh3tYOcJWKd6gvKy8C41tKaPyEFvxKyMe4C5sKQZva5ExQ1Hc9XKmMWJ/Q5Ge06iJVwpfp5xU3NuKL6iNHlvHalfcDeRojE3lUGGstokXNSYJNr0x/GJQ8pWNGzAtqKXVgpBE0fbdFGmUKLTPjU6YLrPynrFkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987379; c=relaxed/simple;
	bh=OhQA9W5vOx8TTJr2VALGLQa+HOgd1EeSVaWlpb0y5VM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mCIt5qctU4Vh9jwMlqjQa70Mi5FhCRuUc+0eSqXhBFjDYqLDUF6tdHgrOZsB56MCDm3lVGSaYY9ll4F314MeI+6Ls1lsYhk1918YyDy+t2MrQwLbBfTZdDN5IzN4XzsI/0yg6vHyTnNmVUEH6dm8PbNH2WIBLO0gX9saMViE3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etFQ8aEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etFQ8aEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8571F000E9;
	Thu,  2 Jul 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987377;
	bh=iDlEZZwRPdnzjVd6xv6cNyXOGQF6UIc2/u9UcgnHZ+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etFQ8aEmWDkHIbh6tZHlWWIBfBZHySi+UfEbuhwKV/uUtA7+TEiPOFWKMCgJCl18I
	 cgHSwvqZ6+Z0NHukek7qx3lBWSnqPozEY3C/ATCWRZ4MpI5RV/4czzm6JcpoyAmbvY
	 Hr+jm1NOhuIlY3qFMWZYugGCsjDcGAj+Jf6nKDqrGgr/2jnzJ4l4v8o3EpLz4jo9+u
	 v3DvlgyV83vW9fawM0Agn2ECO4Q3icWTOVyaCXN2E+/GaXP/xMAUcvsR26quIGHikq
	 RYAH4FA0HLGBwl6uOQMc7nQl480siUJcfRc76cc2Q7PDNzmZjlAR0CE40gXD18nh4s
	 BoVpWjP0EBujA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] HID: sensor: custom: Fix field sysfs group
 cleanup on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702094856.1105555-3-haoxiang_li2024@163.com>
References: <20260702094856.1105555-1-haoxiang_li2024@163.com>
 <20260702094856.1105555-3-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:16:16 +0000
Message-Id: <20260702101617.6F8571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of synchronization during callback removal leads to Use-After=
-Free of `sensor_inst` in HID event handler.
- [High] Active file descriptors on the misc device cause Use-After-Free af=
ter driver unbind.
- [High] Out-of-bounds array access in sysfs `show_value` and `store_value`=
 due to flawed index parsing.
- [Medium] Resource leak of HID sensor hub device open count on unbind.
--

commit 33ce389be4baf215143f759dd6b8350c60263845
Author: Haoxiang Li <haoxiang_li2024@163.com>

HID: sensor: custom: Fix field sysfs group cleanup on failure

hid_sensor_custom_add_attributes() creates one sysfs group for each
custom sensor field. If sysfs_create_group() fails after some groups
have already been created, the function returns the error without
removing the previously created groups. Add a local unwind path to
remove the groups that were already created.

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index d7bdbae96b501..ea98088e51123 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c

[ ... ]

> @@ -621,6 +621,13 @@ static int hid_sensor_custom_add_attributes(struct h=
id_sensor_custom
>  	}
> =20
>  	return ret;
> +
> +err_remove_groups:
> +	while (--i >=3D 0)
> +		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> +				   &sensor_inst->fields[i].hid_custom_attribute_group);
> +	kfree(sensor_inst->fields);
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but can the sysfs read/write handlers access
out of bounds memory if fields are skipped during initialization?

When sysfs attributes are read or written, the original index is extracted
via sscanf() and used directly on sensor_inst->fields:

drivers/hid/hid-sensor-custom.c:show_value() {
    ...
    if (sscanf(attr->attr.name, "input-%x-%x-%s", &index, &usage, name) =3D=
=3D 3) {
        input =3D true;
        field_index =3D index;
    }
    ...
    attribute =3D &sensor_inst->fields[field_index].attribute;
}

If the initialization loop skips fields, the extracted index can exceed the
array bounds of sensor_inst->fields, leading to an out-of-bounds access.

> @@ -1005,26 +1012,26 @@ static int hid_sensor_custom_probe(struct platfor=
m_device *pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> -				 &enable_sensor_attr_group);
> +	ret =3D hid_sensor_custom_add_attributes(sensor_inst);
>  	if (ret)
>  		goto err_remove_callback;
> =20
> -	ret =3D hid_sensor_custom_add_attributes(sensor_inst);
> +	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> +				 &enable_sensor_attr_group);
>  	if (ret)
> -		goto err_remove_group;
> +		goto err_remove_attributes;
> =20
>  	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
>  	if (ret)
> -		goto err_remove_attributes;
> +		goto err_remove_group;

[Severity: High]
This is a pre-existing issue, but does the misc device teardown properly
synchronize with active file descriptors?

When the driver unbinds or fails probe, it unregisters the misc device and
frees the data FIFO, but active file descriptors are not revoked.

If a userspace process holds an open file descriptor, can subsequent calls
dereference the freed sensor_inst memory?

drivers/hid/hid-sensor-custom.c:hid_sensor_custom_read() {
    ...
    sensor_inst =3D container_of(file->private_data,
                               struct hid_sensor_custom, custom_dev);
    if (kfifo_is_empty(&sensor_inst->data_fifo)) {
    ...
}

> =20
>  	return 0;
> =20
> -err_remove_attributes:
> -	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_group:
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
>  			   &enable_sensor_attr_group);

[Severity: Medium]
This is a pre-existing issue, but is there a missing teardown for the sensor
hub open count?

If a user writes 1 to the enable_sensor attribute, it increments the hub's
ref_cnt. When the driver unbinds, hid_sensor_custom_remove() destroys the
sysfs groups but does not seem to check sensor_inst->enable or call
sensor_hub_device_close().

Does this leak the reference count and leave the hardware in a persistent
power state?

> +err_remove_attributes:
> +	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_callback:
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This is a pre-existing issue, but does removing the callback here leave a
race condition with concurrent HID events?

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() removes the
callback from the list and frees it:

sensor_hub_remove_callback() {
    ...
    list_del(&callback->list);
    kfree(callback);
    ...
}

It doesn't synchronize with concurrent executions. If the driver fails probe
or is unbound, sensor_inst is freed via devres. Can this concurrently
dereference the freed sensor_inst when executing the callback?

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    callback =3D sensor_hub_get_callback(hdev, ...);
    if (callback->capture_sample) {
        callback->capture_sample(hsdev, ..., callback->pdev);
    }
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094856.1105=
555-1-haoxiang_li2024@163.com?part=3D2
