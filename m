Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2F318146
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626526; cv=none; b=a8ovcvLtrWaQBcelbuDvza5iZ+vf7DDfwrx/2Xy0jTFA2Q66crmBsNQgTsEcI+AooOz0mDibKRhkRvh/6yLqT7IGOlvNJPCRFNQ5CnT1hu4NntRuxmVJY0lEEUSMVYpMoFzSpKLBTBzI2am0nehUNKY1XghUQsObJRb2wz++aYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626526; c=relaxed/simple;
	bh=LiYrdmZmpe82t7dlcM/f2AMhXxkyP+KlPiuEiIfS8hQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J6NP3uCtgENqsAOVf3LAZMm/4ZrxzsXZH6rRP4plEMf9Leu7UxJr2I0VK1oWR7LM/j3GJ7G1ql+2SC+6kugGkuTq9g5gp+sWsDO9GUg+DL7l4mPasj38COjxW+DsOZZiCHalOKSH/e0DNExMwQQhktnpRx/90UywPrH29PFcT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1SfwTvo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1SfwTvo"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4993dff5so1855665e87.3
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770626525; x=1771231325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cxn1uhOmh76vKJ6SWls1H47L/AWVvPiIPbvQPRDKQr8=;
        b=L1SfwTvoILdLWiZEM/WKIu+DQDmpBcgpgVzijYVryHfxXYLyZL6r9PF38UtqFncL/r
         6VwnOF5DGaQvbsKi5OEqR1RphjDzg8DqV7PvATylt823RkiVHPJP/Lmzdse1VkXJtltF
         /HR91rKSFkNGMmzzjqrYi0M/M/kvV61HeNNXwsJOjUpiIKInZC0NFW3tENP39PvexJ5g
         i7/aMqKhMazjSagPySl7jQTHNRUcbpAspxydL8WFvYnAgHfRBGaRWC6vd8MdyhFvmBuP
         j3HfPxeuK1oleeJpuJo4YY/C0AFEPg9OIfB9jsPRIdxaF3Jvtrx+YBaTNgauwtAXGTPp
         Xveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770626525; x=1771231325;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxn1uhOmh76vKJ6SWls1H47L/AWVvPiIPbvQPRDKQr8=;
        b=KnAabhBDuMRVLufst3u0KcVF8QSO3NnXKLZf+XnKTJDPSIIcp6FJ78JXU1Lv92H6lP
         bHG5bdHo983GzYOEW55NaOqRKExxAPO3ZlW+uAN8jlIHWGfYsKBdgibS+p1KJKjqHykS
         O2oeYxXI8+7PxJd+UPpnuLeM955OLfJiGy1TKHAJ+5KZSeifN/OQ1TVDhH3re0UiOOtu
         dg7NZdnFR3x383i5ZiEuIxfDqWlmqIijl7/IaBc7ZgSQtxHmVteYbPKyOQIca2e48qCN
         s9R+z8fSJQbXeNeSm2BdKxqHpkC4wHn8+marTl3WDW4koch4ntzy9ziA85bmX6w5sjgB
         fRmg==
X-Forwarded-Encrypted: i=1; AJvYcCUwjXC3LXem9XRYHzALr7+zPsWCJtlLot1IclfW1zKQhxNSm11Dld4BNT5MUBi6Q+luHTHM0B3w4LneOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4FaLVo8GmU/l6q2qcvrlh28i6gTflxu/HWsdePTgtT5wr1n4B
	9HlnvQtA53p9suKBH1AHNgDXXAn9o4Hx0DW1tEpVyzCeBmlnuvCoAbT9GbLjINhq
