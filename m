From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 2/5] Read whole message instead of just the first byte
 to make CHG low
Date: Thu, 03 Feb 2011 16:02:19 +0200
Message-ID: <4D4AB56B.40405@atmel.com>
References: <4D3DAE3C.6060806@atmel.com> <20110124170756.GB31066@core.coreip.homeip.net> <4D3EA7DD.6000601@atmel.com> <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com> <20110203074318.GA5814@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:27812 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421Ab1BCOCG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 09:02:06 -0500
In-Reply-To: <20110203074318.GA5814@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

Input: qt602240_ts - Read whole message instead of just the first byte to make CHG low

From: Iiro Valkonen <iiro.valkonen@atmel.com>

Read the whole message, as reading just the first byte isn't always guaranteed to clear the message.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 739d18a..6ef8290 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -699,16 +699,16 @@ static int mxt_check_matrix_size(struct mxt_data *data)
 static int mxt_make_highchg(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
+	struct mxt_message message;
 	int count = 10;
 	int error;
-	u8 val;
 
 	/* Read dummy message to make high CHG pin */
 	do {
-		error = mxt_read_object(data, MXT_GEN_MESSAGE, 0, &val);
+		error = mxt_read_message(data, &message);
 		if (error)
 			return error;
-	} while ((val != 0xff) && --count);
+	} while ((message.reportid != 0xff) && --count);
 
 	if (!count) {
 		dev_err(dev, "CHG pin isn't cleared\n");
-- 
1.7.0.4
