Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486968;
	b=oQwwHmlZJwoK5vwuah4zzZ6laX1KGXov2zByXGEaHax8ph6jB6ZjfTiq83Au6wcxe40M
	 6t3Rihv8BlrDc2ugs3UNDR/ausMAdXQZ6VmKZew1GkYyaPYGSenzEZEZ/zfBUz31HS1rP
	 6xrCRxluihF4rgaTjFX8de4xuRqJYhLICpBR5WsGmAz3piAqLCwhRXahWiz1nJTaqKAG2
	 +icv9RK32ndjcJEBeUtipiisDAdDlNjvPmaxg9JLg+ag4DHdMRTJbCMDPTOvP0cLNN4Jr
	 7x45oPyH5LbNph3KkOHI7vj8vYHJSTvJtQmtujfMGOPyT0Z6H61LCyhGtvTUesUhz6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=hjVW9VP/TER5rvEadBEmYCt8ueid8AgZqnJlLcgyHj8=;
	b=CBl6iCuRVxvck5L13WyZuk4T+r4ZndQXuE7xtcspqelD8PhvmHTBFYm44l2HVjehTvGH
	 luBPe4kYjMBE4jC+zQyAf8c+sBHhrFKIGwqH3O0vdjGjAhANqPtwCQj/WR0l9GGuFVfzt
	 O970Nd8NE3gcM/eouq5aOCta0XZDuv6JBjQEt8z+BbPLpKEdR00rTGGAUIROUSb8qGUjN
	 3wzIpp6SkiQvvvA4fH0JyLbsaIj3ffqT2dXNGtoqxG1pvaOuzUSiUQMmGjlr1nDRVgc08
	 ACAw8thoT243egLOio+QHJlNYAOdKmW72rPzOYDC8Ng7XcR6S2b6PYUhXb3DnZwl/1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EY2seoxg;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5401606A321
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 12:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5401606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EY2seoxg
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f8cdd30beso7909296eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794486967; x=1795091767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hjVW9VP/TER5rvEadBEmYCt8ueid8AgZqnJlLcgyHj8=;
        b=EY2seoxgN/lP5QZxJCB/IQ7UKMLtTYoZG4g7DdWrqL5oZKQMb8OBcQAdISuf117azw
         hUIedT4HiaFrFWVSsyRSd7/zRB8tpPlVVvHo7CpOrqpfGQ06FPuwz3Opuw2jCgVa5BVa
         nmGd1xjy8PgXgJXt6mkfiNDu2r0ViPDjHRtgHRFjHkMJuBn8aJl49JTuvs5wJ6DCYrIb
         82cN6dW1p42Dc3vwGw5x3m3MK2nN0EEyR9lFGoa2VgdbrNKqZcUfY188N05YogGQyZI0
         /v99f1cu1xnZcTF0itKA4/UgbFExnYBzD8mz3gDoGDixuwH6M8sz2nCCM4P3O5JUhP/7
         Sm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486967; x=1795091767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hjVW9VP/TER5rvEadBEmYCt8ueid8AgZqnJlLcgyHj8=;
        b=OJL4ykaobEkjEJjkLXj3MgJJ6aoXXRu/5OMcNBaGTbHYmqLPI1Bu4OcPVgER8unQx2
         5HzmBmiw6kdu9SctObIrsZAYN8hGlu9TKm/gL8oNDaRip8xXgBagke9Gc48VGaWJILe0
         tIxMYEYjeJcKpC5BozdpIjv9pbIrW2b2ELcX5zWeZDIkN3sot/ZXi7131BsRpYKUZtSD
         ei9QaXXE4ls/WCROsOssUC6IQQje8IuInLcwTW/MAFMWeXeJNlDEUK61yTru2j1qRKQ6
         s/rHqBz7IdUaUX9gPYCquvXD53PcayWpKixDdTtotPaMN3gEgQN+At4Ybu1x04n6IUio
         43fA==
X-Forwarded-Encrypted: i=1; AL+hErH3Cznz0j0wTqb+PcRsi0d/VjvxMH6LcA10gCxubdtAI0pqRuS4ZRmrg4rVZwa8LgJQ5UITodb5iekHgg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QRWuCu4T2W1T3f5ZlvREAEWHOd1S17Ek1fFEWN4ngaLZjORYU
	IgbVDzrKmCfiw3NL/ob7pbxLmFaOFaU7wrFUZHweB9Xt2cEQXvGOOEU5