X-Gm-Gg: AZuq6aLklAeVwPdPuCCfrbsi7K32bc+qIe/TiRXexHbDChzUG/8bHgnCQWN+/WkzfIC
	TeBugZejq5v4RZTL6d3Myoq7oACqFfBeRhGjVtywcDLX9rh87pBPeWaXat5KFqntty985xXyBXA
	D+YLtBXES7WB87cMMFu8Pum9vrR7HDSWFeCypYEvtsJT2vjpJoaJtMXdOaknPziA4RlhQyFpuOB
	bBv1rMxQlM3E5UrvZDYIA5ryTvk0i8fOlEaKUk6LZf3XIGlOlEK4arApRMWdOZG/86yRyLkao40
	GvaQP36ETJPpQ0DsfjtPkWC00TNjbQOeODZmMeDFwdrH9mUiUC7PwXnTC2Tmz/0Ony/qC9MwqMx
	ZFjj+btoWdcf8jFWZjOh+08NOS5FTAKeaTGjJkBNNB0YOkdx0xEWxbJ7nCs3fSCsNfvvqwvs4fx
	X62CzIu6QrKS86f+IozGwU
X-Received: by 2002:a05:6512:32c8:b0:59b:9ff8:468e with SMTP id 2adb3069b0e04-59e45156946mr3840197e87.31.1770626524350;
        Mon, 09 Feb 2026 00:42:04 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.105.239])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44d29a48sm2425411e87.62.2026.02.09.00.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:42:03 -0800 (PST)
Date: Mon, 09 Feb 2026 10:42:02 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_10/11=5D_mfd=3A_motorola-c?=
 =?US-ASCII?Q?pcap=3A_diverge_configuration_per-board?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aYmYcd0431P5sUtq@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-11-clamor95@gmail.com> <aYiHnUW93AB0ARJH@smile.fi.intel.com> <D8B3E97F-3405-4EBD-882D-677F530E4EDB@gmail.com> <aYmYcd0431P5sUtq@smile.fi.intel.com>
Message-ID: <5AA39777-F5C8-4AD5-A5C2-47265C8213F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



9 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 10:18:57 GMT=
+02:00, Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> =D0=BF=D0=B8=D1=
=88=D0=B5:
>On Sun, Feb 08, 2026 at 05:19:49PM +0200, Svyatoslav Ryhel wrote:
>> 8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 14:54:53 =
GMT+02:00, Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> =D0=BF=D0=B8=
=D1=88=D0=B5:
>> >On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:
>
>=2E=2E=2E
>
>> >> -static const struct of_device_id cpcap_of_match[] =3D {
>> >> -	{ =2Ecompatible =3D "motorola,cpcap", },
>> >> -	{ =2Ecompatible =3D "st,6556002", },
>> >> -	{},
>> >> -};
>> >> -MODULE_DEVICE_TABLE(of, cpcap_of_match);
>> >> -
>> >>  static const struct spi_device_id cpcap_spi_ids[] =3D {
>> >>  	{ =2Ename =3D "cpcap", },
>> >>  	{ =2Ename =3D "6556002", },
>> >> +	{ =2Ename =3D "mapphone-cpcap", },
>> >>  	{},
>> >>  };
>> >
>> >This  also needs to be converted to use driver data=2E
>>=20
>> I can do that, but is it needed?
>
>For the consistency's sake=2E
>Also brief look at MFD SPI drivers I see that most of them use driver dat=
a=2E
>All that is redundancy? Maybe clean them up as well to show the point?
>
>> This id table, if I understand correctly, is here solely to silence war=
nings
>> about missing spi id table=2E Driver itself does not use it in any way =
and will
>> never use since all available devices that use this driver rely solely =
on the
>> device tree, all possible future devices will be relying on device tree=
 too
>> due to obvious reasons=2E
>
>Then maybe SPI should be fixed to avoid this table to be present? (But do=
n't
>waste your time, it will be a rabbit hole=2E)
>
>> >>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
>
>=2E=2E=2E
>
>> And please, may you contain all your reviewing in one iteration=2E Then=
 both of
>> us will spend less time working on the patch=2E Thank you!
>
>It's an impossible request, you should understand that=2E If you want, us=
e AI
>or your robot colleagues for that, I'm just a human being, I can't see
>everything at once=2E
>

Ability to see only nits and don't see the possible issues seems to be a t=
alent=2E

>
