From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [GIT PULL] input: mt updates for 2.6.38
Date: Thu, 23 Dec 2010 16:20:31 +0100
Message-ID: <20101223152031.GA1755@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:42057 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752277Ab0LWPV0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Dec 2010 10:21:26 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next

to receive input-mt updates for 2.6.38.

The device properties are in there, the synaptics patches are in
there, and another wetab patch is in there.

Merry Christmas,
Henrik

Andy Ross (1):
      hid: egalax: Add support for Wetab (726b)

Henrik Rydberg (6):
      Input: introduce device properties
      Input: fix double equality sign in uevent
      input: mt: Document interface updates
      Input: synaptics - report clickpad property
      Input: synaptics - add multi-finger and semi-mt support
      Input: synaptics - ignore bogus mt packet

 Documentation/input/multi-touch-protocol.txt |   44 +++++++-----
 drivers/hid/hid-core.c                       |    1 +
 drivers/hid/hid-egalax.c                     |    2 +
 drivers/hid/hid-ids.h                        |    1 +
 drivers/input/evdev.c                        |    4 +
 drivers/input/input.c                        |   21 ++++++-
 drivers/input/misc/uinput.c                  |    4 +
 drivers/input/mouse/synaptics.c              |   95 ++++++++++++++++++++++++--
 drivers/input/mouse/synaptics.h              |    3 +
 include/linux/input.h                        |   16 ++++
 include/linux/uinput.h                       |    1 +
 11 files changed, 168 insertions(+), 24 deletions(-)
