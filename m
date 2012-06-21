From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Thu, 21 Jun 2012 16:53:54 +0200
Message-ID: <4FE33582.7080409@kernelconcepts.de>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be> <20120620184015.GA5390@polaris.bitmath.org> <4FE24024.9010807@kernelconcepts.de> <20120621083940.GA2193@core.coreip.homeip.net> <4FE2EBCC.2020108@kernelconcepts.de> <20120621100420.GA15600@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:37049 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab2FUOyA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 10:54:00 -0400
In-Reply-To: <20120621100420.GA15600@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>, Anatolij Gustshin <agust@denx.de>, Ilya Yanok <yanok@emcraft.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/21/2012 12:04 PM, Dmitry Torokhov wrote:
>> Ok, the bad news is, that it doesn't work with your changes.
>> There was one oops I was able to resolve (i2c_set_clientdata must
>> happen before sysfs_create_group) but the touch also failed to
>> deliver input events and mode switching doesn't work.
> 
> Hmm, OK, let me ponder this one a bit as well.

Ok, found some of the problems. For starters I failed to realize that
you moved the irq initialization to the board file into the i2c-client
structure (which I did not initialize in my board file). This of
course explains why the touch seemed unresponsive...

The problem with mode switching was, that tsdata->factory_mode was
shuffeled around *after* some of the calls to _register_write/read.
This function however changes its way of operation depending on the
mode, you need to send different read/write commands depending on the
mode of the chip. So it is essential to change factory_mode before
invoking these functions.

Hmm, maybe this should be an explicit function parameter.

Then you implemented edt_ft5x06_i2c_attr_is_visible, but I fear this
is not working as you expect it to work. It has an effect on startup
time of the driver, but not when later switching the mode. This had
the effect that raw_data did not appear when switching to factory mode.

I am unsure regarding your changes to the handling of the platform
data. Is it guaranteed that the platform data sticks around for the
life time of the driver? Some of the data in the board file is marked
__initdata, which to my understanding means, that the kernel might
discard it at some point. That is why I copied the values into my
private structure. Is it safe to change that?

For the pin handling: you release the reset-pin after having done the
reset. Is this wise? This enables the user to use e.g. the
gpio-filesystem to reset the touch screen, potentially confusing the
driver and messing up the system.

Bye,
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/jNYIACgkQO2O/RXesiHCwnACeI0k+8AcJXu8Kq9EA71ae6mQp
BcwAn2SM8U3012Z5+W3m8nrj9jI3HZTa
=xjs+
-----END PGP SIGNATURE-----
