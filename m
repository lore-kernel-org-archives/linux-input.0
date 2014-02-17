From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 1/2] HID: cp2112: make sysfs attributes static
Date: Mon, 17 Feb 2014 23:47:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402172346500.1192@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51595 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbaBQWri (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 17:47:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Barksdale <dbarksdale@uplogix.com>
Cc: linux-input@vger.kernel.org

No need to pollute namespace with dev_attr_*.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-cp2112.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index ca0f356..57cf045 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -663,7 +663,7 @@ static ssize_t name##_show(struct device *kdev, \
 		return ret; \
 	return scnprintf(buf, PAGE_SIZE, format, ##__VA_ARGS__); \
 } \
-DEVICE_ATTR_RW(name);
+static DEVICE_ATTR_RW(name);
 
 CP2112_CONFIG_ATTR(vendor_id, ({
 	u16 vid;
@@ -784,7 +784,7 @@ static ssize_t pstr_show(struct device *kdev,
 }
 
 #define CP2112_PSTR_ATTR(name, _report) \
-struct cp2112_pstring_attribute dev_attr_##name = { \
+static struct cp2112_pstring_attribute dev_attr_##name = { \
 	.attr = __ATTR(name, (S_IWUSR | S_IRUGO), pstr_show, pstr_store), \
 	.report = _report, \
 };

-- 
Jiri Kosina
SUSE Labs
