From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v8] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 19 Jul 2012 15:56:09 +0200
Message-ID: <500811F9.3020104@kernelconcepts.de>
References: <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de> <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de> <1341763522-14374-2-git-send-email-simon.budig@kernelconcepts.de> <20120709080640.GA4137@polaris.bitmath.org> <20120719041656.GA3300@core.coreip.homeip.net> <20120719135001.GA644@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:42958 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSN4O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jul 2012 09:56:14 -0400
In-Reply-To: <20120719135001.GA644@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/19/2012 03:50 PM, Henrik Rydberg wrote:
> Looking good, just a question for Simon: In the mt report
> function, the loop uses every fourth byte of rdbuf, but the access
> looks a bit funny; buf[5], buf[6] etc. It is fine as long as it
> works, just checking. :-)

I'll have a look at the weekend. Sorry for being unresponsive at the
moment, there is an important deadline at work tomorrow...

Bye,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAIEfkACgkQO2O/RXesiHBIXQCfV8WVJxJ8EPdkxVMkwCKksKXi
UjMAn0DdXE1XeDDjeEcUoP3jxuKpQh1T
=ASLY
-----END PGP SIGNATURE-----
