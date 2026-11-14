Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794617077;
	b=feN4mscaA6VuQWYZZoqp3081IFcbUYQARexpw4OozgiSX38A82RIMy0nQL2EChcTIbUn
	 RnP1G9Jve1ygnseD/vGiyX25y/Zd04kW/dnx9ALIKAuxolBfvOqMRXi8526C9Z49JDEtb
	 /kn8IOhD8M26hLESttAi3uE3toCn59wlta9J9+I+Tx2pqoyW1IJ6+QYQeq2Y61rFP8XtY
	 xLQjMFZLxyhCxIXLqgMXlpte/ttDc1TmAaKQdaOyZ0kA+YsM8JQwYliYIRwZUue7uA83G
	 J7PdGVktBeuq0M/2fVtn340qJ6wHI+4Fbje1XCN+S8q/fDvMM+vzT2mcZ1Jp4qyxExw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xwAL6dGtHMVxqNDDL5+JL8jIjc0RAYKuNZXYP5z212I=;
	b=vxrtjQkrdTQaqIzgUK7QvXpT1KmTxXy6a+UFthqop9VDgy89fsf4uv9j0oU11kc15Ij8
	 pwuhy9ssnl2MAUchqx652f+W4SIRN0YJs9Y48ELhzJvcH5K7ggEzEVnxUX7FltL6cZ8GL
	 GcdUYjATfNqTC/W3rPrrlrgZyDquLMMLqlRHqQnmOywsdMmVRjfUyEPkvEVm2VD/3sQw/
	 0+H048IpeGCjP/OsLdtrgwz1+4QzfPRoVBsahd8FKVlOIoDwcr1kvbw6xtyHI5gJUNfGh
	 rb1zFOq1wFODFTj5Lks0ZXPLrVbU9Xz8rgyTUFuqfuIs4Rb3k81et30ZsCinV0N3kbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yyyXew0G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C288606A88C
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 00:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C288606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yyyXew0G
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b360828905so16699937b3.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794617075; cv=none;
        d=google.com; s=arc-20260327;
        b=Dc9CC1SYSV021797excjLcJ2GUB2r5Uo75cw8ZXyi6DZzryKZ9z3f+htMy3hw3EW+X
         wBSvZlNz5cP+AbNdAyD5iwaUP5bAi38Ksvif8iScoK+ArLAKklJ8MpomeIxRyHEQ4Haa
         7jzL/QEchSWhUgokrHZf3Sh4SHsFx6iMktts6k+Ra31J6Tv0VwH9pa5mSoiOFO29gknV
         jhbJF0r8YfF1/8WPKgyumsab+3Xq+RKNSEG5GxQeRIv1Cvy077FOtK5Bz8sH/6kUXZ5R
         ef5x574Bnawz8ZOADLtHLrtOcc2kO0Vsby9MNpOXMD7ayZ3EshSF088rC0yjCZJuTGJj
         om9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xwAL6dGtHMVxqNDDL5+JL8jIjc0RAYKuNZXYP5z212I=;
        fh=K3tf5VvkFgAxbOm9LTXVRbEe89hzHA8Cith4nufwAWg=;
        b=KJMYlSb/NRr7l4FNpn9uTbpksqY51My9gw2Bdu6x8QJ8NyQQyhMM3IPO/OQwz89Kvg
         5QQGxFBYYtuWa4F2SMFZ634xoKgqDocJpMF1udfl8zchTU5CwT0ZgNmrxA2roHeKjdWg
         AB0HizH/hL3JBDPZa5k2g1AV1zTEIszFyLNy/Xa0Vz3CzPQSu6TWlFEcMnhkQXI5//zi
         9lTPjKlKcRDZHwaxHLlQDKV1MAs+vowtvObrz0J7aQJr/ItPkWBBopkRs93xqpHwA2k0
         OEk6S/CNUotkWrfKfsz/TkqB8/L30gDiLmLPwgXW5XgeAviTt66ZNRHCKakuW9WuDCB1
         oJuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794617075; x=1795221875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwAL6dGtHMVxqNDDL5+JL8jIjc0RAYKuNZXYP5z212I=;
        b=yyyXew0GOEe8lK58yuVMkm8hwSnAk7IJFf5JcJRf5t1OzNdm0mNO3SLSAr3JN/OGpN
         e49X7SJzRxxdPVwqjKulpViTYIEhet/04lPL3WHu7y0Vs0M6A0NUbjAZVPScnsfOoPJt
         vbqooDNfXuOd9mPgptaq+CIAGC4L/d/kjoMqFz2fOWOUwVo5DA3uB6UPHEEv1wkZW/QQ
         dykoOuqmuRD3AUYd0RhE5nknkCgodS6cJ+yr782vbZZ3rqQnu/jzTSj2X43XIKzjnRQK
         cNpHUSly21yYONeBOGysm/3bxbSzW5ihurs0B8X+OvURQvVLcgoUZdnbcJDEDKNEt0Pz
         SDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617075; x=1795221875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwAL6dGtHMVxqNDDL5+JL8jIjc0RAYKuNZXYP5z212I=;
        b=KzOcYIsac8zl2QF7UIQWGG6CY4+yQ5LC6dmTNqT9A7cSl3/yqJNnR16EJakaJlUciJ
         l8rNaGgoKE4GIHywZ1IQWkKdW5EEK5mHyHIv0onV3tE1V0Ncz1cq43/6zvDliAo8A8oA
         rj0BvK6P0HDng+KgRmVVCoua+g71nU+6ewfFDZLuLymwiqB+afXOuK36YtnK2G4cPup2
         NmSPej3bllYby8WLQcaQ1vPVOlCY0gix59MQhTuQZCZbECZKbdH1pJPJQGZHuPDhx6zr
         r4dsXEbmtbehqr4fMXBTKimvvdqdLe13G4fN3crQso7P+Sh0IB6gpVG30I1ZQFY/Jy5l
         lTcg==
