Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794549683;
	b=Jn6CCvbN/URICxt0YQqDduS1RLhbDUyIojlgyTw2XO0sf4bhQ4XsYAkn89IKvTw2XkmI
	 +R9rkrbRZpEkw/5LWW70yXFiX8ps64n2cicEe0VqLuA352ESKS/6+h7P21gEx8lFfnEK5
	 PwLJq4kESiQpYlZ6R2QALynnplgSUaYjYZldAdHS4BbaTR0UhJJnhkK/yIXYDFTtGUnCj
	 Nvw885MMQTuEwMis5/pvqbMgUX7UssaTzhHhuV/kqjaN3TCJJAEzbYka3unctl97W9MA+
	 PkaYK/cv2sR83A6D1vA5VLD47ruALxmc7FyAvqURIoHagjCzhk6rr2lFbn0uRVGbgJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
	b=A+Qqw3IEOpLrHUvo8DWWXDfOSMKEkECu0m9sBjUYX3PU5Neg7+wW1eT/9nqN6cZ58RXB
	 DcTnLSj/mTsUhZm1H0QeWDLkUljzHKp7mQdpXGDjuKKtOILWW+aJCYx/8LYEO+Xd9YKuO
	 4Nzjnn0MjfC1hmjQxIHUYBKvXcPxX5uNCRKqVlPVWZYHs+24Y2jvLVrUTB/kSafb5RvwJ
	 FTrjsNesoCDa0MSmkp+ianUdWMMysR4Uu8tEOmr5ba4n4MXiO333IsjkIJU1zt+MSCf5q
	 nIQfYGd6evgJvWCHMKzq0XaILLYHV1sVEXl+dJK3U8NkR+KWEPROYnL6xki/LIK/XwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JV5Ui/fM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1D606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 06:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A1D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JV5Ui/fM
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-675617e81f9so520605d50.3
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 22:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794549682; cv=none;
        d=google.com; s=arc-20260327;
        b=gpWh87atnnC4FB3iIxUqyDNEQVLWlOAWSSOTEQoNHbskCPOs7aDu0gWKVe6bEDvE9H
         KoRFb2unraIRBJL6aT0RpOvTWRA36V8zOBQYwILogo00s0rxNx7WR7dr9UMHwws+NG1w
         p5wjN6xrLHJOIO9bPr3LcdST79OhRdtmIU1XY3Fnd4+ozlZop0YHf3VrxbiLYOKuJyTJ
         e8bFtzHHA45ul4K4wRXRhj7lzTyLkXYoHmXI6lf2eF7oXQ7Fg6wtOQp5zLJBKtbghE0/
         Ad7b1+X9NnczJ/33Wo0Q229MTBwnbbjziz6mEIPH7xUXkBzHLGzDWAhuWnbDP//0tDMs
         hQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
        fh=Aoj0ROVv9ywF9spbDJ0zOsL+RgtpPSHoBd49wOeRQAE=;
        b=iidBVsKXqrmKcgqOCNXCsTZfjtoZqc4u3mDjHge9Ltppowp2TK57LLBS8kLq7N2bP8
         qBtpsEDG7YSut8Qt19TfVKohh2sfLJfqAHbna0gEJB6Sm+KAog+zV2aHaXBSIsHaLzex
         Uv+6wZrMyfeA3JqUhHNUcgcBjBEYmgZIaidm0kqhkNslZ3X2Syj/opvYY9wjPjW8zWsK
         EW3O6m0rUf3V2LOkd3ox8usWPIHYzAt586MLNbjh16LIWrOpjqdGhFrB3Pw1LbVtWjKC
         fyAKtdWuWQs9FHtY3SdJ1XQ+gFaV3uF6YcwIa6vqPCKnfPNjDHjwQcexA7OfWgLT7Z4L
         l65w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794549682; x=1795154482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
        b=JV5Ui/fMb+EZK4MuX+mzfFOxOk/sGuf81ovXRjwIHWbo0As8IxrbfzlA7h8E7MigVw
         /mGg5KoBLHCj94pd/RG+xDAi/p9HhMw/tFGLHAWKAl2zvtMQ2PJiUTYdfpAIXuDs5We4
         WUQR3EuUT1Iz/duhfVt3OKnSLhXWTbZe0L24JB7FgijjzrrkXv/AUaXzd4OPZ5ynSflZ
         DOzwuXiAf2/xLdHl1cqcCSEvanP+9bkPHc8mSk8VsRNGhOPJ4W89p3yCh1dtlpO6pGLq
         g8Cj1rLjfrBKcG/l8bOnYSikb+DNbR19rNmT6q8ywRboFTHJZM31A3RCtEkvcBiu3cld
         YDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794549682; x=1795154482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
        b=vCwlAL6dQGP8XEbyZwzvNwofpOK+FTK6TGbtRI/n0dGL+royL7xsgpa9gFNRm0OSWT
         Mj8+yGCf6PVhgZOnjuU5H/Sx4VXjhquf4enBZAa9w20KR5GmkEqQOje1vj9+WxP9Ou8l
         dY7j3XnhAPKDRRRODav72i8HWTQ5HdgmWDuILJ89ofbgaaSCIF0cz2Yr9cAFxy5o7mQI
         lBIdrF+Me+fPbaIGoTAjYhO1mIn5gPvNO0g8jAqjLiAxIvB+gyIXGCZiVgJpQjIZ5aCl
         k5aPpdRjl6yXz4Q5kcIRQj47e/gtgo/4feIDknu7UTa8o7RkHFfzou3LPeCf1uOdY8GJ
         6Ewg==
