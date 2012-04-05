From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 05 Apr 2012 12:27:53 +0200
Message-ID: <4F7D73A9.1050407@kernelconcepts.de>
References: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de> <1333564079-23893-1-git-send-email-simon.budig@kernelconcepts.de> <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de> <20120404191043.GA11042@core.coreip.homeip.net> <4F7CB48E.9060305@kernelconcepts.de> <20120404210940.GB11042@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:49233 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2DEK17 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Apr 2012 06:27:59 -0400
In-Reply-To: <20120404210940.GB11042@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Sorry if the quoting level is messed up in this mail, apparently
thunderbird thinks that it is a good idea to exchange the quoting levels
of the last two replies. I tried fixing it manually...]

Hi Dmitry.

On 04/04/2012 11:09 PM, Dmitry Torokhov wrote:
> > > The mt pointer emulation should do this for you.
> >
> > Can you point me to some documentation on that? Do I need to enable this?
>
> Just do
> 
> 	input_mt_report_pointer_emulation(tsdata->input, true);

That only seems to work when using slots (which I don't do yet and while
I am willing to change it I can't do it right now since other software
depends on the type-a protocol...).

> > Where would be a proper place to document such device-specific behaviour?
> Maybe Documentation/input/...? Thisis hardware-mandated behavior, right?

Yeah, I guess I'll cook up a small document.

> > > Should this GPIO configuration be done by the driver or by the board
> > > code that configures i2c client? I think latter is better.
> > I got conflicting opinions when I asked for advice on this last december
> > (before changing it to a pin-based configuration). Why do you think that
> > your suggestion is better?
> 
> Can the device be connected via a pin not plugged into gpio subsystem?
> Other than deriving IRQ from it you do not seem to be using it.

Well, I do configure the pin as input as well.

Which would then probably have to move to the board file, where there is
no real good place to put it. Or you invent some sort of callback
functions in the platform device structure so that the driver calls back
into the boardfile.

I dunno. Seems like a lot of overhead for very rare/obscure usecases.

I'll prepare a new version of the patch incorporating the other feedback
from you. Hopefully I'll manage to do this in the next few days.

Bye,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk99c6kACgkQO2O/RXesiHBszwCgsiQBnnOC6qeK379gSeLTUHz+
QWEAoKcVK1kKaE0Uq3KiPmaf7dGozzPA
=W+St
-----END PGP SIGNATURE-----
