From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 0/4] Migrations to hid-multitouch, round 2
Date: Wed,  9 Mar 2011 17:00:46 +0100
Message-ID: <1299686450-5475-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:41420 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab1CIQA7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 11:00:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <ch>

Hi guys,

This is the second version for this patch series.

Since last time, I integrated Henrik's comments.

Cheers,
Benjamin

 drivers/hid/Kconfig          |   21 +---
 drivers/hid/Makefile         |    3 -
 drivers/hid/hid-3m-pct.c     |  305 ------------------------------------------
 drivers/hid/hid-cando.c      |  276 --------------------------------------
 drivers/hid/hid-multitouch.c |  110 +++++++++++++---
 drivers/hid/hid-stantum.c    |  286 ---------------------------------------
 6 files changed, 97 insertions(+), 904 deletions(-)

;-)

