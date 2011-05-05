From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/2] ads7846: Remove unused variable from struct ads7845_ser_req
Date: Thu,  5 May 2011 08:51:08 +0200
Message-ID: <1304578268-24887-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1304578268-24887-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:52585 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1EEGvL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 02:51:11 -0400
In-Reply-To: <1304578268-24887-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
This obsolets the patch
[PATCH 2/2] ads7846: Remove unused variable from struct ads7845_ser_req

 drivers/input/touchscreen/ads7846.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index ab51a8d..1de1c19 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -292,7 +292,6 @@ struct ser_req {
 
 struct ads7845_ser_req {
 	u8			command[3];
-	u8			pwrdown[3];
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
 	/*
-- 
1.7.3.4

