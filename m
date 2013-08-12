From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] Input: lifebook - Fix incorrect placement of __initconst
Date: Mon, 12 Aug 2013 15:03:20 +0530
Message-ID: <1376300001-16706-2-git-send-email-sachin.kamat@linaro.org>
References: <1376300001-16706-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47039 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3HLJuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Aug 2013 05:50:22 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3186816pdj.3
        for <linux-input@vger.kernel.org>; Mon, 12 Aug 2013 02:50:22 -0700 (PDT)
In-Reply-To: <1376300001-16706-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/mouse/lifebook.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 2c4db63..23222dd5 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -44,7 +44,7 @@ static int lifebook_set_6byte_proto(const struct dmi_system_id *d)
 	return 1;
 }
 
-static const struct dmi_system_id __initconst lifebook_dmi_table[] = {
+static const struct dmi_system_id lifebook_dmi_table[] __initconst = {
 	{
 		/* FLORA-ie 55mi */
 		.matches = {
-- 
1.7.9.5

