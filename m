From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/7] libps2 facelift
Date: Fri, 19 Jan 2018 11:41:04 -0800
Message-ID: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39377 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755932AbeASTlP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:41:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

The main reason for the patch series is to have a bit more manageable
debug info for PS/2 init sequence: raw i8042 debug is way too noisy,
one has to decode sliced commands by hand, etc, etc. With proposed
changes you get a nice parsed command flow:

[14421.985416] __ps2_command: psmouse serio2: f5 [] - 0/00000000 []
[14421.993112] __ps2_command: psmouse serio2: f6 [] - 0/00000000 []
[14422.007738] __ps2_command: psmouse serio2: e1 [] - 0/00000000 [03 04]
[14422.042522] __ps2_command: psmouse serio2: e2 [81 4a 80] - 0/00000000 []
[14422.057091] __ps2_command: psmouse serio2: e2 [2c] - 0/00000000 [20]
[14422.057118] psmouse serio2: trackpoint: Elan TrackPoint firmware: 0x04, buttons: 3/3
[14422.072062] __ps2_command: psmouse serio2: f3 [64] - 0/00000000 []
[14422.086839] __ps2_command: psmouse serio2: e8 [03] - 0/00000000 []
[14422.094306] __ps2_command: psmouse serio2: e6 [] - 0/00000000 []
[14422.094504] input: TPPS/2 Elan TrackPoint as /devices/rmi4-00/rmi4-00.fn03/serio2/input/input33
[14422.128629] __ps2_command: psmouse serio2: f4 [] - 0/00000000 []

Additionally libps2 now can handle command and parameter byte
retransmissions and we relaxed rules for getting initial ACK to the
command byte, which hopefully will help properly detect devices that
are not silent when we start probing them.

Thanks.

Dmitry Torokhov (7):
  Input: libps2 - fix switch statement formatting
  Input: libps2 - use u8 for byte data
  Input: libps2 - use BIT() for bitmask constants
  Input: psmouse - move sliced command implementation to libps2
  Input: libps2 - add debugging statements
  Input: libps2 - support retransmission of command data
  Input: libps2 - relax command byte ACK handling

 drivers/input/mouse/elantech.c     |  12 +-
 drivers/input/mouse/logips2pp.c    |   2 +-
 drivers/input/mouse/psmouse-base.c |  26 ---
 drivers/input/mouse/psmouse.h      |   1 -
 drivers/input/mouse/synaptics.c    |   8 +-
 drivers/input/serio/libps2.c       | 322 +++++++++++++++++++++++++------------
 include/linux/libps2.h             |  34 ++--
 7 files changed, 249 insertions(+), 156 deletions(-)

-- 
Dmitry
