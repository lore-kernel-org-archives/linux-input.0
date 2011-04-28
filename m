From: Armando Visconti <armando.visconti@st.com>
Subject: BUG: hid_report_raw_event() crash
Date: Thu, 28 Apr 2011 11:12:17 +0200
Message-ID: <4DB92F71.5070900@st.com>
References: <4DB92D93.7090602@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000103030301000008090904"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:44106 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752660Ab1D1JMU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 05:12:20 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11D46127
	for <linux-input@vger.kernel.org>; Thu, 28 Apr 2011 09:12:17 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas6.st.com [10.75.90.73])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9CA21F26
	for <linux-input@vger.kernel.org>; Thu, 28 Apr 2011 09:12:17 +0000 (GMT)
In-Reply-To: <4DB92D93.7090602@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--------------000103030301000008090904
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

I'm using a particular multi touch screen module, which is the
TP 72055 from Data Modul. They have tested it only for Win7.

Using it I have found a crash in hid_report_raw_event() on kernel
2.6.37, but I believe is there also in latest one.

Debugging the issue it seems that it is caused by the fact that
TP72055 module issues a hid report with a size equals to 0. The rsize
value gets
set to 536870912 and Linux is crashing in the memset because the
value is too big.

I think a proper checking on rsize must be made to avoid cases like that.
I'm attaching the simple patch I made.

Pls let me know if the fix makes sense or not.

THx,
Arm


--------------000103030301000008090904
Content-Type: text/plain;
	name="0001-HID-Fixed-a-crash-in-hid_report_raw_event-function.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-HID-Fixed-a-crash-in-hid_report_raw_event-function.patc";
	filename*1="h"

>From 4e3af7356b4973f8733669ba4c201e61b36e998a Mon Sep 17 00:00:00 2001
From: Armando Visconti <armando.visconti@st.com>
Date: Tue, 26 Apr 2011 17:07:54 +0200
Subject: [PATCH] HID: Fixed a crash in hid_report_raw_event() function.

I'm using a Data Modul EasyTouch USB multitouch controller, which is
issuing a hid report with a size equals to 0. The rsize value gets
set to 536870912 and Linux is crashing in the memset because the
value is too big.

Signed-off-by: Armando Visconti <armando.visconti@st.com>
---
 drivers/hid/hid-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b144b38..c5efca3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1024,6 +1024,9 @@ void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 
 	rsize = ((report->size - 1) >> 3) + 1;
 
+	if (rsize > HID_MAX_BUFFER_SIZE)
+		rsize = HID_MAX_BUFFER_SIZE;
+
 	if (csize < rsize) {
 		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
 				csize, rsize);
-- 
1.7.4


--------------000103030301000008090904--