X-Gm-Gg: AYBFou2G4x9RA0qCgNopZJhrFWBRX3O8kbUXaW1JwN2G/Oi0//m0FBiaZg9bCswZENy
	Nz0qdsmtvr9tvD22/Vqho7EPeMktw0ioDooKGrd/XNSXA/Y2CDJLLL57Jo9mhY1BVu1KWFvEgaH
	OdDmcZdE3B7EwFBCl3ZHWBmUf5mzCoXvJqye71QV3XwrzsawnBvFD7D4yibebZrKqCmxHphwk6H
	Y0PbwiOra6O31PoOAUNJR0QQFzveYGx/KKl+4Jo/e58fZCKt8krG/JoLJ93Bht0PF6GdeMcTGS1
	NobwqgyjPtMc2v3nXw6xjy2hWgFO1bbhyHHVrsX39W5v8DUbPEOznbfK6irxhrEPVsYS0PBNI6H
	w6eKxBo09+cYxXQL6GmHyE4e2RQpMwBHT7mxgJFF+DZxLQzKbfm+B7tKb/BoiRveoGWnK3PxTTr
	AnyNs8DNOpb99vuVQ66yqRbjBi0amjY55HfF1pKJk4QlaQzk72Qonmf+zhlvyCpYebjHmA1nUA8
	YoOvKmWr8tCvQxBcas9YFfMf2f933OmkY/0tN/YjJo7YW3yhf89hhNrlV7678KBNTvooyA9gRg5
	uzluWip3h2i95aZsTemQlvFFi6E=
X-Received: by 2002:a05:7300:561c:b0:36e:2626:4ace with SMTP id 5a478bee46e88-3768366a866mr6118746eec.5.1794486966515;
        Thu, 12 Nov 2026 04:36:06 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm28827005eec.17.2026.11.12.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:36:05 -0800 (PST)
Date: Thu, 12 Nov 2026 20:36:01 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vishnu Sankar <vishnuocv@gmail.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avWyftYhIVaPpoln@sapienza>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza>
 <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
 <avRttU9N0EZeq8nY@sapienza>
 <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
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
In-Reply-To: <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>

On Thu, Nov 12, 2026 at 05:26:46AM +0000, Jingle Wu 吳金國 wrote:
> Hi Yao:
>
> Upon inquiry, it was confirmed that a black TrackPoint stick (0x07) underneath the red TrackPoint cap corresponds to a vendor that is compatible with the Windows ELAN driver.

Ah I see, thanks a lot for your help on confirming this!

