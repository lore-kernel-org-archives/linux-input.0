From: Jethro Beekman <jethro@jbeekman.nl>
Subject: joydev: Keyboards incorrectly identified as joystick
Date: Sat, 12 Oct 2013 15:05:57 -0700
Message-ID: <5259C7C5.60706@jbeekman.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jbeekman.nl ([94.142.245.119]:60513 "EHLO daxilon.jbeekman.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab3JLWfE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Oct 2013 18:35:04 -0400
Received: from c-71-59-213-250.hsd1.or.comcast.net ([71.59.213.250] helo=[10.0.0.11])
	by daxilon.jbeekman.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.76)
	(envelope-from <jethro@jbeekman.nl>)
	id 1VV7K0-0003fI-I9
	for linux-input@vger.kernel.org; Sun, 13 Oct 2013 00:06:04 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Or, really: "Keyboards incorrectly say they're a joystick". Some keyboard like
to say they have joystick capabilities while they don't. This results in a
joystick device showing up (e.g. in games) that is not calibrated and just
generally messes things up.

This seems to happen with multiple keyboards, mostly from Microsoft: e.g. the
Microsoft Digital Media Pro Keyboard and Microsoft Wired Keyboard 600.

Earlier reports on this mailing list:
http://thread.gmane.org/gmane.linux.kernel.input/25913
http://thread.gmane.org/gmane.linux.kernel.input/25926

Downstream bug reports:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/987877
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/390959

evtest output for certain keyboards:
https://launchpadlibrarian.net/112444244/evtest2
http://pastebin.com/tX4nnhAg

It would be easy to add an exception to joydev_match() like there currently are
for touchpads, tablets, etc. The question is: what should the test be? Or should
this be handled in userspace (udev)?

Jethro Beekman
