Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843794;
	b=byax4RNw66Ny2ouZ2TspgLlKFFDRVGxEgDjooNCkr0hrM0/f0CWEm3kF7maURgEHvbCT
	 eBxKIHNwJODnUeaw4W0T1jHAKsxKuSzL0f4z906wUhTG7h33oVa+dYLLXL+XFpAyDGfa8
	 ZVJ4twBdpJVGVxmJWqF1OJowAo8we1BwE5tj9gpms0iAVfWJaIGCOSGOmwiMblWK4oUts
	 DxcexV//t8s5D4R6202zvoA2PtZsKrehUR+Rhud1yjIS+2jVauWKWN+QhzaOv7epA2+Dj
	 w4iOoXlj+wslA7pjHOpzjhXUykt4d5EMuGLztdIHOgSi1U2IAEb6F7qF6NIl0RxTkcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=IJHaffMbI0latXPW/JhLxzhVe23CKe4SRtO0nvr3eEQ=;
	b=GoqhcPmt8U3sV+zGTTALPdk4kN/apq5WrKOBgrmlk+gY2nTWJdNM8U04ztzFBv6bf1Wt
	 WBC4F6GjdWkACYjJApI9l3Apd/q5JyysJwZuUh1LMUgr+CjYmhgPRUE2ytNyMmbSOhWwR
	 CBfr9pC1MtzrjCefg8mdC0gRvHNOW8SXltEEBtnmX3CkcXLww5ja10/b8GMLcO+nxZcqG
	 OBkMrjIT5oW1Plnazjq0MeIzszAsBzi/MSA4Melv/ODme+Qt9/oLfJjCg2GPne1MGrofF
	 jJU+RF86i4VuH2xA4Ug5inQ8x2+8UzWoEHU8uZ7BxiCLfLtUnbK9NBnQqgWrVuVbkKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIvOPpZe;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6F606A32F
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 15:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD6F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIvOPpZe
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso24743935e9.0
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 07:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794843792; x=1795448592; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IJHaffMbI0latXPW/JhLxzhVe23CKe4SRtO0nvr3eEQ=;
        b=iIvOPpZeZLBZWJF6EwF5PeDI4dDMbrbhPK0GLlfxkNxFIpqiLeXYcmd+snPJMChlQN
         S7XQmJi2+nRMlGVr0gefCmiLsnRdDuqWcNchF3t0QiyrGQE+3gyEl9ohNWXEYEKX9m8t
         8RLVLlUK7TJi2QnofN1OXTacA4+o5UGo5EKkllv8QSGwF4rQBUCAK4+twJD2lvhiVyeC
         WUKQdxqc6htoMFctdDNLBaSH7L4TxoudGGv63yEUtmBD3owZ46XNNYodOFBx7jl9/GBJ
         BHmd1AZOLinvCxrLjiHCq9D1unCCBXNrLBcG7/mS4J4GHYjcq5E+RDGWCz0oZd6a1+Br
         GQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843792; x=1795448592;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJHaffMbI0latXPW/JhLxzhVe23CKe4SRtO0nvr3eEQ=;
        b=SsErp+YsgE6Q1DKbpHPtxipuHlPiTJ5zQe8o3w8BIDc6kNr6fFR7t3tUGRWeXKV4ZO
         QVCapwjUr5kiu/bOWqdKrlkQnR8rkY11bB9AmVdXRdFq7rNNGfx35fggOvg9tbJU4aA8
         Pq3Sv0sihYiRYu5EaBci7oIN+3lKq7Rg4tnfqUX1YUVtCvx78wQ9nuS3ITk5KIg+ASB8
         P8hlwlwFnhJdW4lLhnHmQuAsHIBpvNMw+TN0thSA1kkXnshcXe1WzNsoASy7yLvOnYd0
         +7T9uOyhHzFbd+tlkvnjcmKMpUzs5grYPG1UUF7U3cQy6/gYhau0XLOshJmH5oZMEB9T
         oVWA==
X-Forwarded-Encrypted: i=1; AL+hErFEdxeW4LKCx3ZchgdiPrI5G66skXcPP5q+CcPH07+B6EV12ty6Z89BbA711bFuE/WCrvaERRoZlnEkeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8lPRqoczgdMz7RDJ2h0caugEzzsAo5kBfmn97Bcr0OjsjXfUWn
	rtsgSy0TibH+yyDOfoTOVNm5Ekw4rGOarmvIXkTuepGfQ2aSAhLPXs/j
