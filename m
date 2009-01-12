From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: Touchpad on Dell Latitude XT (alps 73 00 14)
Date: Mon, 12 Jan 2009 03:43:12 -0500
Message-ID: <496B02A0.3010703@seas.upenn.edu>
References: <4967E317.6040407@seas.upenn.edu> <20090111235407.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:50218 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbZALInO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 03:43:14 -0500
In-Reply-To: <20090111235407.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> Hi Rafi,
> 
> On Fri, Jan 09, 2009 at 06:51:51PM -0500, Rafi Rubin wrote:
>> My touchpad has the id 73,00,14 which I added to alps.c as
>> { { 0x73, 0x00, 0x14 }, 0xf8, 0xf8, 0 }
>>
>> How can I determine what values to use for those last three fields?
>>
> 
> f your touchpad works (you don't see any messages from psmouse in dmesg
> and every button works fine) then these are correct values.
> 

Its not working quite right.  When I add the device and give it the "ALPS_DUALPOINT" flag (or 0), I get all the touchpad events working properly (through the synaptics driver in X).  But the stick is
sending weird coordinates through the mouse driver and extraneous clicks through the synaptics driver.

The ALPS_PASS flag just seems to send all the touchpad events to the mouse, and looses all stick events.

I'm not getting psmouse messages from the kernel when its in use.  But then again, I'm not really using it all that much.  The load time tests report:

alps.c: E6 report: 00 00 64
alps.c: E7 report: 73 00 14
alps.c: Status: 73 00 14



On a side note, seems to me the E6 test should print in decimal, or the comment saying the third value should be 10 or 100 should be changed to hex values.


Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklrAqAACgkQwuRiAT9o6097XwCfa1nuSUXpIgdEsok7odNo+mp3
Z34An3cYWehx9KV0wx4WdYjanZQEgmoq
=ia7Z
-----END PGP SIGNATURE-----
