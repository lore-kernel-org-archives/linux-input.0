From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Sat, 5 Jan 2019 22:51:47 +0000
Message-ID: <20190105225147.le5fgpnvq7sctxe5@penguin>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Gonzalez <alex.gonzalez@digi.com>
Cc: hadess@hadess.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Alex,

On Fri, Jan 04, 2019 at 05:00:48PM +0100, Alex Gonzalez wrote:
> The Goodix touch controller allows the use of two optional GPIOs (RESET
> and INT) to reset the touch controller, select the I2C address of the
> device and exit the device from sleep mode.
> 
> The current implementation requires both GPIOs to be provided, however,
> it is possible to provide only the INT line and not to have the RESET line
> available but pulled-up.
> 
> Designs that only provide the INT line are able to operate the touch on
> the default I2C address but will not be able to reset the touch via
> software or place the device in sleep mode.

I do not have a datasheet for the device, so I am not sure if reset line
is actually needed to put the device into sleep mode. As far as I can
see from the code we suspend it by pulsing INT line and then sending a
command to the controller, and resuming by pulsing the INT line again.
So it sounds to me INT only designs _could_ place device in sleep mode.

As far as the patch goes, if you do not need to execute reset or put
device into low power mode, you do not need to specify any of the GPIOs
as GPIO resources. Simply specify the INT GPIO as your interrupt source
(GpioInt() in ACPI world or "interrupts = <&gpio NNN
IRQF_TRIGGER_WHATEVER>" in DT world and be done with it.

Thanks.

-- 
Dmitry
