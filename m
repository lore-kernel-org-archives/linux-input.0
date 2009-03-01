From: Mike Murphy <mamurph@cs.clemson.edu>
Subject: PATCH [0/3] input: xpad.c - Xbox 360 wireless and sysfs support
Date: Sat, 28 Feb 2009 23:49:49 -0500
Message-ID: <5aa163d00902282049g2e838b38g7e96040d5356d0da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:4462 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZCAEtw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 23:49:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>, Frederic Weisbecker <fweisbec@gmail.com>, torvalds@linux-foundation.org

Greetings,

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

Thanks,
Mike
-- 
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
