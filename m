From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: WM9712 GPIO
Date: Wed, 12 May 2010 14:50:44 +0200
Message-ID: <AANLkTimGhfLPxAIhtTYoUO-te1mUs86LEVEcYN7DgOtY@mail.gmail.com>
References: <AANLkTikXR3vlUg-XX33LCrAiVxk0nJWNe__7SU7g1DuF@mail.gmail.com>
	 <20100512123026.GA8082@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43926 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0ELMuq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 08:50:46 -0400
Received: by fxm15 with SMTP id 15so8204fxm.19
        for <linux-input@vger.kernel.org>; Wed, 12 May 2010 05:50:45 -0700 (PDT)
In-Reply-To: <20100512123026.GA8082@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Wed, May 12, 2010 at 2:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 12, 2010 at 01:47:12PM +0200, Manuel Lauss wrote:
>
>> I'm playing with the GPIO interface on a WM9712G, specifically GPIO1
>> and 2 of the chip.
>> However I'm unable to get the chip to toggle any of these pins.
>
>> Setting a pin with
>> wm97xx_set_gpio(wm, WM97XX_GPIO_1, WM97XX_GPIO_HIGH);
>
>> reads back 0x0820 from GPIO status reg, sets bit 1,writes back 0x104=
4 (<<1),
>> but a read following immediately after yields 0x0820 again, and the =
pin
>> never changes.
>
>> Am I missing something?
>
> The WM9712 does not support this feature. =A0It only supports setting=
 the
> GPIO status by use of AC'97 slot 12 for which there's currently no
> standard glue on Linux. =A0Setting slot 12 needs to be done in the AC=
'97
> controller.

Wonderful.  Thanks for the info.


      Manuel Lauss
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
