From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: synaptics-rmi4: make array rmi_f54_report_type_names static
Date: Mon,  2 Oct 2017 23:05:25 +0100
Message-ID: <20171002220525.11339-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55257 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdJBWGI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Oct 2017 18:06:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The array rmi_f54_report_type_names is local to the source and does
not need to be in global scope, so make it static. Also make the array
const char * const

Cleans up sparse warning:
symbol 'rmi_f54_report_type_names' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/rmi4/rmi_f54.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index f5206e2c767e..70f6310f1d15 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -73,7 +73,7 @@ enum rmi_f54_report_type {
 	F54_MAX_REPORT_TYPE,
 };
 
-const char *rmi_f54_report_type_names[] = {
+static const char * const rmi_f54_report_type_names[] = {
 	[F54_REPORT_NONE]		= "Unknown",
 	[F54_8BIT_IMAGE]		= "Normalized 8-Bit Image",
 	[F54_16BIT_IMAGE]		= "Normalized 16-Bit Image",
-- 
2.14.1

