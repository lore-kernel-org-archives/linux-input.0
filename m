From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/3] Balanced slots, attempt #2
Date: Mon, 30 Mar 2015 18:09:25 -0400
Message-ID: <1427753368-2795-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50434 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbC3WJf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Mar 2015 18:09:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

So, it occurs that the balanced slots assignment introduced in v4.0 had some
troubles and the Synaptics part was reverted.
I tried to spend some time today to figure out a solution, and the only way
I can get something from it is to add a band aid in input_mt_set_slots().

It should not be very costly, but I think it is required: I can guarantee that
the path is hit if the band aid is not here (pr_err was my friend).

So the series is:
- band aid
- revert the revert
- small fix in synaptics.c to keep the slots stable when landing a third finger.

Cheers,
Benjamin

Benjamin Tissoires (3):
  Input: mt - prevent balanced slot assignment to assign twice the slot
  Revert "Revert "Input: synaptics - use dmax in input_mt_assign_slots""
  Input: synaptics - allocate 3 slots to keep stability in image sensors

 drivers/input/input-mt.c        | 7 ++++++-
 drivers/input/mouse/synaptics.c | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.3.4

