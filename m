From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/3] Balanced slots, attempt #2
Date: Tue, 31 Mar 2015 11:07:34 -0400
Message-ID: <1427814457-30120-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbbCaPHo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 11:07:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

so this is the v2 with Hans' ack and Henrik's respin of the first patch.

Cheers,
Benjamin


Benjamin Tissoires (3):
  Input: MT - make slot assignment work for overcovered solutions
  Revert "Revert "Input: synaptics - use dmax in input_mt_assign_slots""
  Input: synaptics - allocate 3 slots to keep stability in image sensors

 drivers/input/input-mt.c        | 21 ++++++++++++---------
 drivers/input/mouse/synaptics.c |  7 +++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.3.4

