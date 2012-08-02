From: Till Crueger <T.Crueger@fh-trier.de>
Subject: Using an eGalax touchpad on ARM
Date: Thu, 02 Aug 2012 13:52:30 +0200
Message-ID: <501A69FE.2050104@fh-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway-0.fh-trier.de ([143.93.54.122]:43879 "EHLO
	gateway-0.fh-trier.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab2HBMDe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Aug 2012 08:03:34 -0400
Received: from gateway-b.fh-trier.de (gateway-b.fh-trier.de [143.93.54.182])
	by gateway-0.fh-trier.de (Postfix) with ESMTP id 142C31C3E8
	for <linux-input@vger.kernel.org>; Thu,  2 Aug 2012 13:56:48 +0200 (CEST)
Received: from [143.93.53.29] (infpc06.fh-trier.de [143.93.53.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: crueger)
	by gateway-b.fh-trier.de (Postfix) with ESMTPSA id DCA4B17B46F
	for <linux-input@vger.kernel.org>; Thu,  2 Aug 2012 13:56:32 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I am currently trying to get an D-Wav/eGalax touchpad to work under
linux on an ARM board (pandaboard). I can use the touchpad just fine
from most laptops running gentoo or ubuntu.

To get the device to work I followed the guide I found at
https://wiki.archlinux.org/index.php/Multitouch_Displays. This means I
load the hid-multitouch driver and then issue

# echo 3 0eef 72f0 259 >
/sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id

which activates the device on my laptop running gentoo.

The same procedure on the pandaboard does not activate the touchpad
however. I can see the touchpad just fine using lsusb, but somehow the
activation fails.

What could be the cause for the activation failure under a different
architecture?


One possible reason why this may not work, that I am currently
considering is the BUS-Number. When I first tried to activate the device
on the laptop I assumed this number was refering to the USB-Bus to which
the device was connected. However after re-reading the guide for
arch-linux, I figured out that this number is 3 for any USB-device.
However I could not figure out what this magic number is referring to.
Is it possible, that this number is different on the pandaboard? If so,
how could I find out the correct number to use for activation of the device?


If you need any additional information (output from dmesg, lsusb etc)
just let me know and I'll get the necessary information from the board.

Thank you for your help,

  Till Crueger

- -- 
Dipl. Inform. Till Crueger

Department of Computer Science
Trier University of Applied Sciences
Postfach 1826
54208 Trier
GERMANY
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJQGmn+AAoJEMyqYnfSqLbVYMIIAI+GUSJI29e87OtWITCewebc
aE4STPUcl9StOREOGtMoOoLmG2n6YDOt1xNi6ynUih/H5MdHRPz4d7VNWaTdC5rs
hVp8gQ5c2DGvHTNVb88ezoDb2FudsxBDEpXoQU+TXgN0ke6PpVfvtwPsarvBFHv5
lvxLXTi0o3mHSWw/XTZw90UP7O49l1pCjISfvQdkRCcVrySEDNJAQFkJQAeARzim
cBqvjHBscUZJO/5ddE1v1QWY3QEPuMiXLptL0sKAMDK6X/R29XtAVVzX5z0W7E6f
Kj5u8qqvEvvHaMyMC2p+Tp/zlmnKVvQCKs1COlwcBRLvy3BTnUc9pzGP3wb4K2w=
=Ar2y
-----END PGP SIGNATURE-----
