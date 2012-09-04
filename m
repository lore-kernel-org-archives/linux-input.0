From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH RESEND #4] dj: memory scribble in logi_dj
Date: Tue, 04 Sep 2012 15:10:08 +0100
Message-ID: <20120904140924.26323.88903.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43080 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab2IDNw2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Sep 2012 09:52:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: torvalds@linux-foundation.org, linux-input@vger.kernel.org

I've been sending this to the input list and maintainer for a month now with
no response, so this time it goes directly to Linus.

From: Alan Cox <alan@linux.intel.com>

Allocate a structure not a pointer to it !

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hid/hid-logitech-dj.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 0f9c146..4d524b5 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -439,7 +439,7 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	struct dj_report *dj_report;
 	int retval;
 
-	dj_report = kzalloc(sizeof(dj_report), GFP_KERNEL);
+	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -456,7 +456,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 	struct dj_report *dj_report;
 	int retval;
 
-	dj_report = kzalloc(sizeof(dj_report), GFP_KERNEL);
+	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;

