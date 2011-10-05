From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 07/16] input: ambakmi: Enable module alias autogeneration for AMBA drivers
Date: Wed,  5 Oct 2011 17:04:58 +0100
Message-ID: <1317830707-17517-8-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54187 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934499Ab1JEQFp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 12:05:45 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so2790863wwf.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 09:05:45 -0700 (PDT)
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, =?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/input/serio/ambakmi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 12abc50..8407d5b 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -195,6 +195,8 @@ static struct amba_id amba_kmi_idtable[] = {
 	{ 0, 0 }
 };
 
+MODULE_DEVICE_TABLE(amba, amba_kmi_idtable);
+
 static struct amba_driver ambakmi_driver = {
 	.drv		= {
 		.name	= "kmi-pl050",
-- 
1.7.4.1

