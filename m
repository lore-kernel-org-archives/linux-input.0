From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: your mail
Date: Thu, 15 Apr 2010 19:41:22 -0400
Message-ID: <4BC7A422.7050601@seas.upenn.edu>
References: <20100414125234.23507.42816.stgit@localhost.localdomain> <20100414231604.GA12281@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:56120 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0DOXls (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Apr 2010 19:41:48 -0400
In-Reply-To: <20100414231604.GA12281@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-i2c@vger.kernel.org, khali@linux-fr.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> +	if (ts->tc.event_sended == false) {
> 
> We set "event_sended" to false immediately before calling
> cy8ctmg110_send_event() so I do not see the point of this flag.

On that note:

$ git grep -n sended
drivers/net/eth16i.c:1295:
		how many packets there is to be sended */
drivers/net/wan/sbni.c:638:
		/* if frame was sended but not ACK'ed - resend it */
drivers/net/wan/sbni.c:659:
		* frame sended then in prepare_to_send next frame
drivers/usb/serial/aircable.c:13:
		* next two bytes must say how much data will be sended.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkvHpB4ACgkQwuRiAT9o609wAgCfbGjTP2lIN6JJyX28VzjPHxTY
ylIAn15FZRPpBEkWaFR8oAFKCCRmNF4d
=u4nx
-----END PGP SIGNATURE-----
