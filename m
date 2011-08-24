From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: Question: I2C touchscreen controller
Date: Wed, 24 Aug 2011 15:19:26 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F388575A7F@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F001F3885759E3@AUSP01VMBX24.collaborationhost.net>
 <20110824195436.GA13228@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:29600 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1HXUTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 16:19:37 -0400
In-Reply-To: <20110824195436.GA13228@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wednesday, August 24, 2011 12:55 PM, Dmitry Torokhov wrote:
> Hi Hartley,

Hello!

> On Wed, Aug 24, 2011 at 01:23:59PM -0500, H Hartley Sweeten wrote:
>> Hello all,
>> 
>> I have a question...
>> 
>> Are there any I2C touchscreen controllers that do not need irq support?
>> 
>> I have a system with an I2C bus available to connect to the touchscreen
>> controller but I don't have an IRQ pin available.  Right now I'm just
>> trying to discover if there is a possible solution or if I will need to
>> modify my board somehow to get an IRQ.
>
> Without IRQ you are limited to polling mode which, for touchscreens,
> needs to be done at fairly high rate to provide adequate responsiveness.
> This, in turn, will put considerable load on the system thus driving up
> power requirements... IOW not very suitable for production use, that is
> why I've been asking people to submit IRQ-driven drivers, if at all
> possible.
>
> If polling is your only option then input-polldev is your friend.

Hmmm... Kind of what I figured.

After looking a bit deeper it appears I do have and IRQ pin available.  It's
just a bit of a pain to get to... ;-)

It looks like these are the current I2C touchscreen drivers in mainline:

CONFIG_TOUCHSCREEN_88PM860X		pmic mfd device? probably not standalone
CONFIG_TOUCHSCREEN_AD7879_I2C		datasheet looks simple enough
CONFIG_TOUCHSCREEN_ATMEL_MXT		needs firmware? probably complicated
CONFIG_TOUCHSCREEN_BU21013		can't find a datasheet
CONFIG_TOUCHSCREEN_CY8CTMG110		looks like the chip may be obsolete
CONFIG_TOUCHSCREEN_MAX11801		Maxim usually has long lead times
CONFIG_TOUCHSCREEN_MCS5000		can't find a datasheet
CONFIG_TOUCHSCREEN_STMPE		datasheet looks simple enough
CONFIG_TOUCHSCREEN_TSC2007		datasheet looks simple enough

Based on that I'm considering the Analog Devices, STMicro, and TI parts.

Do you know if any of these work better than the others?

Thanks for the reply,
Hartley