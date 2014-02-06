From: "Anthony Olech <anthony.olech.opensource@diasemi.com>"
	<Anthony.Olech.OpenSource@diasemi.com>
Subject: [PATCH V1] da9052: ONKEY: use correct register bit for key status
Date: Thu, 6 Feb 2014 15:19:49 +0000
Message-ID: <201402111610.s1BGAXJo056493@swsrvapps-02.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.149]:44874 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071AbaBKQLD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 11:11:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Dajun Chen <david.chen@diasemi.com>

The wrong register bit of the DA9052/3 PMIC registers was
used to determine the status on the ONKEY.

Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
---

This patch is relative to linux-next repository tag next-20140206

The bug that this patch fixes affects only the DA9052 ONKEY driver.

The problem was detected whilst running a scripted set of functional
regression tests whilst investigating a different problem.

This patch has been test compiled on an amd64 server for both x86
and arm targets.

This patch has been spot verified using an SMDK6410 platform
fly-wired to a Dialog da9053 EVB.

 drivers/input/misc/da9052_onkey.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/da9052_onkey.c b/drivers/input/misc/da9052_onkey.c
index 1f695f2..7e78334 100644
--- a/drivers/input/misc/da9052_onkey.c
+++ b/drivers/input/misc/da9052_onkey.c
@@ -27,19 +27,23 @@ struct da9052_onkey {
 
 static void da9052_onkey_query(struct da9052_onkey *onkey)
 {
-	int key_stat;
+	int ret, key_stat;
 
-	key_stat = da9052_reg_read(onkey->da9052, DA9052_EVENT_B_REG);
-	if (key_stat < 0) {
+	ret = da9052_reg_read(onkey->da9052, DA9052_STATUS_A_REG);
+	if (ret < 0) {
 		dev_err(onkey->da9052->dev,
-			"Failed to read onkey event %d\n", key_stat);
+			"Failed to read onkey event err=%d\n", ret);
+		key_stat = false;
 	} else {
 		/*
 		 * Since interrupt for deassertion of ONKEY pin is not
 		 * generated, onkey event state determines the onkey
 		 * button state.
 		 */
-		key_stat &= DA9052_EVENTB_ENONKEY;
+		if (ret & DA9052_STATUSA_NONKEY)
+			key_stat = false;
+		else
+			key_stat = true;
 		input_report_key(onkey->input, KEY_POWER, key_stat);
 		input_sync(onkey->input);
 	}
-- 
end-of-patch for da9052: ONKEY: use correct register bit for key status V1

