Return-Path: <SRS0=Phb3=Z2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB9AC432C0
	for <linux-input@archiver.kernel.org>; Wed,  4 Dec 2019 03:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C082068E
	for <linux-input@archiver.kernel.org>; Wed,  4 Dec 2019 03:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLDDlR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 3 Dec 2019 22:41:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57383 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDDlR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Dec 2019 22:41:17 -0500
Received: from localhost.localdomain (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 564CBCEC92;
        Wed,  4 Dec 2019 04:50:24 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     abhishekpandit@chromium.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hidraw: add support uniq ioctl
Date:   Wed,  4 Dec 2019 04:41:09 +0100
Message-Id: <20191204034109.21944-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add support for reading out the uniq information from the underlying HID
device. This might be the iSerialNumber in case of USB or the BD_ADDR in
case of Bluetooth.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/hid/hidraw.c        | 9 +++++++++
 include/uapi/linux/hidraw.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index bbc6ec1aa5cb..039304069fd0 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -450,6 +450,15 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 						-EFAULT : len;
 					break;
 				}
+
+				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWUNIQ(0))) {
+					int len = strlen(hid->uniq) + 1;
+					if (len > _IOC_SIZE(cmd))
+						len = _IOC_SIZE(cmd);
+					ret = copy_to_user(user_arg, hid->uniq, len) ?
+						-EFAULT : len;
+					break;
+				}
 			}
 
 		ret = -ENOTTY;
diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
index 98e2c493de85..4913539e5bcc 100644
--- a/include/uapi/linux/hidraw.h
+++ b/include/uapi/linux/hidraw.h
@@ -39,6 +39,7 @@ struct hidraw_devinfo {
 /* The first byte of SFEATURE and GFEATURE is the report number */
 #define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
 #define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
+#define HIDIOCGRAWUNIQ(len)     _IOC(_IOC_READ, 'H', 0x08, len)
 
 #define HIDRAW_FIRST_MINOR 0
 #define HIDRAW_MAX_DEVICES 64
-- 
2.23.0

