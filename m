From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Use hid_report_len to compute the size of reports
Date: Thu, 8 Jan 2015 14:51:36 -0800
Message-ID: <1420757496-3955-3-git-send-email-aduggan@synaptics.com>
References: <1420757496-3955-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420757496-3955-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Now that hid_report_len is in hid.h we can use this function instead of
duplicating the code which computes it.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index b08774a..49d4fe4 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -1025,7 +1025,7 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto start;
 	}
 
-	data->input_report_size = (input_report->size >> 3) + 1 /* report id */;
+	data->input_report_size = hid_report_len(input_report);
 
 	if (!rmi_check_valid_report_id(hdev, HID_OUTPUT_REPORT,
 	    RMI_WRITE_REPORT_ID, &output_report)) {
@@ -1034,8 +1034,7 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto start;
 	}
 
-	data->output_report_size = (output_report->size >> 3)
-					+ 1 /* report id */;
+	data->output_report_size = hid_report_len(output_report);
 
 	data->device_flags |= RMI_DEVICE;
 	alloc_size = data->output_report_size + data->input_report_size;
-- 
2.1.0
