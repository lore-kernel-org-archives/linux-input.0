From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/2] ads7846: Remove unused variable from struct ads7845_ser_req
Date: Wed,  4 May 2011 17:22:05 +0200
Message-ID: <1304522525-27351-2-git-send-email-alexander.stein@systec-electronic.com>
References: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox687.server-home.net ([195.149.74.151]:51560 "EHLO
	webbox687.server-home.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab1EDPWJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 11:22:09 -0400
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anatolij Gustschin <agust@denx.de>, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/input/touchscreen/ads7846.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 6157a80..7f6f523 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -288,7 +288,6 @@ struct ser_req {
 
 struct ads7845_ser_req {
 	u8			command[3];
-	u8			pwrdown[3];
 	u8			*sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
-- 
1.7.3.4

