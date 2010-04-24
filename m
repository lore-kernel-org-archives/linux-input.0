From: Florian Ragwitz <rafl@debian.org>
Subject: Getting recent elantech touchpads to work with synaptics
Date: Sat, 24 Apr 2010 22:40:58 +0200
Message-ID: <1272141662-23431-1-git-send-email-rafl@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:54451 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab0DXV0i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 17:26:38 -0400
Received: from p4fd764a8.dip.t-dialin.net ([79.215.100.168]:33228 helo=tardis.perldition.org)
	by weedy.perldition.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <rafl@tardis.perldition.org>)
	id 1O5mAf-0008V3-Sy
	for linux-input@vger.kernel.org; Sat, 24 Apr 2010 22:41:50 +0200
Received: from rafl by tardis.perldition.org with local (Exim 4.71)
	(envelope-from <rafl@tardis.perldition.org>)
	id 1O5mA0-00069R-Vp
	for linux-input@vger.kernel.org; Sat, 24 Apr 2010 22:41:09 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The following 4 patches aim to improve various bits of the the elantech support
in the psmouse driver in order to get it to work with recent elantech firmwares
used in many touchpads of modern laptops. The list of those laptops includes
almost all recent ASUS machines, including the UL{2,3,5,8}0- and and P-series,
but also various others, like many Dell Inspiron machines.

[PATCH 1/4] Input: elantech - Assume all firmware versions >= 2.48 use 6 byte packets

  This patch just fixes a minor thinko in the handling of v1 vs. v2 firmware
  versions.

[PATCH 2/4] Input: Add an option to force the use of the elantech extension

  This adds a force_elantech options to the psmouse module, which allows to
  force the use of the elantech extension if a device responds to the elantech
  magic knock and firmware version request, but the driver doesn't know about
  the particular firmware version yet.

[PATCH 3/4] Input: elantech - Ignore high bits in the position coordinates

  This change is what actually makes things work on new firmwares. The driver
  used to use too many of the bits sent by the device to compute the position
  coordinates. On old versions all those bits were always zero, so it didn't
  actually matter, but new versions apparently reuse the bits for something
  else, screwing up results.

[PATCH 4/4] Input: elantech - Whitelist new models with firmware version 4.1

  This broadens the range of devices which are automatically recognized as
  elantech to include all devices reporting the bytes 0x04 0x01 0x01 upon a
  firmware version request. The check is intentionally rather strict, and I
  assume there's other devices out there, which report slightly different
  versions, but would still work, but given how easy it is to test those
  devices with the force_elantech option, I figured the check could be
  relaxed later, if necessary, and it'd be better to avoid recognizing
  non-elantech devices wrongly.


Those patches are only tested on machines with firmware version 4.1. They
should also be tested on older firmware versions using the 6-byte packet
format, like any ASUS Eee PC, before being applied.

--
BOFH excuse #196:
Me no internet, only janitor, me just wax floors.
