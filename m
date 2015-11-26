From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] HID: rmi: rmi_hid_2d_sensor_data can be static
Date: Thu, 26 Nov 2015 09:43:32 +0800
Message-ID: <20151126014332.GA214912@lkp-ib03>
References: <201511260901.oU2KNPdc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46128 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbbKZBoN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 20:44:13 -0500
Content-Disposition: inline
In-Reply-To: <1448496641-25457-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@syanptics.com>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hid-rmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 81472c9..832c77d 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -497,7 +497,7 @@ static int rmi_check_valid_report_id(struct hid_device *hdev, unsigned type,
 	return 0;
 }
 
-struct rmi_2d_sensor_platform_data rmi_hid_2d_sensor_data = {
+static struct rmi_2d_sensor_platform_data rmi_hid_2d_sensor_data = {
 	.sensor_type = rmi_sensor_touchpad,
 	.axis_align.flip_y = true,
 	.kernel_tracking = true,
