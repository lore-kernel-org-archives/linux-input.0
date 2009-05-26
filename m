From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] usb1400_ts: fix access to "device data" in resume function
Date: Tue, 26 May 2009 19:04:40 +0200
Message-ID: <20090526170440.GA4993@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:55747 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbZEZREr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2009 13:04:47 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manuel Traut <manut@linutronix.de>, linux-input@vger.kernel.org, dtor@mail.ru, Marek Vasiut <marek.vasut@gmail.com>

From: Manuel Traut <manut@linutronix.de>

platform_data != driver_data

driver data is actually the "correct" place of the struct however it is
not placed there due to the need of the ac97 struct. This is broken since
d9105c2b01 aka "[ARM] 5184/1: Split ucb1400_ts into core and touchscreen"

Signed-off-by: Manuel Traut <manut@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
This is suspend/resume tested.
What happend actually to [0]? It is not merged.

[0] http://markmail.org/message/cp5koxmiotxrf4xl

 drivers/input/touchscreen/ucb1400_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 1647bc4..a42226e 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -418,7 +418,7 @@ static int ucb1400_ts_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static int ucb1400_ts_resume(struct platform_device *dev)
 {
-	struct ucb1400_ts *ucb = platform_get_drvdata(dev);
+	struct ucb1400_ts *ucb = dev->dev.platform_data;
 
 	if (ucb->ts_task) {
 		/*
-- 
1.6.0.6

