From: Even Xu <even.xu@intel.com>
Subject: [PATCH 6/7] hid: intel-ish-hid: use helper function to search client id
Date: Fri, 23 Dec 2016 09:22:28 +0800
Message-ID: <1482456149-4841-6-git-send-email-even.xu@intel.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, andriy.shevchenko@intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

ishtp exposed helper ishtp_fw_cl_get_client() function for client
information searching, so switch to use it.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 0a7270c..34847ed 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -631,8 +631,8 @@ static int ishtp_get_report_descriptor(struct ishtp_cl *hid_ishtp_cl,
 static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 {
 	struct ishtp_device *dev;
-	unsigned long flags;
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_fw_client *fw_client;
 	int i;
 	int rv;
 
@@ -654,16 +654,14 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
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
2.7.4
