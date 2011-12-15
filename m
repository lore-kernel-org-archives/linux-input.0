From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 15 Dec 2011 14:41:59 +0100
Message-ID: <4EE9F927.7070609@kernelconcepts.de>
References: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de> <1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de> <20111202145146.33d5b8be@wker> <4EE9D333.8050107@kernelconcepts.de> <20111215131727.83266xhan7tbcl8g@webmail.mnet-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:46270 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab1LONmG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 08:42:06 -0500
In-Reply-To: <20111215131727.83266xhan7tbcl8g@webmail.mnet-online.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: agust@denx.de
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ilya Yanok <yanok@emcraft.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/15/2011 01:17 PM, agust@denx.de wrote:
> My understanding is that CodingStyle insists on tabs for
> indentation and tabs are always 8 characters wide. Additional
> indentation for alignment of function arguments is done by
> spaces, i.e.:
> 
> <tab>function(arg1,
> <tab><tab>    arg2);

Hrm, in my perception arg2 should be on the same indentation level as
function(, since it is within the same block.

Anyway, I'll ignore the whitespace complaints of checkpatch.pl for now.
I am then down to three warnings about >80 character lines, which are
not easy to fix.

However, when trying my patch against the latest mainline it complains
about an implicit declaration of function irq_to_gpio().

I understand that irq_to_gpio() is a potentially nasty thing to do and
that there has been some cleanup. But I am unsure how to fix this:

Currently I use the .irq field of the i2c_board_info struct to define
the irq to respond to. I expect this to be a gpio irq and hence use
irq_to_gpio to configure the resp. gpio as input.

If I am not supposed to use irq_to_gpio, then how do I solve this?

* expect the board file to set up the resp. GPIO direction?

or

* use an entry in my platform data (next to the reset pin) for the gpio
number and then try to map this to an irq number?

or did I miss the best solution?

Thanks,
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7p+SYACgkQO2O/RXesiHB0FwCdEyxPVx+yQx8lVmP7cXdWwk14
KhwAn2uR935Ev8Ej1Q2GdEcV95RwA+lc
=GsVE
-----END PGP SIGNATURE-----
