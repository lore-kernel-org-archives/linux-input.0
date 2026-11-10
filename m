Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318513;
	b=Dgoq0kNzpgojeH0025tkqz/6Soc64b8Onbp+DIjiImsvg2UYG4neGHPSbKydT8exUhtL
	 gDdJtCuQKBnm5An9n42YBhquQIvUIbsSGBhjBz+uW3M4OeOS++cVX+3iP4IDGcs9VckNH
	 bqwZHtFBiaOEGugiJ/o6J5Yr6Y8eXGDyK9HF90940wB+fDJbM5Uwrqss/hUVHeXlFgfKE
	 pNC4jrJ99j3yUDBeJZgnCYCc0Eide6kedhYL7VfhHE+XEzMhYxHT7eG9YXTvi5JPY/LB4
	 l/hSKj72a28cSGACdYptSn2PEkQ6KD75h+BtvvTjAgaESaC5azJjCQMWtqttvPng/jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Co4X+lJ4cTnZFILI0kHUCUVHOUrsje27fDkW0QWbJgw=;
	b=0hnkE6I7fOoLeOMrSaVTudFs1jFhzY8V5k7pB8ruWOa1ygq80jAPGz3nwSeEB4031tMU
	 sWWGHS/Hf29ZMIi6e6meX3LDMuDtOsj+KiDdiy4gM7BkGtlwzMjsDRewWqdIU3vozHbCd
	 RAbcZ479z5tYd8yokJLSy8ACbHpSOoIAAGpELr8K+usp6xLlwvABtgW1m0Dri7xLSZqUE
	 3GiKvLdydwZpKqWBGJlgmfA6JavqJU30uhHaxqQMzcq4k+JsOoqM6zlz+DIPiiJ7TixYF
	 fiEpFFsNyAFbC9HNQPfeKvZuTijjJeYa1/k3P3aMilSZmnhZaXHbi6SoZuIkzIPg+MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXfyOBZh;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B1606A326
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 13:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXfyOBZh
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2901925eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794318512; x=1794923312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Co4X+lJ4cTnZFILI0kHUCUVHOUrsje27fDkW0QWbJgw=;
        b=zXfyOBZhxWw8SbZHBTmtB7CK3cXMr5ykrNBzXsVqyPwfiXoq2qlPajWzAsD6cViDQ+
         xLnCjZ3r2COxxasXvuG0aLpIX4Ij+/1n7Zxgdp5EYg13S2G+aEWityyQBnVdnnUeenMI
         dIWK30BRw/QdBLVFotB6sVO7MeskSSCjCIZUB0BDT+GsUJ6lKysY+SAjIU5uKdaAzQ7/
         7x+CxASPVSv+tS+A5gr785g2JnbaP81hq3QwGUWYkU870jmmJ3P/ULCeMeabVH0HXuCV
         NNppmBkf3+bTvRulsZoBM5VU19AjeSuxWLQCeDmuf9cmhLoeFOZY1V8begZ+VjTwJnbq
         NOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794318512; x=1794923312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Co4X+lJ4cTnZFILI0kHUCUVHOUrsje27fDkW0QWbJgw=;
        b=1ksRPoKLWhsrIQS5exzUlt3nwE0TiYgooPXcuRKHHL+ycbpPXHojWL1Hcj0/EoBwud
         pmE3bOI6FbV5JdpvU1QlcxmShIBAc4SDKRzwftJabh22xaKjqX42GpKuI7uh2fmDCw6y
         8PM4kyaiLRsvEvuh1MA+ZJcZZZtYsL3xkKHiHecszhjh5SSnHvgH/HNIvyF7Rq31J1VD
         ZuadQbzmVywzZXu58QxiLJOJ64GX19X+35N3l84fXQvwUyjHEiUa5ZZXNSa+IWky2yHE
         tdRciAauJ3wFA3uSx6vw14dm/J+fhRDONCTZC8fc+Yo6z0kAh7vc+iI08rY30MTDB+qc
         8B6Q==
X-Forwarded-Encrypted: i=1; AL+hErH/W+dIIk2tIpeSGOfTP/fryrjvZAFJBvWbvi+i9orGDzj8J7iV8kPmYE63T0xYzMHtbqr2CqXaOJuf+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z813csMIMMuIQH/dRPUn2kTYTYV7wkGHJpvdOp8fDUKsoVEAE3a
	JHDpClsXCkcKfT6eocdXZ41eqdVXUh7nlPjsKIl9JUSqUH0ftvxtkkvb
