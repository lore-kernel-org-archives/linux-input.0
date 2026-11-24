Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795542408;
	b=04UhAwOEEbHzL10IhmmP3La6wzAop6T+eaRGOrvt2HB6FvGR8TI+a8bKriNidDnHkzBh
	 cFc5kJL/Vgo50kBfosNCcKHohUDSbjDl0tTJ+BipqYpjxOVVElGUvXkx4t80qhN8E7WGI
	 5WCkOyf1BzxS94nrMJOA6shP7neBgHA3uvjDZrPtEox9MKhfEackEOLolLSAyq5YaThh/
	 iENMOxTqrteBXhwOfHA7FNrvMFwHLKgI61pLpF23VUsYGn/kH++0QSdnddzrOV5ajQqPg
	 e9GVr6bhT5y29dEbKP5gORp7L0cfXaQ5huc8cxFTRkOt0HD+HA6KWwxA1AW4JyDrhIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542408;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=H2f5l5LeTXDL7+v9Qv97t5mgH+JUfpOtVYF84J+Zklw=;
	b=ZeW6BrbNoCiKhQpD+RrznKjbwZd8tUn2dAH2GPuP0Dro2vR1mFb9YhvrYDhlYd/x1meF
	 7nVem/SSS50H4AQkzoHg1edYG9YYSiLB0Pd8slETpW9LN9ATfYeovEXSKVNAcc5iHAiJM
	 HQRmBCIavZv3mQCnKwBVMyrPjwscMZnaznvNmwuYWdHEquyghdW7OnV6i2tIpj4qb3NeE
	 Q7F5nt+HSEHhfXpEOnP0wqZaLs2tCk7hSGuOmRDfwkOblYNc7cGCrv66lQg0AOSiJvm7z
	 Cs7cCNScYfanBjyJNw/MDLrCS1ZS8PPP718PtL2hPqRBnqhkJv0PhWA/13C5sDL2aWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=nmfYG8Ns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.112
