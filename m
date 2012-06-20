From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH] input: edt-ft5x06 - Touchscreen driver for FT5x06 based
 EDT displays
Date: Wed, 20 Jun 2012 23:27:00 +0200
Message-ID: <4FE24024.9010807@kernelconcepts.de>
References: <1339671707-24662-1-git-send-email-olivier@sobrie.be> <20120620184015.GA5390@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:44225 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122Ab2FTV1I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jun 2012 17:27:08 -0400
In-Reply-To: <20120620184015.GA5390@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Olivier Sobrie <olivier@sobrie.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jan Paesmans <jan.paesmans@gmail.com>, Anatolij Gustshin <agust@denx.de>, Ilya Yanok <yanok@emcraft.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Henrik

On 06/20/2012 08:40 PM, Henrik Rydberg wrote:
>> +/* + * Part of this code is inspired from a first version of a 
>> driver for + * this chip sent by Simon Budig to the linux-input 
>> mailing list + */
> 
> Replacing the above with the standard GPL header with both of your
>  names ought to resolve any eventual issues, no?

Not sure. Olivier looked at an ancient version of my code, missing
multiple review spins and tests I did in the meantime with Dmitry and
Anatolij.

I obviously would prefer to see my driver in the kernel. Of course I
am open to improvement suggestions, but I am not really enthusiastic
about reviewing a driver that basically ditches most of my work.

>> +ft5x06_setting(threshold, W_REGISTER_THRESHOLD, 20, 80); 
>> +ft5x06_setting(gain, W_REGISTER_GAIN, 0, 31); 
>> +ft5x06_setting(offset, W_REGISTER_OFFSET, 0, 31);
> 
> Question: will the driver work without fiddling with these 
> settings? If so, are they really necessary? Maybe some part could 
> be moved to debugfs instead?

Well, these are there in my driver as well (plus the "report rate"
setting of the sensor).

There are some parameters (gain/threshold/offset) which need tweaking
depending on the panel glass thickness and other device-specific
things. At least in the development phase it is necessary to tweak
with these to figure out good settings.

Dunno if sysfs is the best place for this, but I suspect that this is
a parameter that needs to be available at runtime as well, moving it
e.g. to platform data might not cut it.

Anyway. I have reviewed the changes Dmitry suggested and will test
them on real hardware tomorrow.

Bye,
        Simon
- -- 
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/iQCQACgkQO2O/RXesiHCmyACeN4cFK2KEkPT83TqrO7f00YBZ
Vl4AoIBuoHqw6AZzoi24dGT0uepi+7Vx
=D8UO
-----END PGP SIGNATURE-----
