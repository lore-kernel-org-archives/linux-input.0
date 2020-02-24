Return-Path: <SRS0=3kir=4M=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB2C11D2F
	for <linux-input@archiver.kernel.org>; Mon, 24 Feb 2020 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA2E2072D
	for <linux-input@archiver.kernel.org>; Mon, 24 Feb 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Cwmjtlev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBXOOk (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:14:40 -0500
Received: from vps.xff.cz ([195.181.215.36]:57708 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbgBXOOk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Feb 2020 09:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582553677; bh=4qDdtHK5hpCLQh/4Uxuvof/n91iXc4o9/kYFieclHC8=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=CwmjtlevBGOGFS8tVAlWHK3CGBEAbWk3XpVkFnTMNxRatJOHfMJRhY/V+cJaC9zkG
         kFFMrySU1yL2EhmJVrqKIs2OUozxpQaH0D0Mi30i/jvrY2o06kF1QS38dP51YcxIo+
         9SvdGqY+Z+0RUU6DBQ99AxkJxqCUok4wPDxeL7oc=
Date:   Mon, 24 Feb 2020 15:14:37 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Tomas Novotny <tomas@novotny.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ARM: dts: sun8i-a83t-tbs-a711: Add support for the
 vibrator motor
Message-ID: <20200224141437.opcsfhozfppulu4g@core.my.home>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200222231428.233621-1-megous@megous.com>
 <20200222231428.233621-4-megous@megous.com>
 <20200224091059.lljffogofbexhudt@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224091059.lljffogofbexhudt@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello,

On Mon, Feb 24, 2020 at 10:10:59AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Feb 23, 2020 at 12:14:27AM +0100, Ondrej Jirman wrote:
> > The board has a vibrator mottor. Hook it to the input subsystem.
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > index 2fd31a0a0b344..a22920275e99b 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> > @@ -99,6 +99,11 @@ panel_input: endpoint {
> >  		};
> >  	};
> >
> > +	vibrator {
> > +		compatible = "gpio-vibrator";
> > +		vcc-supply = <&reg_ldo_io1>;
> > +	};
> > +
> 
> LDO IO1 can also be muxed in as a GPIO iirc, why did you choose the
> regulator instead?

According to the specification, LDO needs to be enabled (value 0b11)
to achieve the specified max driving current of 150mA:

  https://megous.com/dl/tmp/92b7d9d94820c3ba.png

Otherwise the chip is probably just using the regular CMOS logic output
(typically limited to around 20-35mA, but not specified in this datasheet),
which would be probably overdriven, if we try to drive the motor with it.

And since we're driving a motor directly, the more the better.

thank you and regards,
	o.

> Maxime