>
> THANKS
> JINGLE
>
> -----Original Message-----
> From: Yao Yuan <yaoyuan0329os@gmail.com>
> Sent: Wednesday, November 11, 2026 10:05 PM
> To: Jingle Wu 吳金國 <jingle.wu@emc.com.tw>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>; Vishnu Sankar <vishnuocv@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Phoenix Huang 黃世鵬 <phoenix@emc.com.tw>; Stanley Chen 陳建維 <stanley.chen@emc.com.tw>
> Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device variant id 7
>
> ⚠ External Email: This email originated from outside the organization. Please use caution when opening links or attachments.
> ⚠ 外部郵件： 此郵件來自公司外部，請謹慎開啟連結或附件。
>
> On Wed, Nov 11, 2026 at 05:26:36AM +0000, Jingle Wu 吳金國 wrote:
> > Hi Yao:
> >
> > Could you help verify whether the color of the TrackPoint stick underneath the red cap can be used to identify the vendor?
> >
> > White: ELAN
> > Other colors: Other vendors
>
> Hi Wu,
>
> The thin stick under the red cap is black.
>
> Also I visited the lenovo's supporting website, there's only
> 1 ELAN dirver for this thinkpad X14 gen1 model's trackpoint:
>
> https://newthink.lenovo.com.cn/driveList.html?selname=ThinkPad%20X14%20Gen1
>
> The laptop model I'm using is 21XM, the driver works well in windows 11.
>
> Now I'm confused on who is the real vendor of this trackpoint device. I may ask help on Lenovo's supporting website yet. Wu, is that ok to refer this mail there ?
>
> >
> > Thanks
> > JINGLE
> >
> > -----Original Message-----
> > From: Yao Yuan <yaoyuan0329os@gmail.com>
> > Sent: Tuesday, November 10, 2026 9:48 PM
> > To: Jingle Wu 吳金國 <jingle.wu@emc.com.tw>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com>; Vishnu Sankar <vishnuocv@gmail.com>;
> > linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Phoenix
> > Huang 黃世鵬 <phoenix@emc.com.tw>; Stanley Chen 陳建維
> > <stanley.chen@emc.com.tw>
> > Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint
> > device variant id 7
> >
> > ⚠ External Email: This email originated from outside the organization. Please use caution when opening links or attachments.
> > ⚠ 外部郵件： 此郵件來自公司外部，請謹慎開啟連結或附件。
> >
> > On Tue, Nov 10, 2026 at 05:26:21AM +0000, Jingle Wu 吳金國 wrote:
> >
> > Hi Wu,
> >
> > > Hi Dmitry/Yuan:
> > >
> > > We have confirmed that FW A1 was never released by Elan. The Elan Variant ID has always been 3.
> >
> > Thanks for your information, Let me share more details:
> >
> > The trackpoint has driver from "ELAN
> > Microelectronics Corp." in windows 11 on same device.
> >
> > In Linux I found the device is probed as generic mouse device but not
> > trackpoint device, it's hard to use due to no sensitivity setting from
> > sysfs. I found the reported id
> > 0x7 is not in drivers/input/mouse/trackpoint.c's
> > trackpoint_start_protocol() after debugging, the trackpoint is probed and works well after add the id 0x7 there.
> >
> > So I thought this should be a ELAN device w/ ID 0x7 and cooked this patch.
> >
> >
> > >
> > > THANKS
> > > JINGLE
> > >
> > > -----Original Message-----
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Sent: Tuesday, November 10, 2026 10:36 AM
> > > To: Yuan Yao <yaoyuan0329os@gmail.com>; Jingle Wu 吳金國
> > > <jingle.wu@emc.com.tw>
> > > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>; Vishnu Sankar
> > > <vishnuocv@gmail.com>; linux-input@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; Phoenix Huang 黃世鵬
> > > <phoenix@emc.com.tw>; Stanley Chen 陳建維 <stanley.chen@emc.com.tw>
> > > Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint
> > > device variant id 7
> > >
> > > ⚠ External Email: This email originated from outside the organization. Please use caution when opening links or attachments.
> > > ⚠ 外部郵件： 此郵件來自公司外部，請謹慎開啟連結或附件。
> > >
> > > Hi Yuan,
> > >
> > > On Mon, Nov 02, 2026 at 09:08:36PM +0800, Yuan Yao wrote:
> > > > The new ELAN trackpoint variant id 7 is found on thinkpad
> > > > X14 Gen1 laptop(Product Name: 21XMA006CD), it's now incorrectly
> > > > probed as Generic or Logitech PS/2 mouse.
> > > >
> > > > Add ELAN variant id 7 to match the TP_READ_ID command return
> > > > value, probe the device as trackpoint correctly.
> > > >
> > > > BEFORE:
> > > > input: PS/2 Generic Mouse as
> > > > /devices/platform/i8042/serio1/input/input63
> > > >
> > > > AFTER:
> > > > psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware:
> > > > 0xa1,
> > > > buttons: 3/3
> > > > input: TPPS/2 Elan_variant7 TrackPoint as
> > > > /devices/platform/i8042/serio1/input/input65
> > > >
> > > > Signed-off-by: Yuan Yao <yaoyuan0329os@gmail.com>
> > > > ---
> > > >  drivers/input/mouse/trackpoint.c | 2 ++
> > > > drivers/input/mouse/trackpoint.h | 1 +
> > > >  2 files changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/input/mouse/trackpoint.c
> > > > b/drivers/input/mouse/trackpoint.c
> > > > index 3bd8fdf56cd3..f46fc1665c96 100644
> > > > --- a/drivers/input/mouse/trackpoint.c
> > > > +++ b/drivers/input/mouse/trackpoint.c
> > > > @@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
> > > >       [TP_VARIANT_NXP]                = "NXP",
> > > >       [TP_VARIANT_JYT_SYNAPTICS]      = "JYT_Synaptics",
> > > >       [TP_VARIANT_SYNAPTICS]          = "Synaptics",
> > > > +     [TP_VARIANT_ELAN_ID_7]          = "Elan_variant7"
> > >
> > > I wonder if we really need to say "Elan_variant7" or if we should simply say "Elan" here as well.
> > >
> > > Jingle, is this your part? What is the difference from Elan trackpoint reporting 0x03 as its variant?
> > >
> > > Thanks.
> > >
> > > --
> > > Dmitry
