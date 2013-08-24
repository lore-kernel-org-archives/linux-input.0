From: Ian Munsie <darkstarsword@gmail.com>
Subject: Add missing device ID for mid-2013 Macbook Air 6,1
Date: Sun, 25 Aug 2013 00:17:51 +1000
Message-ID: <1377353873-17000-1-git-send-email-darkstarsword@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44094 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab3HXOS3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Aug 2013 10:18:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

I recently got a new mid-2013 Macbook Air, which seems to use a device ID that
is missing from the kernel. From lsusb:
Bus 001 Device 003: ID 05ac:0290 Apple, Inc.

This generation of Macbook Air already has three IDs listed in the kernel
(0x0291, 0x0292 and 0x0293) as WELLSPRING8, so I've added 0x0290 to that list
as WELLSPRING8A. It looks like these generally come in triplets of consecutive
device IDs, so it's not clear to me why there would be an extra one in this
generation (and only -1 from the existing IDs which doesn't leave room for
additional ISO & JIS layouts if they are numbered consecutively).

With these patches the Fn key now works for me, as does the multitouch
functionality of the touchpad.

