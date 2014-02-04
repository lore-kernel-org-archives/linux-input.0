From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH 0/5] Add ff-memless-next and make hid-lg4ff use it
Date: Tue, 04 Feb 2014 23:06:53 +0100
Message-ID: <1602354.DiHhm9tiaI@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.spider.cz ([31.31.77.241]:39326 "EHLO prifuk.cz"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933051AbaBDWHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 17:07:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, simon@mungewell.org, linux-input@vger.kernel.org

Hi everybody,

this patch series is a result of my work to improve FFB support for mem=
oryless
devices. ff-memless-next is an improvement over the currently available
ff-memless which is well suited for joypads but cannot handle more adva=
nced
devices such as racing wheels properly. As I have explained in one of R=
=46Cs
regarding ff-memless-next, the extent of changes makes implementing
ff-memless-next as a patch to ff-memless unfeasible. As of now there is=
 a total
of 27 drivers using ff-memless (including lg4ff) - a lot of them joypad=
s.
I do not have access to any FFB joypad at the moment so I cannot
implement the functionality required to handle joypads properly - namel=
y FF_RUMBLE
and emulation of FF_PERIODIC through FF_RUMBLE.
The plan is to implement the missing functionality and replace ff-memle=
ss completely
in the future.=20

Second part of this series ports lg4ff driver over to ff-memless-next.
The immediate benefit of this is support of all periodic effects and ra=
mp effect.

Michal M.

 Michal Mal=FD (5):
  INPUT: Add ff-memless-next module
  HID: Port hid-lg4ff to ff-memless-next
  HID: Add support for periodic effects in hid-lg4ff
  HID: Add support for ramp effect in hid-lg4ff
  INPUT: Remove the note that no driver currently uses ff-memless-next =
from KConfig

 Documentation/input/ff-memless-next.txt | 149 ++++++
 drivers/hid/Kconfig                     |   2 +-
 drivers/hid/hid-lg4ff.c                 |  93 ++--
 drivers/input/Kconfig                   |  11 +
 drivers/input/Makefile                  |   2 +
 drivers/input/ff-memless-next.c         | 793 ++++++++++++++++++++++++=
++++++++
 include/linux/input/ff-memless-next.h   |  31 ++
 7 files changed, 1045 insertions(+), 36 deletions(-)
--
 1.8.5.3

--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
