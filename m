From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.7-rc5
Date: Mon, 27 Jun 2016 17:04:19 -0700
Message-ID: <20160628000419.GD22620@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33289 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcF1AEW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 20:04:22 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Cameron Gutman (2):
      Input: xpad - fix rumble on Xbox One controllers with 2015 firmwa=
re
      Input: xpad - fix oops when attaching an unknown Xbox One gamepad

Dmitry Torokhov (1):
      Input: elantech - add more IC body types to the list

Hans Verkuil (1):
      Input: add BUS_CEC type

Kamil Debski (1):
      Input: add HDMI CEC specific keycodes

Pali Roh=E1r (1):
      MAINTAINERS: add Pali Roh=E1r as reviewer of ALPS PS/2 touchpad d=
river

Ping Cheng (2):
      Input: wacom_w8001 - w8001_MAX_LENGTH should be 13
      Input: wacom_w8001 - ignore invalid pen data packets

Sinclair Yeh (1):
      Input: vmmouse - remove port reservation


Diffstat:
--------

 MAINTAINERS                             |  4 ++++
 drivers/input/joystick/xpad.c           | 39 ++++++++++++++++++-------=
--------
 drivers/input/mouse/elantech.c          |  8 +------
 drivers/input/mouse/vmmouse.c           | 22 ++-----------------
 drivers/input/touchscreen/wacom_w8001.c | 11 +++++++++-
 include/uapi/linux/input-event-codes.h  | 31 +++++++++++++++++++++++++=
+
 include/uapi/linux/input.h              |  1 +
 7 files changed, 70 insertions(+), 46 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
