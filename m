From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/9] hid: intel-ish-hid: use helper function to search client id
Date: Tue, 11 Sep 2018 16:44:18 -0700
Message-ID: <20180911234421.10691-7-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

From: Even Xu <even.xu@intel.com>

ishtp exposed helper ishtp_fw_cl_get_client() function for client
information searching, so switch to use it.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index bb8402f10831..e64243bc9c96 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -626,8 +626,8 @@ static int ishtp_get_report_descriptor(struct ishtp_cl *hid_ishtp_cl,
 static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 {
 	struct ishtp_device *dev;
-	unsigned long flags;
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_fw_client *fw_client;
 	int i;
 	int rv;
 
@@ -649,16 +649,14 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 	hid_ishtp_cl->rx_ring_size = HID_CL_RX_RING_SIZE;
 	hid_ishtp_cl->tx_ring_size = HID_CL_TX_RING_SIZE;
 
-	spin_lock_irqsave(&dev->fw_clients_lock, flags);
-	i = ishtp_fw_cl_by_uuid(dev, &hid_ishtp_guid);
-	if (i < 0) {
-		spin_unlock_irqrestore(&dev->fw_clients_lock, flags);
+	fw_client = ishtp_fw_cl_get_client(dev, &hid_ishtp_guid);
+	if (!fw_client) {
 		dev_err(&client_data->cl_device->dev,
 			"ish client uuid not found\n");
-		return i;
+		return -ENOENT;
 	}
-	hid_ishtp_cl->fw_client_id = dev->fw_clients[i].client_id;
-	spin_unlock_irqrestore(&dev->fw_clients_lock, flags);
+
+	hid_ishtp_cl->fw_client_id = fw_client->client_id;
 	hid_ishtp_cl->state = ISHTP_CL_CONNECTING;
 
 	rv = ishtp_cl_connect(hid_ishtp_cl);
-- 
2.17.1
