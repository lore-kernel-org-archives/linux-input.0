From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: Patch to add guarding parentheses to some macros in linux/input.h
Date: Tue, 07 Jun 2011 12:51:12 +0200
Message-ID: <4DEE02A0.7030702@kernelconcepts.de>
References: <4DE6AD3B.4000600@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:47814 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1FGKvP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2011 06:51:15 -0400
In-Reply-To: <4DE6AD3B.4000600@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/01/2011 11:20 PM, Simon Budig wrote:
> The attached patch adds parentheses to ensure correct operator precedence.

Seems this patch did not draw any attention to it. Is this because it is
somewhat pointless? Or is it too uncontroversial?  :-)

I'd appreciate any hints on how to proceed from here.

Thanks,
        Simon

- -- 
       Simon Budig                        kernel concepts GbR
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk3uAqAACgkQO2O/RXesiHD8bwCfZz10ADGqx0yUbPJCSlmvNthL
JZsAn2Mc+gj1UQ5nSAWGonf46s6Xg/Uq
=Ug6H
-----END PGP SIGNATURE-----