X-Forwarded-Encrypted: i=1; AL+hErEAHBiXa6TrhvG3GCtpw34XWIwZWAASDJVE3zp+E0qpZzWXkHltkpVcT1/gD3r+jHI9EoqCJBAAf1nh6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GhMRQiM1VMUBAcuDpv1yXATunxDIo9RKC/Tiqi+OOCxlfxnHV
	zPd7s6Sc7bSvAmSTHrZ9c9syBXzzJW5tYEUpG1IesJp7D1XsnC86ObECT81Gf6jOJGet/SlWAK0
	WO1ZGisYaiRNBUnCrMuBdv44KgzuDHrg=
X-Gm-Gg: AYBFou258ViVOeFKyA/idPzlzYzd1toOXqluQFXKqSAD8LPcrpxMNYh3w5CqjHT8Dx9
	M6GQpgbQltWwHAFiv2+NXks8KQBNbPdLWywfFCdftYFoO6lOCJoqbDu8g0fUr1mPPv83dK9hk2b
	Wv8qC1HKl7f5XdCQseHVGj1UMaoJ+Irb8yrbeFBUl44dNGqGw7M91ikR+Xj1BhYGaSMDz9+W16y
	D2BtmJKZGwuu2j8zcUS6aExST8L41Qg/HU+XpyBT1lsHciMOC0D7q7bkioKQP2K8IsZ8NdMNqOu
	s2W17VPR4z5CPr9kVgvkyunkDZEO5BtnPoUaV1xKwnV7pyswmXLjXrVEDswGBwtyO23O9URUUPo
	K916nJOSUcZ+aAOvDhlgGAEkAExjkV8QbGJrUks7OXcZ/cm2HvLWlNMmpsva6pqvNqfQsqPfMXx
	ebJTa9zBKF2FrJNWMZJ6apwlbX7Jbypkd6qxuCn6kvr6QieuJhWhqs7hNJ9vKcZMjfYmhKFzLiE
	FrylOmfmh1tXNsKaC0F4z2c6gFV8OxP7kCPrz4SQIyN+8AJ6Yo8GNg9bCUhoA==
X-Received: by 2002:a05:690c:f02:b0:8b3:5314:54ff with SMTP id
 00721157ae682-8b4aa29e650mr23451787b3.62.1794617075301; Fri, 13 Nov 2026
 16:44:35 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114000220.1280581-1-dmitry.torokhov@gmail.com> <20261114000220.1280581-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20261114000220.1280581-2-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Nov 2026 02:43:58 +0200
X-Gm-Features: Aa3M54rnPrnkqfs08ifxk9j1MiGz30YxdylCOQmjdi0Tz0qU35-fn_UrRvunRUo
Message-ID: <CAHp75VdeUgonrBk+9DYHVi_QAquk5g2kCaMrxkQVnjh2SRR5qw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: tsc2007 - use scnprintf() when formatting phys string
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 2:02=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Use scnprintf() instead of snprintf() when constructing the physical
> device path string to follow kernel string formatting conventions.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