X-Gm-Gg: AYBFou0phPmbAVlFsOLpshF0aIUtSFsJ3LC1LMMIP+14Vyn95jE0PvxwMvD0rmCAx8g
	Y2/asYPTh9nBfKsw/6WB6e3rnbSSmJUb5ZGRW0uDu+wJ4drGvzCZUCXM+o7KlOZu1ElFzwjxVWJ
	knGqIx0J6ApRQIDuv3aT9glsFQ3t4gEotY5PX0oQCuAfkaV49hs68vVQvUTZubQNWum0At+sTHx
	JHLqj75U/+JgStaooEJBr9vGp/IOQTd5i6aq42XpJroLbhxHXSpjb8evjMrpgsd0145j3Jw9KZt
	QSPcy5b8Gs1HOcCUI6Y8HaOsQar+XEHDPXxzcM9dRsHb/LFcyVZvrR/3PcgOiBRqemX+m09lBS0
	G+2gBjE4P9WIgkbdkXmEQrQljXIj+Y97Of6Xs7xNc2agcLCfS+I4MVi+q2tGvh1om7dz3llJyFd
	QK4E7DCR892qh4kPOP+XzdTjeu8bBwIDUb7t4kGZ1LYxha4pF6P0ZjGpnLyoBP3llF2N8LnPIWr
	Jdf/+KlvXxVLsmaVUnpXgGBD+wXH9mh1dGN5HUYhYHC8Xai+7bwscZD2xJhTSwAOH3FEJuITMhL
	WUvazPjgmgMkS4KbYnQ2SzEV1reoTpin2L5zsvuOa+WktuP81gW5TE3o6ZOppuU5susoMez+tGB
	eHYegyB90l3vizODLyhjWfT8jB+nlkz4J9l9juvXKR4O186jThYXWRM9afmNOZ58+FWUUOwL52V
	4LTUjn6XvpExWKKk/5l9Col+gMPubFVriWyl29PNJBvyrq4PgioiUiSHCF7SPAWOBo9JznXXR31
	19wSjtu2m+kews+vDeItmGYEui1fg2Ccx4L2UKcqQGIHZjFwG000814xF/o
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr237565075e9.13.1794843792030;
        Mon, 16 Nov 2026 07:43:12 -0800 (PST)
Received: from jernej-laptop.localnet (95-143-148-21.dynamic.telemach.net. [95.143.148.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6caae30csm116544885e9.2.2026.11.16.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:43:11 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - support the AXP313A power key
Date: Mon, 16 Nov 2026 16:43:10 +0100
Message-ID: <0au3zkKrQ_KG8TbI4m_Fyg@gmail.com>
In-Reply-To: <9639a3578bf1cae847b4b0cdddd1a0e0@gmail.com>
References:
 <20261115150903.16855-1-jernej.skrabec@gmail.com>
 <9639a3578bf1cae847b4b0cdddd1a0e0@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 16. november 2026 ob 08:39:21 Srednjeevropski standardni =
=C4=8Das je Dmitry Torokhov napisal(a):
> Hi Jernej,
>=20
> On Sun, Nov 15, 2026 at 04:09:03PM +0100, Jernej Skrabec wrote:
> > The AXP313A MFD cell is registered as "axp313a-pek", which this driver
> > doesn't match, so the power key doesn't work on boards with this PMIC.
> ...
> > +/* The AXP313A has no AXP20X_PEK_KEY register, so no timing controls. =
*/
> > +static const struct axp20x_info axp313a_info =3D { };
> > +
> >  static ssize_t axp20x_show_attr(struct device *dev,
> >  				const struct axp20x_time *time,
> >  				unsigned int mask, char *buf)
> > @@ -193,7 +196,26 @@ static struct attribute *axp20x_attrs[] =3D {
> >  	&dev_attr_shutdown.attr,
> >  	NULL,
> >  };
> > -ATTRIBUTE_GROUPS(axp20x);
> > +
> > +static umode_t axp20x_attr_is_visible(struct kobject *kobj,
> > +				      struct attribute *attr, int n)
> > +{
> > +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(kobj_to_dev(kobj));
> > +
> > +	if (attr =3D=3D &dev_attr_startup.attr && !axp20x_pek->info->startup_=
time)
> > +		return 0;
> > +
> > +	if (attr =3D=3D &dev_attr_shutdown.attr && !axp20x_pek->info->shutdow=
n_time)
> > +		return 0;
> > +
> > +	return attr->mode;
> > +}
>=20
> axp20x_pek->info is only used by the startup and shutdown sysfs
> attributes, and we do not have variants that support only one of them.
> Can we drop the empty axp313a_info structure (leaving driver_data as 0
> for "axp313a-pek") and simplify this to:
>=20
> 	return axp20x_pek->info ? attr->mode : 0;
>=20
> ?
>=20
> Thanks.
>=20
>=20

Makes sense, will do.

Best regards,
Jernej



