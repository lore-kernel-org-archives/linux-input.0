From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] Input: Fix edt-ft5x06 build error seen if CONFIG_DEBUG_FS
 is not defined
Date: Tue, 07 Aug 2012 12:01:15 +0200
Message-ID: <5020E76B.7070801@kernelconcepts.de>
References: <1344308525-11262-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:58098 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab2HGKBU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Aug 2012 06:01:20 -0400
In-Reply-To: <1344308525-11262-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/07/2012 05:02 AM, Guenter Roeck wrote:
> Fix:
> 
> edt-ft5x06.c: In function edt_ft5x06_ts_remove: 
> edt-ft5x06.c:846:14: error: struct edt_ft5x06_ts_data has no member
> named raw_buffer

Oops sorry, forgot to test compiling the driver without DEBUGFS. The
change looks correct to me.

Bye,
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAg52sACgkQO2O/RXesiHC79gCfUyq8IGeS2rau3myvrtU6Bo4O
hiIAniXUa0AIzWJSvJ0gsQMgNA+1hnwd
=JBXZ
-----END PGP SIGNATURE-----
