From: Kevin Wells <wellsk40@gmail.com>
Subject: Re: [PATCH] input/touch: Introduce the LPC32xx touchscreen controller
 driver (v2)
Date: Tue, 17 Aug 2010 17:34:44 -0700
Message-ID: <AANLkTi=P-y_xB6RSYN7Oyeb2paSLAFc=Nxu19bWHxE53@mail.gmail.com>
References: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
	<1281993661-21097-2-git-send-email-wellsk40@gmail.com>
	<4C69B708.3020008@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61804 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab0HRAeq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 20:34:46 -0400
Received: by wwi17 with SMTP id 17so1874621wwi.1
        for <linux-input@vger.kernel.org>; Tue, 17 Aug 2010 17:34:45 -0700 (PDT)
In-Reply-To: <4C69B708.3020008@bluewatersys.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: linux-input@vger.kernel.org, Durgesh Pattamatta <durgesh.pattamatta@nxp.com>, linux-arm-kernel@lists.infradead.org

Hi Ryan,

Thanks for taking the time to review this.

>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Set sample rate to about 240Hz per X/Y pair. A single=
 measurement
>> + =A0 =A0 =A0* consists of 4 pairs which gives about a 60Hz sample r=
ate based on
>> + =A0 =A0 =A0* a stable 32768Hz clock source. Values are in clocks.
>> + =A0 =A0 =A0* Rate is (32768 / (RTR + XCONV + RTR + YCONV + DXP + T=
TR + UTR) / 4
>> + =A0 =A0 =A0*/
>
> Is the clock source internal, or at least always 32.768kHz? If not,
> should the timing be controlled via some platform data so that this
> driver is compatible with other board setups?
>

The clock source for this is internal and locked in the driver and cloc=
k control
handler at 32768Hz.

As much as I want to argue not using platform data :), I can't think of=
 one good
reason not to use it for this (the keyscanner driver has it). I
probably should of
used it from the start.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
