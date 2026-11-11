Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405904;
	b=W0pqkyCLqSh05AQcaE3a0oV8RZdXaCs6Z/0E7GZ9+GXFhp3wcqcTMBuaY5bAI2tBt6nm
	 YyVym9Hw3YSW80ZPkplFvzQn9iKOFHHIOKPCRiXXUVtYLOHh4jyi34/0Qi38KBRFfR3lC
	 2WDWDY5cXLc2ZR4+PR9ua9YIusBeul8jL98kWJZqoWzIjuwSOWxetr9z2a5mfuL0VAXfB
	 lOvCWXIDFabXJbVrwVGEMJYD1kHYkg/SvbIUXOJUa0CBMNWZqrtIvw+vLyZSjONd/0wBf
	 5kWGlogGZ1uZ6HC9uYDn/wi1B/+iaNkUbFVGvCBzaUmgbBRY0t6gXOeerdfxTl1s6WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=/2TL98f8PghA+Pe3iD4T1awywNMH5AS+0iuSUCcKU2I=;
	b=cMiAR6rc0whHiQPCRrwJEo7YDznyya58dcPm7q/TgzDDXFsiQmumVHsDU7yUi7hI4CMF
	 dF086YoCarXCkP0SNhpOJ+dpd804it4QudoPQVeeaC3choMDfebie2iaHqxeSLPwmF0yj
	 5aQvJ4c66fCRJUiB6eP+m+ftkxJ8pEuEIdKGxBkX4ulG2uFKEbxqi9H5zM7v03tq1ogOK
	 v/uYUgKDUfyVKLfuo9TEpp6rpX4czHp2al3yQQtc4q6ot3FWahBnIQKxbYDrIE76jsU8R
	 sHOoCliE3FvKlihgvy6e9D7iW/yhzu5Mf7xMIWBIAT+T8LaZ/Hgouee/oH776Rjq6rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lkXjTjV3;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF710606A324
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 14:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF710606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lkXjTjV3
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so3319991eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794405903; x=1795010703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2TL98f8PghA+Pe3iD4T1awywNMH5AS+0iuSUCcKU2I=;
        b=lkXjTjV3UgTWiWpT2DEeM3Kq4oY1qH5YYmhP9vK9ercB+vkMouyO/ic7yPk8cP83kC
         aCL1yLtyK0YpmTSRKjq419TvpeLpdGWfuc66X2vU9yLwTStpMqEukhtz0Df8m3VKcYQr
         QsL8JFU/BGYdcuIg7Qg3zJeGj3CTxP4RZwbx3nGC/leGgceB6oVPATWHfnrdZYavApYD
         4SFfBY8pLElH7ymNDIPgkHCfJ6L/6QIemD/ziYi0X+rzaedYDTItDgwnEJ+GVKyyKq4S
         F4m/GxE7lRHM6ZbE6R+Hlj601Gc3xNyeyEZC2tkeCk8Eo/CXf3aoxwNxykOERdH71v2s
         XBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794405903; x=1795010703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/2TL98f8PghA+Pe3iD4T1awywNMH5AS+0iuSUCcKU2I=;
        b=jpHSP/GssKPM6SJzwHSuHiP9baKUpx7VUVWk/l9O/i6dpvTpJOXX+F9vl8uDZUsRI0
         DzxVUeEmtZq+VoCmq27hDYXUVZfcLPwofYcf8a+Mpz/+lFXnCCvcGxbQP2bwShydRUsu
         45zWJIxKdxFIG+lc7U5scHeazQCRuBOby5aOVKGZZD3aR/n7tazgvIhzDtOCVPajUFOe
         UcXfx8I1UetKyh6hUUEITLV6TqHXYa1RREZxE+LFFOA42lMf6tn2npVCL2UOU8MoeZRz
         TX9/XprBY0qNBehquOnQfl7aXHCUJvl/icY/s0JHjjBdGfoRW+pM2JVDzwwQ97EG4dDU
         hXng==
