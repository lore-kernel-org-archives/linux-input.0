From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 1/2] [hid-sony] Fix typo in error message
Date: Wed, 20 Jan 2010 12:01:39 +0000
Message-ID: <1263988899.1735.2527.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab0ATMBu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 07:01:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>

---
 drivers/hid/hid-sony.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4e84502..96d723e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -81,7 +81,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	sc = kzalloc(sizeof(*sc), GFP_KERNEL);
 	if (sc == NULL) {
-		dev_err(&hdev->dev, "can't alloc apple descriptor\n");
+		dev_err(&hdev->dev, "can't alloc sony descriptor\n");
 		return -ENOMEM;
 	}
 
-- 
1.6.5.2


