From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [RFC] HID and multitouch
Date: Tue, 15 Dec 2009 10:16:11 -0500
Message-ID: <4B27A83B.5000709@seas.upenn.edu>
References: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr> <alpine.LNX.2.00.0912151500160.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:46473 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbZLOPQ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 10:16:29 -0500
In-Reply-To: <alpine.LNX.2.00.0912151500160.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> - furthermore, some fingers have to be discarded because they are 
>> placeholders with no valid data, and we know if to dump them only when 
>> they have been fully parsed. Therefore, we need a mechanism to cache 
>> finger data until the decision is made. Currently, the caching mechanism 
>> has to be device-dependent because the fields are not exactly the same 
>> and they come in a device-dependent order.
> 
> What kind of caching is required here? Is there any upper bound 
> approximation on the amount of data that need to be cached?
> 
> Would simple infrastructure, introducing linked list of [usage, value] 
> tuples, together with "flush()" method, that will again only call 
> hidinput_hid_event multiple times, be enough to be common for all drivers 
> needing this?

I can only answer for the ntrig.  To get a correct output of active fingers, we'd have to cache a total of twice the maximum number
of fingers.  The first copy is for the previous state and the second is for the current to check if id's have shifted.

On the upshot, all fingers seem to be transmitted on every input event.  So we don't have to stall input events for longer than the
io and processing time to perform such a correction.


My impression is that most or all of the other devices perform finger tracking in which case they need to buffer at most just the
maximum number of fingers, though if using dynamic structures, might be able to shrink that to the current max contact id (max id of
active inputs).  It sounds like the devices are sending full data, when they just want to transmit a sparse array.


I'm not sure there's a significant benefit to a dynamic data structure for holding the incoming points.  I don't think any of these
devices are capable of reporting more than 5 or 10 points.  With the current firmware, the ntrig only reports 4+pen, though it
reports them as 6 points (id 4 is always transmitted and always 0, and 5 is the pen).  Anyway, we're talking small arrays with just
a little state in each cell.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAksnqDkACgkQwuRiAT9o60/zCwCfY/eoK2Ys7tBFDg0ITUuJ12WS
iE8AoNhBd+7jeXDK5ViKasbL9icdMcTh
=1Tdr
-----END PGP SIGNATURE-----
