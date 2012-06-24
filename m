From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Sun, 24 Jun 2012 14:31:16 +0200
Message-ID: <4FE70894.6080908@kernelconcepts.de>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de> <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:32978 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2FXMb0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jun 2012 08:31:26 -0400
In-Reply-To: <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/23/2012 01:48 AM, simon.budig@kernelconcepts.de wrote:
> This is a new iteration of the driver for the edt ft5x06 based 
> polytouch series of touchscreens. It contains most of the changes
> from Dmitry. I did not incorporate the attribute is_visible-stuff,
> since it did not work as expected for me. Also I do not release the
> reset pin.

I should add that this version might need a change in the registration
process in the board file, since it now uses the irq field of the i2c
entry instead of determining it from the irq-pin platform data.

So if your platform doesn't automatically configure the gpio pin when
requesting a gpio based IRQ you need to specify both for the driver to
configure it:

For my i.mx28 based board it looks like this:

static struct edt_ft5x06_platform_data edt_ft5x06_pdata = {
        .irq_pin = MXS_GPIO_NR(2, 5),
        .reset_pin = MXS_GPIO_NR(2, 6),
};

static struct i2c_board_info tx28_stk5v3_i2c_boardinfo[] __initdata = {
[...]
        {
                I2C_BOARD_INFO("edt-ft5x06", 0x38),
                .platform_data  = &edt_ft5x06_pdata,
                .irq = MXS_GPIO_IRQ_START + MXS_GPIO_NR(2, 5),
        },
};

I hope this helps.
         Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/nCJMACgkQO2O/RXesiHCvagCfSDx8+N3GSAVGTLhcHEcyIApB
X9wAn06iumsteC859PoDKcmyleopyJgZ
=RzlR
-----END PGP SIGNATURE-----
