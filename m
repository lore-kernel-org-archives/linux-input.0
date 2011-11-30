From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Wed, 30 Nov 2011 10:34:54 +0100
Message-ID: <4ED5F8BE.90100@kernelconcepts.de>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:33991 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1K3KOv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Nov 2011 05:14:51 -0500
In-Reply-To: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Anatolij Gustshin <agust@denx.de>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all.

On 11/09/2011 12:34 AM, Ilya Yanok wrote:
> Driver for touchscreen controllers found on EDT Displays. Originally
> developed by Anatolij Gustshin.

Sorry for not noticing earlier, but I'd like to point out that there
already is a patch for this family of touch controllers, which also
already provides support for setting parameters and reading raw data
from the sensor.

You can find its most current instance in my mail from September 29th
with the subject "[PATCH v2] Touchscreen driver for FT5x06 based EDT
displays"

Thanks,
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7V+L4ACgkQO2O/RXesiHDVBQCgkRFIGTq4d6EuxCti+qz992cg
a3cAoMNY7hOFQqx8IJnDuLOrn/QJnQhZ
=HLEn
-----END PGP SIGNATURE-----
