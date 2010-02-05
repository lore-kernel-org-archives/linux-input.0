From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Thu, 04 Feb 2010 23:16:11 -0500
Message-ID: <4B6B9B8B.4080707@seas.upenn.edu>
References: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:60248 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0BEEQW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Feb 2010 23:16:22 -0500
In-Reply-To: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, evilynux@gmail.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've tested this two machines with different firmwares and it seems to work well.  I would certainly like to get some more testing
feedback.

I have a few questions about the right way to do things.

First, this patch breaks the older wacom userspace driver.  I don't know how many people use that instead of evdev (I found the
wacom driver considerably nicer).  An update to the latest driver does work and I've already posted a patch for the current HEAD.
How bad is that?

Also, the dev node that had worked well when the streams were multiplexed does not work as well with the split devices and one must
now use the eventXX nodes.  Is that a reasonable change to thrust on users?  In adding names to the input devs I suppose it would be
possible to have udev map the devices for easier configuration, but I haven't investigated yet.


As seemed to be the consensus a while back, the touch sensor emits both classical touchscreen events and mt events.  Also both
sensors emit multiple styles of buttons (BTN_0 + BTN_TOUCH).  evdev and wacom seem to catch different buttons to accomplish the same
actions, and so far I have not seen a downside to sending both.


What's the proper way to handle mt groups?  Should all fingers be represented in events from each group?  Should it just send up to
the max id, injecting ghost points for non-present fingers?  Or should only live fingers show up?


I also have played with in kernel suppression for a machine which seems to seems to send off events sporadically.  Is that something
that should be left entirely to userspace?  Certainly I think it should be configurable if added to the kernel.


And one final note, there are a couple corner cases I left in.  I need to do a bit more testing, I think those might not be
necessary with the 0xff0002 handling.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktrm4gACgkQwuRiAT9o60/m+ACgyL2lVrlEZpOHTWIWkC4ra6l1
RrQAoMtoL1Li5nk0fNYTKyYxMljhJ3Ha
=n2B2
-----END PGP SIGNATURE-----
