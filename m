From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/3] hid-hyperv: Do not use hid_parse_report() directly
Date: Sun, 22 Apr 2012 14:21:38 +0200
Message-ID: <1335097300-11881-2-git-send-email-rydberg@euromail.se>
References: <1335097300-11881-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335097300-11881-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: linux-input@vger.kernel.org

Upcoming changes will split the semantics of hid_parse_report()
and hid_parse(), so make sure drivers use hid_parse() in probe().

Compiled, not tested.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-hyperv.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 4066324..032e6c0 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -430,6 +430,15 @@ cleanup:
 	return ret;
 }
 
+static int mousevsc_hid_parse(struct hid_device *hid)
+{
+	struct hv_device *dev = hid_get_drvdata(hid);
+	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
+
+	return hid_parse_report(hid, input_dev->report_desc,
+				input_dev->report_desc_size);
+}
+
 static int mousevsc_hid_open(struct hid_device *hid)
 {
 	return 0;
@@ -449,6 +458,7 @@ static void mousevsc_hid_stop(struct hid_device *hid)
 }
 
 static struct hid_ll_driver mousevsc_ll_driver = {
+	.parse = mousevsc_hid_parse,
 	.open = mousevsc_hid_open,
 	.close = mousevsc_hid_close,
 	.start = mousevsc_hid_start,
@@ -510,9 +520,9 @@ static int mousevsc_probe(struct hv_device *device,
 	if (ret)
 		goto probe_err1;
 
-	ret = hid_parse_report(hid_dev, input_dev->report_desc,
-				input_dev->report_desc_size);
+	hid_set_drvdata(hid_dev, device);
 
+	ret = hid_parse(hid_dev);
 	if (ret) {
 		hid_err(hid_dev, "parse failed\n");
 		goto probe_err2;
-- 
1.7.10
