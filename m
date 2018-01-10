From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] HID: roccat: prevent an out of bounds read in
 kovaplus_profile_activated()
Date: Wed, 10 Jan 2018 12:39:03 +0300
Message-ID: <20180110093903.yyoknoi7oc2cd5iy@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:49998 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeAJJje (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Jan 2018 04:39:34 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 43617fb28b87..317c9c2c0a7c 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >= ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile = new_profile_index;
 	kovaplus->actual_cpi = kovaplus->profile_settings[new_profile_index].cpi_startup_level;
 	kovaplus->actual_x_sensitivity = kovaplus->profile_settings[new_profile_index].sensitivity_x;