X-Forwarded-Encrypted: i=1; AL+hErHgUXgbmLSHB1zhhpGvgYOsasZAYFb6exp7TNgOPP12cL1tQUmbn/n/N2HcHlCA5tRTwh9Z8wdusLGapw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fmk1SLJr4acEI4yDUFTVdFcicKOyL37I98vf2cWS4c0h4q8Um
	e7TeBlvqHWpUtpUyqIs4nn28+Z0dD6v8dWqAcZdjH0qsGp/PxENAbnSW
X-Gm-Gg: AYBFou3jioRBi7BN4/Od4njRpPtKbs/pjwI0wL2pD8CCcQz//bWKvbEXOuqqspOY2vI
	eNVUlcQsw5eGXsGy8duZHeqq/N/QDSDIo4YO550eb/Cg15LuRF7vc4WHPtU8cOpzB2txOTr720R
	ly/CG1ZPiq4j6gkiRZ6WQa6vFAsSvkaKyWOFKA2Bx8i7Plgk47GlxAbQBXLrXOXbS85jPHHhf8z
	AGE8XLR5KmMKii6tmH6f/4/XfXUTTKYp/t/+7SMbbHYfhrgS2C1pHSpPHd4l2Ger+gSON1dgbBT
	RD/rG3Cfftp2FF0BAztx7T5ow+8M8FMlRAK7ua7+GKPZ99atIQS/Q/uCbX5oseYGNfTA0bJ2ak/
	wCc8ETZHvifn64G88SVSftmMCy2Sexq8CvQ3WNSpDwge8hYe+5zQbO1gF83RlWYqpOEdBDGi5ZR
	g/xnEUNoPqYTxeleKz6an9r7LvVVk0uAU26wBM2YAC1WlYe3RZZnBWObTEQHJDM9iXIs01k6S8q
	rEmeat2vjEmjRCkMoFcZNe/Led6BtJQnpgT0ScFkRbaTIYYvJ8F0lALJrzPPOJiplh1AIXWljPD
	UaEI5w8urao/rVblLFMscjv33ok=
X-Received: by 2002:a05:7300:f28a:b0:36e:a11a:b2f1 with SMTP id 5a478bee46e88-37686464a66mr3277755eec.30.1794405902642;
        Wed, 11 Nov 2026 06:05:02 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520608b52sm14716222eec.13.2026.11.11.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:05:00 -0800 (PST)
Date: Wed, 11 Nov 2026 22:04:57 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vishnu Sankar <vishnuocv@gmail.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avRttU9N0EZeq8nY@sapienza>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza>
 <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
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
In-Reply-To: <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>

On Wed, Nov 11, 2026 at 05:26:36AM +0000, Jingle Wu 吳金國 wrote:
> Hi Yao:
>
> Could you help verify whether the color of the TrackPoint stick underneath the red cap can be used to identify the vendor?
>
> White: ELAN
> Other colors: Other vendors

Hi Wu,

The thin stick under the red cap is black.

Also I visited the lenovo's supporting website, there's only
1 ELAN dirver for this thinkpad X14 gen1 model's trackpoint:

https://newthink.lenovo.com.cn/driveList.html?selname=ThinkPad%20X14%20Gen1

The laptop model I'm using is 21XM, the driver works well in
windows 11.

Now I'm confused on who is the real vendor of this
trackpoint device. I may ask help on Lenovo's supporting
website yet. Wu, is that ok to refer this mail there ?