X-Gm-Gg: AYBFou06QKISufONMp2eKiba4s/yYn1VTJBnD1rnB+0AJvPSOxTxIxkIu+t1y4YcSZO
	8LgBlaNKh19hN19waPac9vHtjuSR0lsYKpoV685PGY2E14t3NNY+kr0VbMbh4QbTVv7u0aue+4I
	O8Yp/9ReJmuuaark1Li1aEUdHC/H5mxClnUCuQnQkv7UHzUDfX/VD20rrLHDO7WqbOw51s6zD1d
	p8iEgnlqWjdWW3u7XgmQsBq1KMktcxiJulbI1Djpgr7Lh7axXZU/eIqya0tcLAwWgv9iVoM8Zfm
	6oi1PP7pk/zQ9sbB+refbGg1m09FjSZnj6senz/3Dkj0ddYDtQJVxbtKOeQAfAEW4Si5GOgiqLp
	nPw9rpj3JQXf7bVCNaHBFY4bEh4H6ZTuEAkO32uM8Yne3jTJ7ZDG9zlUIExMphfxNZtqzG/ry4w
	uTN7hAUNeJ+jkLtJ3Ld6LSF+vpjclIh9yck7RPL6q+J5q4SEx/ZHGE7wdsHWgU1KkzdT2N4Q4yx
	+OLkUQsBZI6Xk+JUIK6Dy8j8yzaH47YbtSIW2ZW6bDC9i/d/cXi45dYH8PkzsmrtO7AfVe5jgpe
	ipKSt29MCjP5PLOioDuLWYQfas8=
X-Received: by 2002:a05:7301:648b:b0:36f:3da8:dbc8 with SMTP id 5a478bee46e88-3751f946c28mr3807038eec.31.1794318511934;
        Tue, 10 Nov 2026 05:48:31 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520608b52sm6663679eec.13.2026.11.10.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:48:31 -0800 (PST)
Date: Tue, 10 Nov 2026 21:48:28 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vishnu Sankar <vishnuocv@gmail.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avMcB0q7wF9oP5X8@sapienza>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>

On Tue, Nov 10, 2026 at 05:26:21AM +0000, Jingle Wu 吳金國 wrote:

Hi Wu,

> Hi Dmitry/Yuan:
>
> We have confirmed that FW A1 was never released by Elan. The Elan Variant ID has always been 3.

Thanks for your information, Let me share more details:

The trackpoint has driver from "ELAN
Microelectronics Corp." in windows 11 on same device.

In Linux I found the device is probed as generic mouse
device but not trackpoint device, it's hard to use due to
no sensitivity setting from sysfs. I found the reported id
0x7 is not in drivers/input/mouse/trackpoint.c's
trackpoint_start_protocol() after debugging, the trackpoint
is probed and works well after add the id 0x7 there.

So I thought this should be a ELAN device w/ ID 0x7 and
cooked this patch.


>
> THANKS
> JINGLE
>
> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Tuesday, November 10, 2026 10:36 AM
> To: Yuan Yao <yaoyuan0329os@gmail.com>; Jingle Wu 吳金國 <jingle.wu@emc.com.tw>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>; Vishnu Sankar <vishnuocv@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Phoenix Huang 黃世鵬 <phoenix@emc.com.tw>; Stanley Chen 陳建維 <stanley.chen@emc.com.tw>
> Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device variant id 7
>
> ⚠ External Email: This email originated from outside the organization. Please use caution when opening links or attachments.
> ⚠ 外部郵件： 此郵件來自公司外部，請謹慎開啟連結或附件。
>
> Hi Yuan,
>
> On Mon, Nov 02, 2026 at 09:08:36PM +0800, Yuan Yao wrote:
> > The new ELAN trackpoint variant id 7 is found on thinkpad
> > X14 Gen1 laptop(Product Name: 21XMA006CD), it's now incorrectly probed
> > as Generic or Logitech PS/2 mouse.
> >
> > Add ELAN variant id 7 to match the TP_READ_ID command return value,
> > probe the device as trackpoint correctly.
> >
> > BEFORE:
> > input: PS/2 Generic Mouse as
> > /devices/platform/i8042/serio1/input/input63
> >
> > AFTER:
> > psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware: 0xa1,
> > buttons: 3/3
> > input: TPPS/2 Elan_variant7 TrackPoint as
> > /devices/platform/i8042/serio1/input/input65
> >
> > Signed-off-by: Yuan Yao <yaoyuan0329os@gmail.com>
> > ---
> >  drivers/input/mouse/trackpoint.c | 2 ++
> > drivers/input/mouse/trackpoint.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/input/mouse/trackpoint.c
> > b/drivers/input/mouse/trackpoint.c
> > index 3bd8fdf56cd3..f46fc1665c96 100644
> > --- a/drivers/input/mouse/trackpoint.c
> > +++ b/drivers/input/mouse/trackpoint.c
> > @@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
> >       [TP_VARIANT_NXP]                = "NXP",
> >       [TP_VARIANT_JYT_SYNAPTICS]      = "JYT_Synaptics",
> >       [TP_VARIANT_SYNAPTICS]          = "Synaptics",
> > +     [TP_VARIANT_ELAN_ID_7]          = "Elan_variant7"
>
> I wonder if we really need to say "Elan_variant7" or if we should simply say "Elan" here as well.
>
> Jingle, is this your part? What is the difference from Elan trackpoint reporting 0x03 as its variant?
>
> Thanks.
>
> --
> Dmitry
