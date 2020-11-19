Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62EC63798
	for <linux-input@archiver.kernel.org>; Thu, 19 Nov 2020 03:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604DA208CA
	for <linux-input@archiver.kernel.org>; Thu, 19 Nov 2020 03:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgKSDDR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 18 Nov 2020 22:03:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:56445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKSDDR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Nov 2020 22:03:17 -0500
IronPort-SDR: lm/lv2E6GG7guUgJKUztIbSg/pzytGTbdGLF/Odu+Ci3QdzWC5rhXLhBHU+kzsYunGrJN2XKk0
 DmrYV0DID0Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="168651437"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="168651437"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 19:03:17 -0800
IronPort-SDR: +VU2x0HdSHtJaUEJaNUCmhJgAKmTwQOOHCvtKWjhVBpWSlPkpxxl5iiVH2fr+YXKULA2Osctpo
 AEgfx2uEkbCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="534584740"
Received: from host.sh.intel.com ([10.239.154.115])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2020 19:03:08 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH 3/4] iio: hid-sensor-trigger: Use iio->trig instead trig field internal structure
Date:   Thu, 19 Nov 2020 11:03:25 +0800
Message-Id: <20201119030326.6447-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119030326.6447-1-xiang.ye@intel.com>
References: <20201119030326.6447-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Use iio->trig instead of attrb->trig as parameter of iio_trigger_unregister
and iio_trigger_free. This allows one HID sensor driver to create
multiple iio devices. In this case common attributes are shared and
there can be one instance for the structure containing common attributes
for all iio devices.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 30340abcbc8d..bb5e7c8ff15b 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -236,8 +236,8 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
 	pm_runtime_put_noidle(&attrb->pdev->dev);
 
 	cancel_work_sync(&attrb->work);
-	iio_trigger_unregister(attrb->trigger);
-	iio_trigger_free(attrb->trigger);
+	iio_trigger_unregister(indio_dev->trig);
+	iio_trigger_free(indio_dev->trig);
 	iio_triggered_buffer_cleanup(indio_dev);
 }
 EXPORT_SYMBOL(hid_sensor_remove_trigger);
-- 
2.17.1