>
> Thanks
> JINGLE
>
> -----Original Message-----
> From: Yao Yuan <yaoyuan0329os@gmail.com>
> Sent: Tuesday, November 10, 2026 9:48 PM
> To: Jingle Wu 吳金國 <jingle.wu@emc.com.tw>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>; Vishnu Sankar <vishnuocv@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Phoenix Huang 黃世鵬 <phoenix@emc.com.tw>; Stanley Chen 陳建維 <stanley.chen@emc.com.tw>
> Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device variant id 7
>
> ⚠ External Email: This email originated from outside the organization. Please use caution when opening links or attachments.
> ⚠ 外部郵件： 此郵件來自公司外部，請謹慎開啟連結或附件。
>
> On Tue, Nov 10, 2026 at 05:26:21AM +0000, Jingle Wu 吳金國 wrote:
>
> Hi Wu,
>
> > Hi Dmitry/Yuan:
> >
> > We have confirmed that FW A1 was never released by Elan. The Elan Variant ID has always been 3.
>
> Thanks for your information, Let me share more details:
>
> The trackpoint has driver from "ELAN
> Microelectronics Corp." in windows 11 on same device.
>
> In Linux I found the device is probed as generic mouse device but not trackpoint device, it's hard to use due to no sensitivity setting from sysfs. I found the reported id
> 0x7 is not in drivers/input/mouse/trackpoint.c's
> trackpoint_start_protocol() after debugging, the trackpoint is probed and works well after add the id 0x7 there.
>
> So I thought this should be a ELAN device w/ ID 0x7 and cooked this patch.
>
>
> >
> > THANKS
> > JINGLE
> >
> > -----Original Message-----
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Sent: Tuesday, November 10, 2026 10:36 AM
> > To: Yuan Yao <yaoyuan0329os@gmail.com>; Jingle Wu 吳金國
> > <jingle.wu@emc.com.tw>
> > Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>; Vishnu Sankar
> > <vishnuocv@gmail.com>; linux-input@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Phoenix Huang 黃世鵬 <phoenix@emc.com.tw>;
> > Stanley Chen 陳建維 <stanley.chen@emc.com.tw>
> > Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint
> > device variant id 7
> >
> > ⚠ External Email: This email originated from outside the organization. Please use caution when opening links or attachments.
> > ⚠ 外部郵件： 此郵件來自公司外部，請謹慎開啟連結或附件。
> >
> > Hi Yuan,
> >
> > On Mon, Nov 02, 2026 at 09:08:36PM +0800, Yuan Yao wrote:
> > > The new ELAN trackpoint variant id 7 is found on thinkpad
> > > X14 Gen1 laptop(Product Name: 21XMA006CD), it's now incorrectly
> > > probed as Generic or Logitech PS/2 mouse.
> > >
> > > Add ELAN variant id 7 to match the TP_READ_ID command return value,
> > > probe the device as trackpoint correctly.
> > >
> > > BEFORE:
> > > input: PS/2 Generic Mouse as
> > > /devices/platform/i8042/serio1/input/input63
> > >
> > > AFTER:
> > > psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware: 0xa1,
> > > buttons: 3/3
> > > input: TPPS/2 Elan_variant7 TrackPoint as
> > > /devices/platform/i8042/serio1/input/input65
> > >
> > > Signed-off-by: Yuan Yao <yaoyuan0329os@gmail.com>
> > > ---
> > >  drivers/input/mouse/trackpoint.c | 2 ++
> > > drivers/input/mouse/trackpoint.h | 1 +
> > >  2 files changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/input/mouse/trackpoint.c
> > > b/drivers/input/mouse/trackpoint.c
> > > index 3bd8fdf56cd3..f46fc1665c96 100644
> > > --- a/drivers/input/mouse/trackpoint.c
> > > +++ b/drivers/input/mouse/trackpoint.c
> > > @@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
> > >       [TP_VARIANT_NXP]                = "NXP",
> > >       [TP_VARIANT_JYT_SYNAPTICS]      = "JYT_Synaptics",
> > >       [TP_VARIANT_SYNAPTICS]          = "Synaptics",
> > > +     [TP_VARIANT_ELAN_ID_7]          = "Elan_variant7"
> >
> > I wonder if we really need to say "Elan_variant7" or if we should simply say "Elan" here as well.
> >
> > Jingle, is this your part? What is the difference from Elan trackpoint reporting 0x03 as its variant?
> >
> > Thanks.
> >
> > --
> > Dmitry
