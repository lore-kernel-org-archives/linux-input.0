Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921302EA47C
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410636; cv=none; b=Kg3JHJUjM9aYiMCkdUgozPY/fLSd8rlPJDkKE+/pVOXhb80q9KtYCTGeqiL8gqJI5TpNEYTRjPM54ftkbpEhuGuuy4BEvjJkZ2aLop1q8UxIT+Q//BDU9CqqqU+7f+eeXNambByIkwttWX9FH/gmVuXHGr5HCTtRJS2gUZgjyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410636; c=relaxed/simple;
	bh=+StmA8bU0SzmNJlOfO58ZY8eHdCd0S5V6m7FtGTHL3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtNpnEJY8XYQ4dg7e29OGtKUu8JA5erVw1sObmm2z1A/x3nCR9zWUTEql3D4BwoHBACQcP/NfGklkNnX3x+LsFiBLf8z1+1nSzXErBC8pmWSrZTuPxGITxhlCsJDmB9xUrp8HduE/2ilkcoVhdn+ong7P0Yi82NdO6/9dOF0HVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+xc+v6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+xc+v6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108241F000E9;
	Tue,  7 Jul 2026 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783410635;
	bh=7KrRwCu2EMm9ma1fD3MMNRvCJbqkw1uOxtzTIauhMEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+xc+v6kBctF3FR7RCPFuCpYC8omuVTu5K+RAkRVVd7TE5zu+t2NNpv9Wgp7drzna
	 ojbwnTg9sDKBrKK3gV9DIzLsGkNFIus9+tHcXMthlzjiHtw75LCGjcQe3tcMchRP+S
	 2O5pkmJIA2vhrspMoD52ZhbdRI0bJ7TOmXt5fr5Mex8xFk2+hE6BL7CwS4KqWsaEGb
	 mh6znE/nf0REq7lZwI63Hlb7IN75gSX+zdWxSJE9BOyGNieUhbvSeNVDVnbm50fWqi
	 TUfIyr7QlUkmHzvIToy9KIsL9GEL+OKQMMLJX3UnLpybBIhMVhN6PjmytOdWfu4WFz
	 b3eaC4miMMRnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] HID: sensor: custom: Fix use-after-free in
 enable_sensor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707071545.3087073-2-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
 <20260707071545.3087073-2-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:50:34 +0000
Message-Id: <20260707075035.108241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect mapping between the sysfs attribute name index and t=
he `sensor_inst->fields` array leads to Heap Out-Of-Bounds reads.
- [High] The `/dev/HID-SENSOR-*` character device operations do not synchro=
nize with device removal, leading to Use-After-Free on `devm`-managed struc=
tures.
- [High] The `data_fifo` is freed before the sensor hub interrupt callback =
is unregistered during device removal, creating a race condition that leads=
 to a Use-After-Free.
- [High] The sensor hub device is never closed on driver removal if it was =
concurrently enabled, causing a permanent power and reference count leak.
--

--- Patch [1]: [PATCH v3 1/2] HID: sensor: custom: Fix use-after-free in en=
able_sensor ---
commit d433ad359db5f5f5744d4b3f8a4dc8088af760b6
Author: Haoxiang Li <haoxiang_li2024@163.com>

HID: sensor: custom: Fix use-after-free in enable_sensor

This commit fixes a use-after-free by altering the initialization and clean=
up
order of the sysfs attributes and the enable_sensor group. This prevents
enable_sensor from being accessed before its dependencies are fully
initialized or after they have been freed.

Link: https://sashiko.dev/#/patchset/20260623021950.1736413-1-haoxiang_li20=
24@163.com?part=3D1

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index afffea8940214..6b0da2e0e1c93 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -1005,26 +1005,26 @@ static int hid_sensor_custom_probe(struct platfor=
m_device *pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> -				 &enable_sensor_attr_group);
> +	ret =3D hid_sensor_custom_add_attributes(sensor_inst);

[Severity: Critical]
This is a pre-existing issue, but is there an out-of-bounds read when parsi=
ng
the sysfs strings created by this function?

During initialization, if a HID field is skipped, it is not appended to the
sensor_inst->fields array, keeping sensor_field_count small. However, its
original field index is embedded into the sysfs file name.

When a valid sysfs file is later read, show_value() parses the index from
the filename and uses it directly as an array index:

    if (sscanf(attr->attr.name, "input-%x-%x-%s",
               &index, &usage, name) =3D=3D 3) {
        input =3D true;
        field_index =3D index;
    }
    ...
    value =3D sensor_inst->fields[field_index].attribute.logical_minimum;

Could this bypass the array bounds and leak memory to userspace?

[ ... ]

> @@ -1042,9 +1042,10 @@ static void hid_sensor_custom_remove(struct platfo=
rm_device *pdev)
>  	}
> =20
>  	hid_sensor_custom_dev_if_remove(sensor_inst);

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this leave a
use-after-free window?

If a user holds open the misc device /dev/HID-SENSOR-*, misc_deregister()
does not close existing open file descriptors. Since sensor_inst is
allocated with devm_kzalloc(), it is freed when remove() returns.

Would subsequent calls to hid_sensor_custom_read(), poll(), or
hid_sensor_custom_release() dereference the freed sensor_inst object?

[Severity: High]
This is a pre-existing issue, but is there a race condition here?

The data_fifo is freed by hid_sensor_custom_dev_if_remove() before the
interrupt callback is unregistered by sensor_hub_remove_callback().

If an interrupt occurs while sysfs_remove_group() or
hid_sensor_custom_remove_attributes() is blocking, couldn't the callback
hid_sensor_capture_sample() write incoming data to the freed data_fifo
via kfifo_in()?

[Severity: High]
This is also a pre-existing issue, but does this function leak the sensor h=
ub
reference and power state?

If a user writes '1' to the enable_sensor sysfs attribute,
sensor_hub_device_open() powers on the device and takes a reference. Since
this function tears down the interfaces without checking sensor_inst->enable
and calling sensor_hub_device_close(), does the HID device reference leak
permanently?

> -	hid_sensor_custom_remove_attributes(sensor_inst);
> +	/* Remove enable_sensor first as it uses fields via power_state/report_=
state. */
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
>  			   &enable_sensor_attr_group);
> +	hid_sensor_custom_remove_attributes(sensor_inst);
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707071545.3087=
073-1-haoxiang_li2024@163.com?part=3D1
