Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539886;
	b=P8FB2E6ORpEWOIiS7kug0z0/A8IG3jyNnBSQYxOy4p43bmW6YgEedl9C9ugIGaTFhnNy
	 V2oTl+oiwrkHYdpMfrSL0ewHAfgArUo0QtW0wJU3g7EZO5kIGe2Mpv+TR7nNSzQ1G1vuL
	 zWX4dbuYlZpmInq2FD8BqjXhIUWax/hoswE8ym7t5qnyLItqBYEfYXSbaf8XcZM9AQnXv
	 ikuviQOq1ThmD7BMz5fBV2YEjxABTtqL9i4EvDtH7SQO69M9TQr7iwD4g+/rGzBYU1wih
	 RiDs70P1nVbYhEKZVQP+tu4dkA5cD7bbrbM0PveFAY+czgheyjoQWZhdkmNRPYGQ5yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539886;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OdFN8OH1jfIKIY4uZYUtxur8TK7hOkAru+imBWHpmCQ=;
	b=a3a6Gb5rq9LrJiGod0h6ytvnhuYZjT1SB4XFGSgV+khtNP8yQEv87Oee605d+7qyPH7T
	 ht5iSFBWgHRyCzJo1dtzTYM5Ak+r9Bhd0BwuZawaVh6KyRsR/sN0yjfPpQT5dWYM8JtmE
	 KIEQ4GZSYAgs+ae4FTjN8j/dHtQG086CDcxKvrabCtWs9lsFjMgYgJihhHhnJhZ2rzym0
	 qcy4wPrF1uhMw5Ncf4AKW2brwRpsTzWskn5c3ejZ8IBP1CIu/8la7sT3P2B5Qzd5B6+ZK
	 5X2fduK7Jtzw5yBHLeQAUWdjEUcKbBmVLX0fWkp3Y/nQw5OU5wXMoSci32Vrxr21yQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OmJ/QVKQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B4606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmJ/QVKQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A211C1F000C4;
	Tue, 24 Nov 2026 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539885;
	bh=OdFN8OH1jfIKIY4uZYUtxur8TK7hOkAru+imBWHpmCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmJ/QVKQRoHFaRAcmQFGBvccQBoEDw8NaDU+46IvgMeqT7Gk68E9Yp4olOchLW45Y
	 TZk50YPHbQxqux2WIN9PyZOu7/WFEHnuuOfxM0/0GuZGGmTd5UzyRmJMse997LVj54
	 pZR6GjUEfpzOLpl4K4rDfQNmbvS8pha667HkCI7w7l4W167OTTx+QKPEibG51rb3UQ
	 I3nf4PDnUPqGMrt+IwzcoB3sI/xyQuFFEAndyY/9tCE9diDRyU7DXj2y0jU+IBQLNW
	 0hyP62v6tgdU73WzuPI/NSiqaZHM4uJkyq8WkjAagJpJR9u+k88ja51xKha4MnuHeM
	 4LvE2whunHs/w==
Message-ID: <sashiko-outbox-231651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] HID: haptic: Convert into a loadable plugin
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <i@rong.moe>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261125-hid-haptic-kmod-v4-8-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
 <20261125-hid-haptic-kmod-v4-8-03713a89f656@rong.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 17:04:45 +0000
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
- [Medium] HID: haptic: module unload race via hid_plugin_put() in
  hid-haptic.ko
--

commit 36f36535430850c43124dc68d1bb0a9b639c5f30
Author: Rong Zhang <i@rong.moe>

HID: haptic: Convert into a loadable plugin module

This commit converts hid-haptic into a loadable module using the
hid-plugin framework so that hid-multitouch can load it on demand.

Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35=
inqda3exwzs3tk3ff@oagat6g46zto/

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index cbe834a77fd47..50d6673c7c211 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -310,11 +310,12 @@ static void hid_haptic_destroy(struct ff_device *ff)
> =20
>  	kfree(haptic->hid_usage_map);
>  	haptic->hid_usage_map =3D NULL;
> +
> +	hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
>  }
> =20
> -int hid_haptic_init(struct hid_device *hdev,
> -		    struct hid_haptic_device *haptic,
> -		    struct input_dev *dev)
> +static int __hid_haptic_init(struct hid_device *hdev, struct hid_haptic_=
device *haptic,
> +			     struct input_dev *dev)
>  {
>  	struct ff_device *ff;
>  	int ret =3D 0, r;
> @@ -436,6 +437,20 @@ int hid_haptic_init(struct hid_device *hdev,
>  	haptic->hid_usage_map =3D NULL;
>  exit:
>  	dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->name,=
 ret);
> +	hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
>  	return ret;
>  }

[Severity: Medium]
Can calling hid_plugin_put() from inside hid_haptic_destroy() and
__hid_haptic_init() allow hid-haptic.ko to be unmapped while a CPU is
still executing inside it?

hid_plugin_put() is an inline helper that calls module_put(plugin->owner),
where plugin->owner is THIS_MODULE (hid-haptic.ko).  Because
hid-multitouch holds no direct symbol dependency on hid-haptic.ko, the
module refcount acquired by hid_plugin_get() is the only thing keeping the
module loaded:

CPU0                                  CPU1
input_ff_destroy()
  ff->destroy() [hid_haptic_destroy]
    hid_plugin_put()
      module_put(THIS_MODULE)
        atomic_dec_if_positive()
                                      delete_module("hid_haptic")
                                        try_stop_module()
                                        mod->exit()
                                        free_module()
        trace_module_put()
    return;  <-- page fault on unmapped hid-haptic.ko text

The same race exists on the error path of __hid_haptic_init().  To avoid
executing module text after dropping the last reference, the caller
outside hid-haptic.ko should call hid_plugin_put() after
self_plugin->init() fails or after the destroy callback returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-hid-haptic=
-kmod-v4-0-03713a89f656@rong.moe?part=3D8
