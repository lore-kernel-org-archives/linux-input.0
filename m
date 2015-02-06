From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 0/6] synaptics: match PNP-Id is not sufficient for min/max quirks
Date: Fri,  6 Feb 2015 10:44:53 -0500
Message-ID: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbbBFPpD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 10:45:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Here is the v4 of Daniel's patch series regarding
https://bugzilla.kernel.org/show_bug.cgi?id=91541

I am resending the whole series to add the "cc: stable@" flags and
to fix v3 5/5 which did not applied properly on top of input.git/for-next.

Cheers,
Benjamin

Benjamin Tissoires (1):
  Input: synaptics - Skip quirks when post-2013 dimensions

Daniel Martin (5):
  Input: synaptics - Split synaptics_resolution(), query first
  Input: synaptics - Log queried and quirked dimension values
  Input: synaptics - Query min dimensions for fw v8.1
  Input: synaptics - Remove obsolete min/max quirk for X240
  Input: synaptics - Support min/max board id in min_max_pnpid_table

 drivers/input/mouse/synaptics.c | 79 +++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 15 deletions(-)

-- 
2.1.0

