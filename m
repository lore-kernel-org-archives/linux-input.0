From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] mouse: Add new i2c-based input mouse driver into input
 subsystem for Cypress i2c trackpad devices.
Date: Fri, 4 Mar 2011 01:04:51 -0800
Message-ID: <20110304090450.GB4323@core.coreip.homeip.net>
References: <B27AC323FA92C946BA36D2913DDC8E3701FD6F0B1A3B@VMBX126.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f51.google.com ([74.125.83.51]:63122 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab1CDJE6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2011 04:04:58 -0500
Content-Disposition: inline
In-Reply-To: <B27AC323FA92C946BA36D2913DDC8E3701FD6F0B1A3B@VMBX126.ihostexchange.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: "rubini@ipvvis.unipv.it" <rubini@ipvvis.unipv.it>, "olofj@google.com" <olofj@google.com>, "micahc@google.com" <micahc@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dudley,

On Fri, Mar 04, 2011 at 03:48:21AM -0500, Dudley Du wrote:
> Hi Linux-Input Maintainers,
> 
> This patch adds new i2c-based input mouse driver into input subsystem for
> Cypress i2c trackpad devices. Through this new added driver,
> Cypress i2c trackpad devices will be supported in Linux based system
> which are developed based on Cypress self-designed PSOC chipset.
> The function of this driver reads trackpad data using i2c interfaces
> and report cursor moving data and gesture combined keys to input subsystem.
> 
> This driver adds one driver main file cypress.c in drivers/input/mouse directory,
> and one header file cyapa.h in include/linux directory,
> and modified Kconfig and Makefile files in drivers/input/mouse directory to include this driver.
> 
> Attached is the patch file for this driver and bellow is the content of this driver.
> 

Could you please try describing capabilities of your device. From the
glancing at it it looks like it supports some form of multi-touch...

>From the very rough code scanning there appears to be huge amount of
code that reinterprets data coming from the device and converts it into
gestures (virtual keyboard, virtual wheel hanlding, etc, etc). Such
processing does not belong to the kernel driver but rather to userspace.
Please take a look and other touchpad drivers in the kernel (synaptics,
alps, elantech, bcm, and so for) and how they are work in tandem with
synaptics X driver which provides advanced gesture handling.

I also question why one would give choise between using relative and
absolute reporting when absolute mode provides more data for gesture
processing. Also polling mode is probably unsuitable for production
driver and so I'd recommend dropping it for the mainline submission.

Thanks.

-- 
Dmitry
