From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 4/5] HID: intel_ish-hid: fix format string for size_t
Date: Thu, 18 May 2017 22:21:43 +0200
Message-ID: <20170518202144.3482304-5-arnd@arndb.de>
References: <20170518202144.3482304-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:58492 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbdERUWi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 May 2017 16:22:38 -0400
In-Reply-To: <20170518202144.3482304-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

When building for 32-bit architectures, we get a harmless warning:

intel-ish-hid/ishtp-hid-client.c: In function 'process_recv':
intel-ish-hid/ishtp-hid-client.c:139:7: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Werror=format=]

This changes the format string to print size_t variables using %zu
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 5c643d7a07b2..157b44aacdff 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -136,10 +136,9 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				if (1 + sizeof(struct device_info) * i >=
 						payload_len) {
 					dev_err(&client_data->cl_device->dev,
-						"[hid-ish]: [ENUM_DEVICES]: content size %lu is bigger than payload_len %u\n",
+						"[hid-ish]: [ENUM_DEVICES]: content size %zu is bigger than payload_len %zu\n",
 						1 + sizeof(struct device_info)
-						* i,
-						(unsigned int)payload_len);
+						* i, payload_len);
 				}
 
 				if (1 + sizeof(struct device_info) * i >=
-- 
2.9.0

