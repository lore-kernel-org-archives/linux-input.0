From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 3/7] input: touchscreen: use to_delayed_work
Date: Fri,  1 Jan 2016 22:59:08 +0800
Message-ID: <178deb25bed7a09d97a5b37e75fa4db9f3194e1d.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-135.163.com ([123.125.50.135]:56243 "EHLO m50-135.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbcAAO7d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Jan 2016 09:59:33 -0500
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/input/touchscreen/pcap_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/pcap_ts.c b/drivers/input/touchscreen/pcap_ts.c
index 23a354a..0e3fc41 100644
--- a/drivers/input/touchscreen/pcap_ts.c
+++ b/drivers/input/touchscreen/pcap_ts.c
@@ -87,7 +87,7 @@ static void pcap_ts_read_xy(void *data, u16 res[2])
 
 static void pcap_ts_work(struct work_struct *work)
 {
-	struct delayed_work *dw = container_of(work, struct delayed_work, work);
+	struct delayed_work *dw = to_delayed_work(work);
 	struct pcap_ts *pcap_ts = container_of(dw, struct pcap_ts, work);
 	u8 ch[2];
 
-- 
2.5.0


