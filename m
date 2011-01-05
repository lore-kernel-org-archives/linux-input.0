From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v2 0/10] hid-multitouch: a first step towards multitouch unification
Date: Wed,  5 Jan 2011 18:27:38 +0100
Message-ID: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39233 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1AER1O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 12:27:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Hi,

these patches is the set for the unified driver hid-multitouch.
I'm putting the flag RFC as I'm still waiting some testers feedback on some devices. But I don't think they will change a lot.

This would be great if this stuff could go into 2.6.38, if it's not too late.

These patches applies on top of Dmitry's next branch.

Cheers,
Benjamin

--

 drivers/hid/Kconfig          |   30 +--
 drivers/hid/Makefile         |    5 +-
 drivers/hid/hid-cando.c      |  274 ----------------------
 drivers/hid/hid-core.c       |    6 +-
 drivers/hid/hid-ids.h        |    7 +
 drivers/hid/hid-input.c      |   10 +-
 drivers/hid/hid-mosart.c     |  275 ----------------------
 drivers/hid/hid-multitouch.c |  526 ++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-quanta.c     |  261 ---------------------
 drivers/hid/hid-stantum.c    |  286 -----------------------
 include/linux/hid.h          |    6 +-
 11 files changed, 559 insertions(+), 1127 deletions(-)


