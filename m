From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 3/3] Input: wm97xx: Remove deprecated
 create_singletheread_workqueue
Date: Sun, 14 Aug 2016 10:56:38 +0530
Message-ID: <e062d8979274f279bf6e6181c321647ac193146d.1471151622.git.bhaktipriya96@gmail.com>
References: <cover.1471151622.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36738 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbcHNJCw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2016 05:02:52 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471151622.git.bhaktipriya96@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Stefan Assmann <sassmann@kpanic.de>, Richard Pospesel <pospeselr@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: Tejun Heo <tj@kernel.org>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

alloc_ordered_workqueue() with WQ_MEM_RECLAIM set, replaces
deprecated create_singlethread_workqueue(). This is the identity
conversion. The workqueue "ts_workq" has been identity converted.

It queues work items viz &wm->ts_reader and &wm->pen_event_work which map
to wm97xx_pen_irq_worker (handles a pen down interrupt) and
wm97xx_ts_reader (the touchscreen sample reader) respectively. Hence,
an ordered dedicated workqueue has been used.

WQ_MEM_RECLAIM has been set to ensure forward progress under memory
pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 1534e9b..c0af844 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -500,7 +500,7 @@ static int wm97xx_ts_input_open(struct input_dev *idev)
 {
 	struct wm97xx *wm = input_get_drvdata(idev);

-	wm->ts_workq = create_singlethread_workqueue("kwm97xx");
+	wm->ts_workq = alloc_ordered_workqueue("kwm97xx", WQ_MEM_RECLAIM);
 	if (wm->ts_workq == NULL) {
 		dev_err(wm->dev,
 			"Failed to create workqueue\n");
--
2.1.4

