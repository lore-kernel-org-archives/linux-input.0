From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/5] HID: intel_ish-hid: fix format string for size_t
Date: Tue, 16 May 2017 13:09:06 +0200
Message-ID: <20170516110907.3545799-5-arnd@arndb.de>
References: <20170516110907.3545799-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516110907.3545799-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-input@vger.kernel.org

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
