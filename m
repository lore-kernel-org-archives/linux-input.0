From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] Input: synaptics - Fix incorrect placement of __initconst
Date: Mon, 12 Aug 2013 15:03:21 +0530
Message-ID: <1376300001-16706-3-git-send-email-sachin.kamat@linaro.org>
References: <1376300001-16706-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42008 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3HLJuZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Aug 2013 05:50:25 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3186861pdj.3
        for <linux-input@vger.kernel.org>; Mon, 12 Aug 2013 02:50:24 -0700 (PDT)
In-Reply-To: <1376300001-16706-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/mouse/synaptics.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b2420ae..26386f9 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1433,7 +1433,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 
 static bool impaired_toshiba_kbc;
 
-static const struct dmi_system_id __initconst toshiba_dmi_table[] = {
+static const struct dmi_system_id toshiba_dmi_table[] __initconst = {
 #if defined(CONFIG_DMI) && defined(CONFIG_X86)
 	{
 		/* Toshiba Satellite */
@@ -1472,7 +1472,7 @@ static const struct dmi_system_id __initconst toshiba_dmi_table[] = {
 
 static bool broken_olpc_ec;
 
-static const struct dmi_system_id __initconst olpc_dmi_table[] = {
+static const struct dmi_system_id olpc_dmi_table[] __initconst = {
 #if defined(CONFIG_DMI) && defined(CONFIG_OLPC)
 	{
 		/* OLPC XO-1 or XO-1.5 */
-- 
1.7.9.5

