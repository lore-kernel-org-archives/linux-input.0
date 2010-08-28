From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: roccat: Fixing race condition on initialization
Date: Sat, 28 Aug 2010 14:57:48 +0200
Message-ID: <1283000268.4789.1.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:42590 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753192Ab0H1M56 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Aug 2010 08:57:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.orglinux

Fixed raced condition where event occurs before drvdata is set.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index f776957..cfeab56 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -966,6 +966,10 @@ static int kone_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct kone_device *kone = hid_get_drvdata(hdev);
 	struct kone_mouse_event *event = (struct kone_mouse_event *)data;
 
+	/* possible race condition on initialization */
+	if (!kone)
+		return 0;
+
 	/* keyboard events are always processed by default handler */
 	if (size != sizeof(struct kone_mouse_event))
 		return 0;
-- 
1.7.2.2



