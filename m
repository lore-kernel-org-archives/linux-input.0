From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] Input: wistron_btns - Fix incorrect placement of __initconst
Date: Mon, 12 Aug 2013 15:03:19 +0530
Message-ID: <1376300001-16706-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40106 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab3HLJuT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Aug 2013 05:50:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so7225481pab.20
        for <linux-input@vger.kernel.org>; Mon, 12 Aug 2013 02:50:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Miloslav Trmac <mitr@volny.cz>

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Miloslav Trmac <mitr@volny.cz>
---
 drivers/input/misc/wistron_btns.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 56536f4b9..35c33c6 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -635,7 +635,7 @@ static struct key_entry keymap_prestigio[] __initdata = {
  * a list of buttons and their key codes (reported when loading this module
  * with force=1) and the output of dmidecode to $MODULE_AUTHOR.
  */
-static const struct dmi_system_id __initconst dmi_ids[] = {
+static const struct dmi_system_id dmi_ids[] __initconst = {
 	{
 		/* Fujitsu-Siemens Amilo Pro V2000 */
 		.callback = dmi_matched,
-- 
1.7.9.5

