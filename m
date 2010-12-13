From: Henrik Rydberg <rydberg@euromail.se>
Subject: [GIT PULL] input: mt updates for 2.6.38
Date: Mon, 13 Dec 2010 09:29:26 +0100
Message-ID: <4D05D966.5080104@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:48132 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793Ab0LMI3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 03:29:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next

to receive input-mt updates for 2.6.38.

The changes have all been discussed on the list, and are mostly janitory in nature.

Thanks,
Henrik

Dmitry Torokhov (2):
      Input: include MT library as source for kerneldoc
      Input: document new trkid field in struct input_dev

Henrik Rydberg (3):
      input: mt: Move input MT header inside input directory
      input: mt: Interface and MT_TOOL documentation updates
      input: mt: Support separate contact and finger count reports

 Documentation/DocBook/device-drivers.tmpl    |    4 ++
 Documentation/input/multi-touch-protocol.txt |   39 ++++++++++++++++++--------
 drivers/hid/hid-3m-pct.c                     |    4 +-
 drivers/hid/hid-egalax.c                     |    4 +-
 drivers/input/input-mt.c                     |   35 +++++++++++++++++------
 drivers/input/input.c                        |    2 +-
 drivers/input/misc/uinput.c                  |    2 +-
 drivers/input/tablet/wacom_wac.c             |    4 +-
 drivers/input/touchscreen/wacom_w8001.c      |    2 +-
 include/linux/input.h                        |    7 ++--
 include/linux/{input-mt.h => input/mt.h}     |    3 +-
 11 files changed, 72 insertions(+), 34 deletions(-)
 rename include/linux/{input-mt.h => input/mt.h} (89%)
