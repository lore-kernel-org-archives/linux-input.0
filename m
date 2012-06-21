From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Thu, 21 Jun 2012 11:39:24 +0200
Message-ID: <4FE2EBCC.2020108@kernelconcepts.de>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be> <20120620184015.GA5390@polaris.bitmath.org> <4FE24024.9010807@kernelconcepts.de> <20120621083940.GA2193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:40487 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab2FUJj3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 05:39:29 -0400
In-Reply-To: <20120621083940.GA2193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>, Anatolij Gustshin <agust@denx.de>, Ilya Yanok <yanok@emcraft.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/21/2012 10:39 AM, Dmitry Torokhov wrote:
>> Anyway. I have reviewed the changes Dmitry suggested and will
>> test them on real hardware tomorrow.

Ok, the bad news is, that it doesn't work with your changes. There was
one oops I was able to resolve (i2c_set_clientdata must happen before
sysfs_create_group) but the touch also failed to deliver input events
and mode switching doesn't work.

I'll try to incorporate your patch incrementally, but this might have
to wait for the weekend.

> That would be great as I already reviewed your version. If there
> is something missing from your version that is present in Olivier,
> I woudl prefer getting an incremental patch.

One thing Olivier did which is not in my patch is, that he used the
type B protocol while I am still on type A. This is something I could
change.

Bye,
        Simon

- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/i68wACgkQO2O/RXesiHA/hwCfQEZDL+KukaCsKpMMRdpuPfo2
FQQAnRqAtrPoAmLDeQ5bonidXMSlrtMk
=DPlX
-----END PGP SIGNATURE-----
