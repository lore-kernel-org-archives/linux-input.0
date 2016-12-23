From: Even Xu <even.xu@intel.com>
Subject: [PATCH 2/7] hid: intel-ish-hid: use helper function for private driver data set/get
Date: Fri, 23 Dec 2016 09:22:24 +0800
Message-ID: <1482456149-4841-2-git-send-email-even.xu@intel.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, andriy.shevchenko@intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

Use helper set/get function to set/get driver data in ishtp-hid-client
driver instead of directly accessing cl_device driver_data member.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 5c643d7a..3a3203d 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -321,7 +321,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
  */
 static void ish_cl_event_cb(struct ishtp_cl_device *device)
 {
-	struct ishtp_cl	*hid_ishtp_cl = device->driver_data;
+	struct ishtp_cl	*hid_ishtp_cl = ishtp_get_drvdata(device);
 	struct ishtp_cl_rb *rb_in_proc;
 	size_t r_length;
 	unsigned long flags;
@@ -770,7 +770,7 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 	if (!hid_ishtp_cl)
 		return;
 
-	cl_device->driver_data = hid_ishtp_cl;
+	ishtp_set_drvdata(cl_device, hid_ishtp_cl);
 	hid_ishtp_cl->client_data = client_data;
 	client_data->hid_ishtp_cl = hid_ishtp_cl;
 
@@ -819,7 +819,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	if (!hid_ishtp_cl)
 		return -ENOMEM;
 
-	cl_device->driver_data = hid_ishtp_cl;
+	ishtp_set_drvdata(cl_device, hid_ishtp_cl);
 	hid_ishtp_cl->client_data = client_data;
 	client_data->hid_ishtp_cl = hid_ishtp_cl;
 	client_data->cl_device = cl_device;
@@ -849,7 +849,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
  */
 static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 {
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
@@ -879,7 +879,7 @@ static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
  */
 static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
 {
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
@@ -903,7 +903,7 @@ static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
 static int hid_ishtp_cl_suspend(struct device *device)
 {
 	struct ishtp_cl_device *cl_device = to_ishtp_cl_device(device);
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
@@ -924,7 +924,7 @@ static int hid_ishtp_cl_suspend(struct device *device)
 static int hid_ishtp_cl_resume(struct device *device)
 {
 	struct ishtp_cl_device *cl_device = to_ishtp_cl_device(device);
-	struct ishtp_cl *hid_ishtp_cl = cl_device->driver_data;
+	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
-- 
2.7.4
