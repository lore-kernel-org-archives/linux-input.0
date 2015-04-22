From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] 2 somewhat related input fixes
Date: Wed, 22 Apr 2015 11:45:07 -0400
Message-ID: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965552AbbDVPpP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 11:45:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

here are 2 somewhat related patches that are needed when the hardware reports
a number of fingers greater than max slot while not filling all of the available
slots.

In such cases, libinput relies on the actual slot number (which should be
correct) and this is not what the hardware says.

The first one is marked for stable given that it has been there forever (2011)
and seems simple enough to be in stable.
The second one is a regression introduced in 4.1-rc0, so that would be sweet
to have it in 4.1 final.

Cheers,
Benjamin

Benjamin Tissoires (2):
  Input - elantech: fix semi-mt protocol for v3 HW
  Input - synaptics: pin 3 touches when the firmware reports 3 fingers

 drivers/input/mouse/elantech.c  | 2 +-
 drivers/input/mouse/synaptics.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.1.0

