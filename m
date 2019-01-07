From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Mon, 07 Jan 2019 16:56:37 +0100
Message-ID: <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
         <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
         <20190105225147.le5fgpnvq7sctxe5@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105225147.le5fgpnvq7sctxe5@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alex Gonzalez <alex.gonzalez@digi.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2019-01-05 at 22:51 +0000, Dmitry Torokhov wrote:
> Hi Alex,
> 
> On Fri, Jan 04, 2019 at 05:00:48PM +0100, Alex Gonzalez wrote:
> > The Goodix touch controller allows the use of two optional GPIOs
> > (RESET
> > and INT) to reset the touch controller, select the I2C address of
> > the
> > device and exit the device from sleep mode.
> > 
> > The current implementation requires both GPIOs to be provided,
> > however,
> > it is possible to provide only the INT line and not to have the
> > RESET line
> > available but pulled-up.
> > 
> > Designs that only provide the INT line are able to operate the
> > touch on
> > the default I2C address but will not be able to reset the touch via
> > software or place the device in sleep mode.
> 
> I do not have a datasheet for the device, so I am not sure if reset
> line

Data sheets for a lot of the Goodix devices were shared a couple of
years ago on this list. You'll find the one for the GT911 in here:
https://drive.google.com/drive/folders/0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg?usp=sharing

You can probably translate it using Google Translate's Documents
upload, but I haven't had much luck at all...

> is actually needed to put the device into sleep mode. As far as I can
> see from the code we suspend it by pulsing INT line and then sending
> a
> command to the controller, and resuming by pulsing the INT line
> again.
> So it sounds to me INT only designs _could_ place device in sleep
> mode.
> 
> As far as the patch goes, if you do not need to execute reset or put
> device into low power mode, you do not need to specify any of the
> GPIOs
> as GPIO resources. Simply specify the INT GPIO as your interrupt
> source
> (GpioInt() in ACPI world or "interrupts = <&gpio NNN
> IRQF_TRIGGER_WHATEVER>" in DT world and be done with it.

Given that we do have access to the datasheet, it would also be useful
for the patch to mention where in the datasheet it says that the reset
line can be left pulled-up, or mention on which shipping device this
setup is already used (and if so, what the DTS or ACPI snippet that
declares those is).

Cheers
