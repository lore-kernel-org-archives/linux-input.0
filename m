From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 0/2] ir-core: raw decoder framework changes
Date: Sun, 13 Jun 2010 22:29:25 +0200
Message-ID: <20100613202718.6044.29599.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:46112 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab0FMU3a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jun 2010 16:29:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jarod@wilsonet.com
Cc: jarod@redhat.com, linux-media@vger.kernel.org, mchehab@redhat.com, linux-input@vger.kernel.org

The following two patches implement the same ir raw decoder centralizat=
ion
changes I've proposed before, but now with some changes (client registe=
r
and unregister callbacks have been fixed wrt. module load order and
kept around) for lirc "decoding"...

---

David H=C3=A4rdeman (2):
      ir-core: centralize sysfs raw decoder enabling/disabling
      ir-core: move decoding state to ir_raw_event_ctrl


 drivers/media/IR/ir-core-priv.h    |   41 ++++++
 drivers/media/IR/ir-jvc-decoder.c  |  152 +---------------------
 drivers/media/IR/ir-nec-decoder.c  |  151 +---------------------
 drivers/media/IR/ir-raw-event.c    |  166 +++++++++++++-----------
 drivers/media/IR/ir-rc5-decoder.c  |  165 ++----------------------
 drivers/media/IR/ir-rc6-decoder.c  |  154 +---------------------
 drivers/media/IR/ir-sony-decoder.c |  155 ++--------------------
 drivers/media/IR/ir-sysfs.c        |  252 +++++++++++++++++++++-------=
--------
 8 files changed, 334 insertions(+), 902 deletions(-)

--=20
David H=C3=A4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
