From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 6/8] HID: roccat: Increased waiting time for Kone[+] to
 prevent occasional freezes
Date: Sun, 30 Jan 2011 13:38:26 +0100
Message-ID: <1296391106.2283.185.camel__26714.8771243685$1296391223$gmane$org@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:33478 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754190Ab1A3Mif (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jan 2011 07:38:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil>

On newer kernels the device freezes occasionally on initialization with just
70msec between reads. Increased this value to safe 100msec.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-koneplus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 29a42b4..7367e4e 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -557,7 +557,7 @@ static int koneplus_init_koneplus_device_struct(struct usb_device *usb_dev,
 		struct koneplus_device *koneplus)
 {
 	int retval, i;
-	static uint wait = 70; /* device will freeze with just 60 */
+	static uint wait = 100; /* device will freeze with just 60 */
 
 	mutex_init(&koneplus->koneplus_lock);
 
-- 
1.7.3.4



