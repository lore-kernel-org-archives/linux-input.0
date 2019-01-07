From: "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Mon, 7 Jan 2019 10:13:56 +0000
Message-ID: <20190107101355.GA3117@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105225147.le5fgpnvq7sctxe5@penguin>
Content-Language: en-US
Content-ID: <2644DA3EE3E44B41AB3E287569C08B39@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "hadess@hadess.net" <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for your quick reply.

>
>I do not have a datasheet for the device, so I am not sure if reset line
>is actually needed to put the device into sleep mode. As far as I can
>see from the code we suspend it by pulsing INT line and then sending a
>command to the controller, and resuming by pulsing the INT line again.
>So it sounds to me INT only designs _could_ place device in sleep mode.
>

The way I read the gt911 dataheet I also understand that only the INT line is
required to enter sleep mode but I don't other for the other supported 
controllers.  My comment is based on both the suspend() and resume() functions 
returning in the absence of either gpiod_int or gpiod_rst and not progressing 
to the sleep sequence.

>As far as the patch goes, if you do not need to execute reset or put
>device into low power mode, you do not need to specify any of the GPIOs
>as GPIO resources. Simply specify the INT GPIO as your interrupt source
>(GpioInt() in ACPI world or "interrupts = <&gpio NNN
>IRQF_TRIGGER_WHATEVER>" in DT world and be done with it.
>

That was my first impression too. However this does not work for my device. My
hypothesis is that the touch controller I2C address setting sequence is not 
happening as it should, so I need at least the control of the INT line in 
order to fix the I2C address.

I am unsure though whether this is a problem specific to the design I am 
testing with or all designs will have problems setting the I2C address without 
controlling the INT GPIO line.

Regards,
Alex


>Thanks.
>
>--
>Dmitry