Received: from sender6-pp-f112.zoho.com (sender6-pp-f112.zoho.com [165.173.180.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A6606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 17:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E17A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=nmfYG8Ns
ARC-Seal: i=1; a=rsa-sha256; t=1795542402; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gFy7vilkW5CIKvHUSrqsA/yVXOxUG2ZkVe1E8peh/nBLgxYM/c+7hmo0Hy95t3tSaFJGQhqm9itGoiJLSoBTEplPgkXdssPouCJmCEhn/0iENVJ2u2Jde3O7WnC6wNxxke5VESCF3GlQo3wqcJTJGVP4osvPLCw3syaLS+RH4O0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795542402; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H2f5l5LeTXDL7+v9Qv97t5mgH+JUfpOtVYF84J+Zklw=; 
	b=ikrZCCqYQspV9FqOHX5CGOSX9ZE3EB7GXFg5r4HfOXk5PhP8poo6h3V19HLHKDCDisGL3MX4oHAWo3llpO6u86aysgGmkxdk1NNE/drPXuHd3vqQrlLL8gkmFTm4yxnQDseFkQQie/LDhwwhQhbpTR7ql+ifNjwu/Kvl+EXho1U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=nmfYG8Ns7ExuWzLY/GKNqEe50d4a8lSyS2nI2Mhopzu0gUpKU9GHvMK/vhl2v3JF5JW+zIrOpHsUojvS8VdaRKyVLFi8iWegC3tc7oLKGuDyMwp+zJ/r9b/L8VQ7VPFFgNA07YQ/orcM8TZMNDupoY30bSRMfOIXM+MCDZ6gUX4pknJd2PSmLhZm3pk1KTLrRH+AbDt8X8oAVXAaGuSf2O2grQGu79lp2bJvemCKoA1ehl05nZ6F5DqkZU2o8kjoq+C2ncvgs2Gq+qGRb5PS8EAl7c+ZF77+dTBF6X3cL+OJpR8OfPT1ju5gqHrTQoAByrh9oYClFsBMf7tY9ccicA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=H2f5l5LeTXDL7+v9Qv97t5mgH+JUfpOtVYF84J+Zklw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795542401014413.03002637860595;
	Tue, 24 Nov 2026 09:46:41 -0800 (PST)
Message-ID: <1d4a4165214fc54a1325ba2298e937751d61f5fb.camel@rong.moe>
Subject: Re: [PATCH v4 8/9] HID: haptic: Convert into a loadable plugin
 module
From: Rong Zhang <i@rong.moe>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <sashiko-outbox-231651@kernel.org>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
	 <20261125-hid-haptic-kmod-v4-8-03713a89f656@rong.moe>
	 <sashiko-outbox-231651@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 01:41:34 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-4 
X-ZohoMailClient: External

Hi All,

On Tue, 2026-11-24 at 17:04 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] HID: haptic: module unload race via hid_plugin_put() in
>   hid-haptic.ko
> --
>=20
> commit 36f36535430850c43124dc68d1bb0a9b639c5f30
> Author: Rong Zhang <i@rong.moe>
>=20
> HID: haptic: Convert into a loadable plugin module
>=20
> This commit converts hid-haptic into a loadable module using the
> hid-plugin framework so that hid-multitouch can load it on demand.
>=20
> Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc=
35inqda3exwzs3tk3ff@oagat6g46zto/
>=20
> > diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> > index cbe834a77fd47..50d6673c7c211 100644
> > --- a/drivers/hid/hid-haptic.c
> > +++ b/drivers/hid/hid-haptic.c
> > @@ -310,11 +310,12 @@ static void hid_haptic_destroy(struct ff_device *=
ff)
> > =20
> >  =09kfree(haptic->hid_usage_map);
> >  =09haptic->hid_usage_map =3D NULL;
> > +
> > +=09hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
> >  }
> > =20
> > -int hid_haptic_init(struct hid_device *hdev,
> > -=09=09    struct hid_haptic_device *haptic,
> > -=09=09    struct input_dev *dev)
> > +static int __hid_haptic_init(struct hid_device *hdev, struct hid_hapti=
c_device *haptic,
> > +=09=09=09     struct input_dev *dev)
> >  {
> >  =09struct ff_device *ff;
> >  =09int ret =3D 0, r;
> > @@ -436,6 +437,20 @@ int hid_haptic_init(struct hid_device *hdev,
> >  =09haptic->hid_usage_map =3D NULL;
> >  exit:
> >  =09dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->n=
ame, ret);
> > +=09hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
> >  =09return ret;
> >  }
>=20
> [Severity: Medium]
> Can calling hid_plugin_put() from inside hid_haptic_destroy() and
> __hid_haptic_init() allow hid-haptic.ko to be unmapped while a CPU is
> still executing inside it?
>=20
> hid_plugin_put() is an inline helper that calls module_put(plugin->owner)=
,
> where plugin->owner is THIS_MODULE (hid-haptic.ko).  Because
> hid-multitouch holds no direct symbol dependency on hid-haptic.ko, the
> module refcount acquired by hid_plugin_get() is the only thing keeping th=
e
> module loaded:
>=20
> CPU0                                  CPU1
> input_ff_destroy()
>   ff->destroy() [hid_haptic_destroy]
>     hid_plugin_put()
>       module_put(THIS_MODULE)
>         atomic_dec_if_positive()
>                                       delete_module("hid_haptic")
>                                         try_stop_module()
>                                         mod->exit()
>                                         free_module()
>         trace_module_put()
>     return;  <-- page fault on unmapped hid-haptic.ko text
>=20
> The same race exists on the error path of __hid_haptic_init().  To avoid
> executing module text after dropping the last reference, the caller
> outside hid-haptic.ko should call hid_plugin_put() after
> self_plugin->init() fails or after the destroy callback returns.

Due to how the FF core is designed, I haven't figure out an approach to
move the ff->destroy() callback outside hid-haptic.

I originally planned to prepare another series to make hid-haptic generic
by attaching it to hid-input after this series is applied (because I
bought a Logitech MX Master 4 two weeks ago), but haven't started working
on it. If the delete_module() race is a concern, I think it would be
better to implement the plan in v5, so that we can defer hid_plugin_put()
to hid-input or hid-core.

Thanks,
Rong
