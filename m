From: Mike Murphy <mamurph@cs.clemson.edu>
Subject: PATCH [UPDATED] [0/3] input: xpad.c - Xbox 360 wireless and sysfs
	support
Date: Tue, 3 Mar 2009 22:55:26 -0500
Message-ID: <5aa163d00903031955m42fc3583s3fc784dc3a8a1725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:62261 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZCDDz3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 22:55:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@linux-foundation.org>

Greetings,

The following patchset is an update to my prior submission, which
addresses the code division, typecasting, and internal function
non-use issues present in the previous version of the patch. This
patch has not been changed since last night in the prior thread...
testing this evening confirmed that it is working correctly for the
Xbox 360 wireless hardware. Thanks to Andrew Morton, Greg K-H, and
Linus Torvalds for their help.

--- Original Description ---

This patchset improves the in-kernel xpad.c driver by improving
support for the Xbox 360 wireless controllers, and by adding a number
of features that can be controlled via a new sysfs interface. Rumble
is now enabled on the wireless 360 controllers, and the LED display is
set properly instead of flashing constantly. New features include
implementation of a dead zone for the analog sticks, ability to map
the stick inputs onto a square axis, ability to turn rumble off on a
per-controller basis, and a mechanism for identifying the controller
type and (presumably) unique ID of wireless controllers. In addition,
and as a change to the most recent development patch, I have adjusted
the triggers so that they both implement half-axes instead of full
axes. In other words, they report a range from 0 to +32767, instead of
-32767 to +32767. This change improves behavior on some gaming
emulators, and it can be turned off via the sysfs interface.

In addition to the core patch, I have updated
Documentation/input/xpad.txt, and I have added
Documentation/ABI/testing/game_device-sysfs-interface to document the
added sysfs interface. I'd like to thank Oliver Neukum, Greg
Kroah-Hartman, and Frederic Weisbecker for their helpful feedback
during the development process.

Mike
-- 
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
