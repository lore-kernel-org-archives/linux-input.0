From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] elan_i2c - Don't require known iap version
Date: Sat, 19 Sep 2015 10:10:47 -0700
Message-ID: <20150919171047.GA7081@dtor-ws>
References: <1442583495-4593-1-git-send-email-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34494 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbbISRK7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2015 13:10:59 -0400
Received: by padhy16 with SMTP id hy16so77950961pad.1
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2015 10:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442583495-4593-1-git-send-email-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: dusonlin@emc.com.tw, jprvita@gmail.com, linux-input@vger.kernel.org

Hi Daniel,

On Fri, Sep 18, 2015 at 07:38:15AM -0600, Daniel Drake wrote:
> The Asus X456UA has an ELAN1000 touchpad with IAP version 0xe.
> This is unknown to elan_get_fwinfo() so driver probe fails and I
> am left with an unusable touchpad.
> 
> However, the fwinfo is not required for general driver usage,
> it is only needed if the user decides to upload new firmware.
> 
> Adjust the driver so that fwinfo is only calculated and used
> when it is really needed.

I do not like the fact that the fact that the version of IAP is unknown
is not known to the driver until we try to flash the firmware. I'd
rather we check it upfront and warn user.

How about the version of the patch below?

Thanks!

-- 
Dmitry

Input: elan_i2c - don't require known iap version

From: Daniel Drake <drake@endlessm.com>

The Asus X456UA has an ELAN1000 touchpad with IAP version 0xe.  This is
unknown to elan_get_fwinfo() so driver probe fails and I am left with an
unusable touchpad.

However, the fwinfo is not required for general driver usage, it is only
needed if the user decides to upload new firmware.

Adjust the driver so that we do not abort probe when we encounter
unexpected IAP version, but rather warn user that firmware update feature
of the driver will not work.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa94530..7cad819 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -266,11 +266,10 @@ static int elan_query_device_info(struct elan_tp_data *data)
 
 	error = elan_get_fwinfo(data->iap_version, &data->fw_validpage_count,
 				&data->fw_signature_address);
-	if (error) {
-		dev_err(&data->client->dev,
-			"unknown iap version %d\n", data->iap_version);
-		return error;
-	}
+	if (error)
+		dev_warn(&data->client->dev,
+			 "unexpected iap version %#04x (ic type: %#04x), firmware update will not work\n",
+			 data->iap_version, data->ic_type);
 
 	return 0;
 }
@@ -486,6 +485,9 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 	const u8 *fw_signature;
 	static const u8 signature[] = {0xAA, 0x55, 0xCC, 0x33, 0xFF, 0xFF};
 
+	if (data->fw_validpage_count == 0)
+		return -EINVAL;
+
 	/* Look for a firmware with the product id appended. */
 	fw_name = kasprintf(GFP_KERNEL, ETP_FW_NAME, data->product_id);
 	if (!fw_name) {
