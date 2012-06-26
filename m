From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Tue, 26 Jun 2012 11:06:33 +0200
Message-ID: <4FE97B99.9050506@kernelconcepts.de>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de> <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de> <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de> <20120625085113.GA648@polaris.bitmath.org> <20120626020600.GD24705@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:36039 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab2FZJGj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 05:06:39 -0400
In-Reply-To: <20120626020600.GD24705@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/26/2012 04:06 AM, Dmitry Torokhov wrote:
> Firstly the question to Simon - what was the intent of providing
> access to raw data? Was it mainly for debugging or was it truly
> additional interface?
> 
> If it is debug-only then debugfs is a very good idea.

The main purpose for the raw data originally was to be able to
implement a demonstrator where the distributor representative can
explain some of the operating principles to their customers.

The problem however is, that in raw mode no real processing inside the
chip happens and the effect of gain/threshold/offset is not visible.
In fact the raw data looks so misleading, that I implemented some
averaging and simple touch detection in the demonstrator so that it
can actually fulfil its purpose...

So yeah, the raw data is not as useful as one might hope and I am
perfectly fine with moving it (together with the "mode" parameter) to
the debugfs.

I think adding gain/offset/threshold to the platform data makes a lot
of sense, since different defaults for devices with a 4mm glass plate
in front of the sensor are necessary and can be done in the board
file. However, I think it has to be possible to change them at
runtime, and I don't think that is a debug only thing. Hence I'd
prefer to have them somewhere else than in debugfs.

Regarding the missing CRC check, rate limiting and input_mt_init_slots
error checking I'll have a stab at it and post a new version. Most
likely won't happen before the weekend though.

Thanks,
         Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/pe5kACgkQO2O/RXesiHBD7wCgiO1QlLZH04wnQAx2Su4bAbc2
aIIAoMW6FBPOfe/WfGBzK1VdQ9sAJ4GF
=n3yj
-----END PGP SIGNATURE-----
