From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] Input: TPS6507X - define MFD dependencies for touch and
 regulator unit
Date: Tue, 12 Jul 2011 10:23:24 +0200
Message-ID: <4E1C047C.2080508@visionsystems.de>
References: <4E1AD56B.6080306@visionsystems.de> <20110711122004.GA9478@sirena.org.uk> <20110711164124.GB1648@core.coreip.homeip.net> <20110711223312.GA32033@opensource.wolfsonmicro.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:35830 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab1GLIXd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2011 04:23:33 -0400
In-Reply-To: <20110711223312.GA32033@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Am 12.07.2011 00:33, schrieb Mark Brown:
> On Mon, Jul 11, 2011 at 09:41:24AM -0700, Dmitry Torokhov wrote:
>> On Mon, Jul 11, 2011 at 01:20:04PM +0100, Mark Brown wrote:
>>> This isn't a good fix, the driver should depend on the MFD core not
>>> select it.
>> The problem with such dependencies is that user has to first enable MFD
>> core and then hunt through all other menus in search of the function
>> drivers for that chip...
>> Depending on what other things TPS6507X depends on it might be good idea
>> to go ahead and select it.
> If this is an issue it's going to be much more useful to have the boards
> select their MFD cores than have random function drivers do that, in
> most situations it's not actually going to be useful to select the core
> driver as the core driver itself needs something to select either the
> I2C or SPI bus interface for the device in order to actually communicate
> with it.
>
> Remember that this is for embedded systems where the user will normally
> have a pretty good idea what's on their system, someone will have had to
> explicitly plumb the device into the board anyway.

The reason for the patch was following. I have a custom board, that is very close to some other board except of this PMIC (TPS650732). So I copied the platform code from the second board, but  not the configuration. Then I activated the touchscreen driver and wondered, why on earth i2c driver doesn't see this device? At last I found out, that this driver depends on MFD driver and so I made this patch to avoid this situation in the future.

Yegor