X-Forwarded-Encrypted: i=1; AL+hErEdm1ve5ble6kFNaUGEKG0KpLGQRki3l88EkysCW8oSe/Hx7Y6TfYxAk336baif77pGq/FDzK4wV4mNow==@vger.kernel.org
X-Gm-Message-State: APuU4Z9AoTdvexLg7pTCeDKTlObD5OHDsraqde49/63aoLY3Rkc6APNN
	WFZ75RsLT4JUIehEjWPlVtm5MlJM0wBaXLKQygpwoMDYQCZL6Y5x7El/YuAfL1dTbdOODSbrztd
	d0JI8jXcwr7GOhDKbYpFNSvigrAW6kXg=
X-Gm-Gg: AYBFou1Xg2LngWdLZz6x1aG4ym+u2d8YfN/yzCmnRkOMPwTqjdIc760yi/gWrGnRVmJ
	+nzmryEoBguwlLIhukHJXFuFv369zTQ1mKpw5eMWXyzs+bm0qmyuy35Ij2PPP56N3HSxv5KUCo/
	vShIFtjq5XRY/X9psFccUgnxhE/azyRw0GYSSPlBGfU3lnq13m8QDxqS0xIx5wzH8W6OZH7eMJN
	jBphQo1c23BG4xfNvW8X54oZYndkK1y2vHVATbKvGu0v/6cCeEL72W7BZYpwPGz5mioC/eP2z6Y
	XpePq9HqPLPhP6TdJUdjIy/h7SzMKZuEargUWlZ7YUHt8lfJBl02ZyS+1LyVc8c7owDyRD3Yl1t
	SPCOLwqnLsVKRK/afbjLSVgBCPBOoHdtUWkX25zai7xwq7bDUT9hAiaKfyPPvRoVbzLN2cw==
X-Received: by 2002:a05:690e:484f:b0:67c:1557:7b69 with SMTP id
 956f58d0204a3-67d896b2da0mr743837d50.58.1794549681857; Thu, 12 Nov 2026
 22:01:21 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
 <2f722967b6db0692d4dd4164aff39b62@gmail.com> <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com>
 <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com>
 <CAPb1+K1mmyvipXSx96-j-+zgxeTztLNfYYTuERw0Ykf5WDv9sg@mail.gmail.com>
 <CAPb1+K2NSGzvp5b8_CfRrDK2trD74+pCi_a+OYV4cza++DP=8w@mail.gmail.com> <5252f18157db7e26e27dd3ae2acb5b39@gmail.com>
In-Reply-To: <5252f18157db7e26e27dd3ae2acb5b39@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Fri, 13 Nov 2026 07:01:08 +0100
X-Gm-Features: AclHuK_hQ0eMyCKYBJK8TqPVDkMz_GToazsA-5wv3SadGkydCXgL8Hl4QXBPYv4
Message-ID: <CAPb1+K0_UXcaZWvfmhEt4B1AxH71D8hgaEyF0juoA=cU2aT7Hg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks! Yes, please add my Tested-by to the input core patch and to
the hid-logitech-hidpp series patches when you respin (without 22/33).

Tested-by: Gideon Heinz gideonheinz02@gmail.com

I will keep running this combination on my G920 and report if anything show=
s up.

Thanks,
Gideon


On Fri, Nov 13, 2026 at 6:39=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Gideon,
>
> On Thu, Nov 12, 2026 at 03:50:37PM +0100, Gideon Heinz wrote:
> > Hi Dmitry,
> >
> > One more result, this time the combination you asked for: your input
> > core patch in the kernel, plus the v2 series without patch 22/33 as
> > the driver.
> >
> > Setup: CachyOS 7.3.4 kernel with only your "Input: destroy
> > force-feedback device on input unregistration" patch built in. On top
> > of that, hid-logitech-hidpp built out of tree against the 7.3.4
> > headers from your v2 base (630059a5a632) with patches 1-21 and 23-33
> > (7.3.4 already has a different G920 init fix, so I could not apply the
> > series to the in-tree driver directly).
> >
> > Same reproduction: fftest holding the G920 event node at the effect
> > prompt, rmmod hid_logitech_hidpp, then exiting fftest. Result: rmmod
> > returns in 98 ms, there are no "Failed to send command to device!"
> > lines at all, no hung task warning, and fftest exits normally with the
> > machine staying up. For comparison, your input patch with the stock
> > 7.3.4 driver took about 3 minutes and printed 12 failures, as in my
> > previous mail.
> >
> > If you would like me to add a Tested-by for the combination (input
> > patch + series without 22/33), please say so.
>
> Thank you again for all the thorough testing and for verifying both the
> input core patch and the updated hid-logitech-hidpp series!
>
> I have added your Tested-by to the input core patch and will merge it
> through the input tree myself. I will also give Benjamin and Jiri a
> chance to take a look at the hid-logitech-hidpp series, and with your
> permission I will add your Tested-by to those patches as well if I need
> to respin them (and drop patch 22/33 in favor of the input core change).
>
> Thanks.
>
> --
> Dmitry
