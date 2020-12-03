Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB7CC63777
	for <linux-input@archiver.kernel.org>; Thu,  3 Dec 2020 03:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13C621D7A
	for <linux-input@archiver.kernel.org>; Thu,  3 Dec 2020 03:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgLCDxs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 2 Dec 2020 22:53:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:12273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbgLCDxs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 2 Dec 2020 22:53:48 -0500
IronPort-SDR: uHb9Z2dGUJ1XpE0c6TLwsVGDAotEVMV93x+mYxVSZLwh+ny2RLe8LI9ysRbDNmmvoubFVL3G0h
 k67Mhn0LLfPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257842983"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="257842983"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 19:53:00 -0800
IronPort-SDR: kXyaVDt87+FhP8zEByxdlBhpLt8jBFyX4njEf+YzGRl3HvHyVvWWE1qf9gHW0xbr1EGOh2j5Qu
 67IJsusLKL+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="550330044"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 19:52:58 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v3 3/3] iio:Documentation: Add documentation for hinge sensor channels
Date:   Thu,  3 Dec 2020 11:53:52 +0800
Message-Id: <20201203035352.13918-4-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203035352.13918-1-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add channel description for hinge sensor, including channel label
attribute and raw data description.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index df42bed09f25..82303b1bdff0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1802,3 +1802,20 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
 		Units after application of scale are nano nanowatts per square meter.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Angle of rotation for channel Y. Units after application of scale
+		and offset are radians.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label for channel Y.
+		For Intel hid hinge sensor, the label values are:
+		hinge, keyboard, screen. It means the three channels
+		each correspond respectively to hinge angle, keyboard angle,
+		and screen angle.
-- 
2.17.1

