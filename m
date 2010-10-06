From: Rabin Vincent <rabin@rab.in>
Subject: Re: Driver for TC35894XBG keypad controller
Date: Wed, 6 Oct 2010 21:39:17 +0530
Message-ID: <20101006160917.GA4318@debian>
References: <20101005161838.16209.16231.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40726 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443Ab0JFQJj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 12:09:39 -0400
Content-Disposition: inline
In-Reply-To: <20101005161838.16209.16231.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, sundar.iyer@stericsson.com

On Tue, Oct 05, 2010 at 04:19:18PM -0000, Alan Cox wrote:
> +config KEYBOARD_TC35894XBG
> +	tristate "TC35894XBG I2C keypad support"

This looks one of the TC3589x family of I/O expanders.  For the TC35892,
there's already a minimal MFD core in driver/mfd/tc35892.c, and a driver
for the GPIO block based on that in drivers/gpio/tc35892-gpio.c.

Comparing the registers map in this patch with the TC35892 datasheet,
the parts look very similar, so would it be possible for you to make
this driver use the TC35892 MFD core, so that multiple blocks can used
simultaneously?

There's no keypad driver for the series in mainline yet, but Sundar was
readying one for the TC35893; I'll let him comment on how similar the
keypad parts look, and what it would take to support the TC35894XBG and
TC35893 keypads in one driver.

Rabin
