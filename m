From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Add device tree support for RMI4
 I2C devices
Date: Tue, 11 Aug 2015 13:36:12 -0700
Message-ID: <20150811203612.GA11541@dtor-ws>
References: <1438994270-29809-1-git-send-email-aduggan@synaptics.com>
 <20150809074038.GB32984@dtor-ws>
 <55CA48A2.9050409@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34293 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbbHKUgQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 16:36:16 -0400
Content-Disposition: inline
In-Reply-To: <55CA48A2.9050409@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Tue, Aug 11, 2015 at 12:10:26PM -0700, Andrew Duggan wrote:
> Hi Dmitry,
> 
> On 08/09/2015 12:40 AM, Dmitry Torokhov wrote:
> >Hi Andrew,
> >
> >On Fri, Aug 07, 2015 at 05:37:49PM -0700, Andrew Duggan wrote:
> >>+Optional Properties:
> >>+- syna,sensor-name: The string containing the name of the sensor.
> >>+- syna,attn-gpio: The GPIO number used to assert attention.
> >>+- syna,attn-polarity: The polarity of the attention GPIO.
> >>+- syna,level-triggered: Set to 1 if attention GPIO is level triggered, 0 if
> >>+			edge triggered.
> >We already have generic bindings for i2c devices interrupt line, along
> >with trigger type. We also have standard bindings for gpios, with the
> >polarity. Interrupts are also parsed by the I2C core. There is no need
> >to invent your own bindings.
> 
> In the current implementation rmi_driver expects an attention GPIO
> from the platform data and manages it internally. I just added those
> parameters to device tree. But, that essentially duplicates the
> generic I2C and device tree interrupt handling. I agree that
> rmi_driver should just use the irq provided in the I2C client and
> then we don't have to duplicate the GPIO handling and we can use the
> generic bindings.
> 
> One option is to check to see if there is an irq in the I2C client
> and skip the GPIO initialization if there is. I can provide a patch
> which does that and a v2 of this patch to use the generic bindings.
> But, this also brings up the question on whether or not we should
> still have the code for handling the GPIO in rmi_driver at all. The
> last time the GPIO code was discussed, Chris said it allowed for
> releasing the irq for certain diagnostic modes. But, there are cases
> when rmi_driver won't have access to the GPIO or when the device is
> directly connected to the IO_APIC (ie HID or SMBus devices) so the
> diagnostic mode won't be available for those devices. Also, I'm also
> not convinced that the diagnostic capabilities justify duplicating
> the GPIO handling. If most platforms are using device tree at this
> point I think it might be time to remove the GPIO code from
> rmi_driver and let the lower levels handle interrupts. Or, if there
> are major objections I can work around it and leave it as an option
> in the platform data for devices which still use board files.
> 
> http://marc.info/?l=linux-input&m=139155532321252&w=2

I am always happy with making things simpler so you would not hear me
objecting to dropping gpio handling and relying on interrupts set up for
I2C or SPI client.

That said if you absolutely want to also support GPIO you can make it
optional and alter the behavior depending whether the platform presents
you with GPIO or not. In any case we also have standard GPIO bindings
that allow setting the polarity, etc. Just use gpiod API and it should
work for devicetree, acpi and can be even plugged into static board
code.

Thanks.

-- 
Dmitry
