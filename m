From: Michael Poole <mdpoole@troilus.org>
Subject: [PATCH 0/1] hid-magicmouse: Emulate horizontal scrolling.
Date: Mon, 08 Mar 2010 19:55:36 -0500
Message-ID: <8763562u0n.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33320 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756248Ab0CIAzp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 19:55:45 -0500
Received: by mail-qy0-f189.google.com with SMTP id 27so1914755qyk.3
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 16:55:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <tissoire@tls.cena.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

This patch is separate from the changes about input device registration,
except for having some context lines in common with Benjamin's patch.  I
found a use case for horizontal scrolling while moving left to right in
an OpenOffice.org spreadsheet, and this gesture seems basic enough to
merit inclusion in the kernel.

Some areas that may deserve revision or more attention before commit:

1) It might make sense to separately commit the parameter for the
acceleration profile.  I didn't do that because they touch the same code
and exporting the module parameter is so few lines.

2) The acceleration profile is faster than the original, which was not
as responsive as my mice with physical scroll wheels.  However, the
horizontal scrolling may be a little too sensitive: I have to be
somewhat careful to only drag vertically, or else it will generate
horizontal scroll events.  This would be fixable using a different
scroll_accel_profile-like array for each direction.  Other potential
solutions (such as heuristics to guess the direction of the swipe)
seemed better left to user space.

3) The initial calculation of num_scroll_accel_profile is not pretty.
It seemed marginally better to calculate it at module load time than
hard-code the default value, but that's debatable.  I don't see a
reasonable way to calculate the default value at compile time.

Michael Poole
