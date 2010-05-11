From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: elantech - signature...
Date: Tue, 11 May 2010 01:18:59 -0700
Message-ID: <20100511081859.10546.11991.stgit@localhost.localdomain>
References: <20100511081848.10546.95545.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42276 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0EKITC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 04:19:02 -0400
Received: by mail-pv0-f174.google.com with SMTP id 32so410917pvb.19
        for <linux-input@vger.kernel.org>; Tue, 11 May 2010 01:19:02 -0700 (PDT)
In-Reply-To: <20100511081848.10546.95545.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>, =?utf-8?b?w4lyaWM=?= Piel <E.A.B.Piel@tudelft.nl>, Arjan Opmeer <arjan@opmeer.net>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/elantech.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 232556a..b18862b 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -575,6 +575,24 @@ static struct attribute_group elantech_attr_group = {
 	.attrs = elantech_attrs,
 };
 
+static bool elantech_is_signature_valid(const unsigned char *param)
+{
+	static const unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10 };
+	int i;
+
+	if (param[0] == 0)
+		return false;
+
+	if (param[1] == 0)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(rates); i++)
+		if (param[2] == rates[i])
+			return false;
+
+	return true;
+}
+
 /*
  * Use magic knock to detect Elantech touchpad
  */
@@ -617,7 +635,7 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	pr_debug("Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
 		 param[0], param[1], param[2]);
 
-	if (param[0] == 0 || param[1] != 0) {
+	if (!elantech_is_signature_valid(param)) {
 		if (!force_elantech) {
 			pr_debug("Probably not a real Elantech touchpad. Aborting.\n");
 			return -1;

