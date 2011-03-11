From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 2/2] hid-ntrig: calibration
Date: Fri, 11 Mar 2011 02:48:13 -0500
Message-ID: <4D79D3BD.9000204@seas.upenn.edu>
References: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu> <1299829072-19489-2-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:50856 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab1CKHs3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 02:48:29 -0500
In-Reply-To: <1299829072-19489-2-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, micki@n-trig.com
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On a related note, I looked into switching to usbhid_submit_report for firmware
version polling but it looks like the report offset (or something like that) is
wrong.

I get:
af082500

usbmon shows the devices sends:
0c002508 afe10000

If I change the report offset in the field to 8, I get the desired bits:
e1af0825


I don't really know much about parsing the hid descriptors, so I don't know why
its off by a byte.  Perhaps its worth testing a different firmware to see if
this is specific to my current firmware.

Rafi

On 03/11/11 02:37, Rafi Rubin wrote:
> Adding a function to tell the device to run its calibration routine.
> A number written to the sysfs specifies the duration of the calibration
> in milliseconds
> 
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
> 
> The output needs to stay disconnected for the duration for this to work,
> otherwise I would have just used submit_report.  Please check to see
> that I handled that correctly, I can say it works for me.
> 
> Is there a style problem with having wait and sleep in a sysfs call like
> this?
> 
> Micki: would you care to comment on this?  The windows driver seems to
> send extra messages to the device, but in testing they don't seem to
> have an effect.  If they do matter, it would be no trouble to put them
> back in.  Also can you comment on the difference between "trouble
> shooting" and the calibration that your windows tool offers?  As far as
> I can tell the actions look very similar.  Is it just a matter of
> interpretting the feedback?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNedO2AAoJEPILXytRLnK2bysP/R3GJGkXrq8EH2qxBmcBXaxy
xD8VRCfN17kPTNf2FQj5A/dpG4NPscwG8wOMxPLa69gal5trJQnm6ekJvinajt1Y
aDEFm/6TripZLRJC8xEWnFN5VK7HOmiXe5CiEJhmfg+KFEjitNekMleNC/9wQEbN
XSH/8NwdU8f82HRgKBL0odpy8Qzjtdg4uRHuNmA9Ec9lp9G8wcYoKGXrDNBMmyf6
lgaaptqw+Tiv2Ad9VOjf9hBQS1Mq7EQ5oKbC2RJeDLRmyJ+nZ1AtZ0rIIYa7/nHC
k78rhUS5+m2WW+1r6ahbyTZWOtNZaZNUyKgG03MXwRcx6GLOu+5WZGuew+Dg/qA4
ws8ZMIbca1sZHa+pwRi/m5hPuU3dSB3J7U/SwSbD5+EGcV2OjN8/w1QbPsnMW9xp
kmt2HjkNh4wMzO7s4vyXOQ1QbQRvBP32NMqbsmW1TjNmYXiC9PgsfsxdKhVox9rQ
ZY8CioS2+zDrL5nmTaVbUnziIEwP1/j2z4rrIE9R7lsnrJDW+aQ0NqxWce/9FJRn
qoRIvYFEHXq6GA1lbUMhgk5dy3NIUHl1dSYEWw5Tcd/YrYfcTQdix8me490OkEds
AD0db+27ifK/xBy8J0LnPYlQLpqgtKHjGcNP/Px2XJTJl8r2+0B8J/hWf9cNQZ8L
Q3ev12Gp5psWNwftUzQe
=X3PD
-----END PGP SIGNATURE-----
