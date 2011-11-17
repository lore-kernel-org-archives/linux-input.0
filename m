From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 17/17] HID: wiimote: Enable NO_INIT_REPORTS quirk
Date: Thu, 17 Nov 2011 14:12:14 +0100
Message-ID: <1321535534-7950-18-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64328 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1KQNNL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:13:11 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873566eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:13:11 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

Newer bluetooth stack supports the NO_INIT_REPORTS quirk. The wiimote does not
support report initialization so enable it by default.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 0cb391d..61881b3 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1175,6 +1175,8 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	struct wiimote_data *wdata;
 	int ret;
 
+	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+
 	wdata = wiimote_create(hdev);
 	if (!wdata) {
 		hid_err(hdev, "Can't alloc device\n");
-- 
1.7.7.3

