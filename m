From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] HID: logitech-hidpp: allow to disable tap to click on the K400
Date: Thu,  3 Sep 2015 09:08:28 -0400
Message-ID: <1441285710-21276-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45591 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160AbbICNIe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Sep 2015 09:08:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: simon@mungewell.org, BALATON Zoltan <balaton@eik.bme.hu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi guys,

This series adds a new parameter for the K400 owners. This keyboard has an
embedded touchpad which defaults to report tap to click. It can be annoying
given that there are physical buttons, and we can just disable that from the
host by using the feature 0x6010.

The first patch might conflict with Simon's current work in progress, so
that's why Simon is CC-ed to it.

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: logitech-hidpp: split HIDPP_QUIRK_DELAYED_INIT in two
  HID: logitech-hidpp: add support to disable tap-to-click on the K400

 drivers/hid/hid-logitech-hidpp.c | 159 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 9 deletions(-)

-- 
2.4.3

