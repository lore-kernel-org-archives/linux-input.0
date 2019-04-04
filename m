From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] HID: intel-ish-hid: fix spelling mistake "multipe" -> "multiple"
Date: Thu,  4 Apr 2019 08:58:57 +0100
Message-ID: <20190404075857.12411-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
index e770e220bd73..22ba21457035 100644
--- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
+++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
@@ -525,7 +525,7 @@ static int ish_query_loader_prop(struct ishtp_cl_data *client_data,
 	if ((fw_info->ldr_capability.xfer_mode & LOADER_XFER_MODE_DIRECT_DMA) &&
 	    (fw_info->ldr_capability.max_dma_buf_size % L1_CACHE_BYTES)) {
 		dev_err(cl_data_to_dev(client_data),
-			"Shim firmware loader buffer size %d should be multipe of cacheline\n",
+			"Shim firmware loader buffer size %d should be multiple of cacheline\n",
 			fw_info->ldr_capability.max_dma_buf_size);
 		return -EINVAL;
 	}
-- 
2.20.1
