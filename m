From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] input: wrong irq requested in edt-ft5x06.c
Date: Thu, 20 Sep 2012 10:31:16 +0200
Message-ID: <505AD454.7060200@kernelconcepts.de>
References: <1348066434-2168-1-git-send-email-sbabic@denx.de> <20120919165815.GB16286@core.coreip.homeip.net> <505AD145.8050204@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:36693 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab2ITIbW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Sep 2012 04:31:22 -0400
In-Reply-To: <505AD145.8050204@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefano Babic <sbabic@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/20/2012 10:18 AM, Stefano Babic wrote:
> But they contain the same information, as the irq number can be get
> easy from irq_pin with gpio_to_irq(). Having both, it is possible
> to set them to different values, and this is wrong.

gpio_to_irq is not available on all platforms. There was a discussion
on that topic quite a while ago. Moving the irq setup code to the
board file was the conclusion from that discussion.

Bye,
         Simon


- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBa1FQACgkQO2O/RXesiHDBOACfamvKFxTYUR9TdVSLhTobthoG
KKwAniPJtTiufxLrATH+n8DwlzuPsok0
=QqF7
-----END PGP SIGNATURE-----
