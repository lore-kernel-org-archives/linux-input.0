Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165226;
	b=S+3Dmg+7hZUWWM9H3myE1b/Hb0gEmQAV5UEhYy7GTaZxchRFcTM4dwpUf5hgQnTI6U2s
	 7Pm1dan/c3v+leSGmNbSKH2itLMkd71iCxFlJvAWxx61duiRJ0rIdbZMfxpVU+qj7hCoU
	 4+fBIwAtItsSbShtCl2+mCMqbgV+c4luHCI5Yz/w5PPO/JZHTgP8i96f8a6I0idpupOmi
	 YXZSivQvHPWEg363qLagL1cKM+aRR6qA/UM/Rq0GtImQmDDLSdG5myMCsyNluKherHhHL
	 /l/ZMHVk5Pyz68wtr99AP2/rXVLk+sobyELxWa21qFPL9we3zV+DwZf6Y1oBsnfA5WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yLehJXWZpyozjeXbdnDS8M8LxBMisGLfa4MqWbtN1RM=;
	b=c02QGUE163fjiarGvjNjKFzCj5gIh9aipUnpx/EgXk6s0f1rFbjIj95MSaB/2qoMjU2w
	 P7N5RrKet9MZuCyOR6jrFBH5nOpdBi4hjyhtRJkHMvs2yegMKu/DrhXHa02LABeb6umq1
	 cSmJvh4uvZ4KmKRCfg0DhLTLJW+nNoWJn+SU3/K9BzPC3+UFgGfp075dxY18tJbIjifsn
	 31HNnDBfJnzgJkprM+g1SdqNiXJRYIqN8C17YlC3iGVY0obDl5+kZsS6v153K7sURK5uJ
	 ZHLr6UR9/ads9PZmiwXcT474Pv0HuZLCbo7p+pDVXTLb5R8XPZHUP39u/T8ahwCKCBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3ZB78wj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7986606A32C
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3ZB78wj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF751F000CF;
	Fri, 20 Nov 2026 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795165226;
	bh=yLehJXWZpyozjeXbdnDS8M8LxBMisGLfa4MqWbtN1RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3ZB78wj/gxzFGngEVM2xFtvuSVWGzVhTMFE4KhHy03VO4BrGzMPvM0dr5XtWAbca
	 lF0nSjlt7v3jpSHcCCsnDUce3M2PabwNJacHYi3P6ljHEIUPeUJaQcNa0MQvBGSheo
	 m1DubkioWVcqDDXUM4CNMbisj3ZEPrav9kJLFHV5ozSlqqOcjeJYx7L76Leesq28E1
	 bvytG9V08cPWu4hHkSQePRvdNO8zuLUo3xfQ23CNQSMmoU+7qxzuLdZHdEQC/Cd2o6
	 PCPpVWYeCl8R7bPfuT+wI9qAqTKTX5SSxq7jE1lS+q5dZQrLi2DWGWxDlkchSox+zZ
	 G46xfqRhhM27g==
Message-ID: <sashiko-outbox-224807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/18] HID: logitech-hidpp: manage G920 range sysfs
 attribute via dev_groups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-6-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
 <20261120-hid-logitech-hidpp-next-v3-6-ba39242d4336@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 09:00:25 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: logitech-hidpp: use-after-free of hidpp and g920 in
  hidpp_ff_destroy()
--

commit 747c5a1e9f12f8c0a286b46681fccb7f3876f83a
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: logitech-hidpp: manage G920 range sysfs attribute via dev_groups

This commit replaces manual creation and removal of the G920 range sysfs
attribute with a driver dev_groups attribute group using an is_visible
callback.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 58f7cf84b9951..1376d5bc3fbbb 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2752,16 +2752,47 @@ static ssize_t hidpp_ff_range_store(struct device=
 *dev, struct device_attribute
> =20
>  static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROT=
H, hidpp_ff_range_show, hidpp_ff_range_store);
> =20
> +static struct attribute *g920_range_attrs[] =3D {
> +	&dev_attr_range.attr,
> +	NULL
> +};
> +
> +static umode_t g920_range_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *attr, int idx)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +	struct g920_data *g920;
> +
> +	if (!hidpp || !(hidpp->quirks & HIDPP_QUIRK_CLASS_G920))
> +		return 0;
> +
> +	g920 =3D hidpp->private_data;
> +	if (!g920 || !g920->ff)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group g920_range_group =3D {
> +	.attrs =3D g920_range_attrs,
> +	.is_visible =3D g920_range_attr_is_visible,
> +};
> +
> +static const struct attribute_group *hidpp_dev_groups[] =3D {
> +	&g920_range_group,
> +	NULL
> +};
> +
>  static void hidpp_ff_destroy(struct ff_device *ff)
>  {
>  	struct hidpp_ff_private_data *data =3D ff->private;
>  	struct hidpp_device *hidpp =3D data->hidpp;
> -	struct hid_device *hid =3D hidpp->hid_dev;
>  	struct g920_data *g920 =3D hidpp->private_data;
> =20
> -	hid_info(hid, "Unloading HID++ force feedback.\n");
> +	hid_info(hidpp->hid_dev, "Unloading HID++ force feedback.\n");
> =20
> -	device_remove_file(&hid->dev, &dev_attr_range);
>  	destroy_workqueue(data->wq);
>  	g920->ff =3D NULL;
>  }

[Severity: High]
Can hidpp_ff_destroy() cause a use-after-free of hidpp and g920 when an
open event handle outlives driver unbind or disconnect?

Both hidpp (allocated with devm_kzalloc_obj() in hidpp_probe()) and g920
(allocated with devm_kmemdup() in g920_get_config()) belong to hdev's
driver devres group.  If userspace holds an open file descriptor to the
input device across disconnect, input_unregister_device() deletes the
device without releasing it, and hid_device_remove() immediately calls
devres_release_group(), freeing hidpp and g920.

When the last open handle is closed later, input_dev_release() ->
input_ff_destroy() -> hidpp_ff_destroy() reads hidpp->private_data and
hidpp->hid_dev from the freed hidpp struct and writes g920->ff =3D NULL into
the freed g920 struct.  A later patch in this series, commit "HID:
logitech-hidpp: execute G920 range sysfs store synchronously", removes the
g920->ff assignment, but hidpp_ff_destroy() still dereferences the freed
data->hidpp and hidpp->hid_dev in hid_info().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-hid-logite=
ch-hidpp-next-v3-0-ba39242d4336@gmail.com?part=3D6
