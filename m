From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] HID: ACRUX - add missing hid_hw_stop() in ax_probe() error
 path
Date: Thu, 14 Jul 2011 13:07:51 +0800
Message-ID: <1310620071.2721.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47794 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1GNFH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2011 01:07:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dtor@mail.ru>, Sergei Kolzun <x0r@dv-life.ru>, linux-input@vger.kernel.org

hid_hw_stop() must be called in ax_probe() error path if hid_hw_start()
was successful.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-axff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index b455428..1215141 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -154,6 +154,7 @@ static int ax_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	error = hid_hw_open(hdev);
 	if (error) {
 		dev_err(&hdev->dev, "hw open failed\n");
+		hid_hw_stop(hdev);
 		return error;
 	}
 
-- 
1.7.4.1



