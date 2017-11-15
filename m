From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: edt-ft5x06 question
Date: Wed, 15 Nov 2017 09:50:25 +0100
Message-ID: <a34db111-db8f-1757-95be-fc24e46577d2@lucaceresoli.net>
References: <9036109f-ae02-01de-77a7-13442e3d9e53@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:54133 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbdKOJ0m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Nov 2017 04:26:42 -0500
In-Reply-To: <9036109f-ae02-01de-77a7-13442e3d9e53@micronovasrl.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@bitmath.org, linux@roeck-us.net, stefan.schoefegger@ginzinger.com, simon.budig@kernelconcepts.de, martink@posteo.de, a.mathur@samsung.com

Hi Giulio,

On 14/11/2017 22:42, Giulio Benetti wrote:
> Hello everybody,
> 
> I'm using ft5206 with edt-ft5x06.c driver,
> but what I see is that registers with M09 or M06
> seem different from focaltech ft5206
> https://www.buydisplay.com/download/ic/FT5206.pdf
> 
> For example, except address 0x80 for threshold register(thgroup),
> all the others don't appear:
> GAIN 0x30 or 0x92 should be 0x82(thcal maybe?)
> 
> Can someone clarify this?

Are you having any problems, or just investigating?

> Maybe M06 or M09 are a custom firmware for focaltech ft5x,
> then it has different registers?

All the FT5x06 are 8051-based chips designed to implement touchscreen
controllers. The FT5x26 are similar but with a more powerful core
(Cortex-M IIRC).

As far as I could understand and guess, their register interface is
fully implemented in firmware, so it could change completely from one
panel to another. However all panels that I have seen seem to use
firmwares with either the "M06" or the "M09" protocol, which are
implemented in the Linux driver.

The driver also performs some checks to understand which of the two
protocols is implemented by the controller. These checks are quite
horrible, but they worked for me.

The best thing is that you ask a datasheet to your supplier, in order to
make sure about the protocol and avoid guessing.

Regards,
-- 
Luca
