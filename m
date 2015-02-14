From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCH 3/3] psmouse: Disable resolution/rate changes for FocalTech touchpads.
Date: Sat, 14 Feb 2015 20:01:42 +0100
Message-ID: <1423940502-12353-4-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:39876 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbbBNTC0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2015 14:02:26 -0500
Received: by mail-qc0-f176.google.com with SMTP id b13so12823769qcw.7
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2015 11:02:25 -0800 (PST)
In-Reply-To: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>

These PS/2 commands might already be enough to make FocalTech touchpads
stop responding.

Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
---
 drivers/input/mouse/focaltech.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 05919cc..3d879c5 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -375,6 +375,17 @@ static int focaltech_read_size(struct psmouse *psmouse)
 
 	return 0;
 }
+
+void focaltech_set_resolution(struct psmouse *psmouse, unsigned int resolution)
+{
+	/* not supported yet */
+}
+
+static void focaltech_set_rate(struct psmouse *psmouse, unsigned int rate)
+{
+	/* not supported yet */
+}
+
 int focaltech_init(struct psmouse *psmouse)
 {
 	struct focaltech_data *priv;
@@ -409,6 +420,9 @@ int focaltech_init(struct psmouse *psmouse)
 	psmouse->cleanup = focaltech_reset;
 	/* resync is not supported yet */
 	psmouse->resync_time = 0;
+	/* rate/resolution changes are not supported yet */
+	psmouse->set_resolution = focaltech_set_resolution;
+	psmouse->set_rate = focaltech_set_rate;
 
 	psmouse->skip_standard_init = true;
 
-- 
2.1.0

