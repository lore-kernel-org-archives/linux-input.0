From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH v4] Touchscreen driver for FT5x06 based EDT displays
Date: Wed, 07 Mar 2012 11:42:39 +0100
Message-ID: <4F573B9F.2080107@kernelconcepts.de>
References: <1326413588-30517-1-git-send-email-simon.budig@kernelconcepts.de> <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de> <1331050527-4902-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:59375 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab2CGLCd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 06:02:33 -0500
In-Reply-To: <1331050527-4902-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, agust@denx.de, yanok@emcraft.com, b.van.den.berg.nl@gmail.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/06/2012 05:15 PM, simon.budig@kernelconcepts.de wrote:
> +config TOUCHSCREEN_EDT_FT5X06
> +	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
> +	help

Bas pointed out to me that an explicit dependency on the I2C subsystem
is missing. I have that in my local tree now, but I won't resend the
patch for this trivial matter unless specifically asked for it  :)

Bye,
         Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XO58ACgkQO2O/RXesiHBhKQCgodgnqp2hI3zSSwvUygAvvqin
yHIAniDocinerPbp1aMH9O9QvOWtRB2e
=AeV2
-----END PGP SIGNATURE-----
