From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: uclogic: fix limit in uclogic_tablet_enable()
Date: Wed, 29 Jul 2015 13:16:06 +0300
Message-ID: <20150729101606.GA12100@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42726 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbG2KQa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 06:16:30 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The limit should be ARRAY_SIZE(params) (5 elements) here instead of
sizeof(params) (20 bytes).

Fixes: 08177f40bd00 ('HID: uclogic: merge hid-huion driver in hid-uclogic')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 9416731..b905d50 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -858,7 +858,7 @@ static int uclogic_tablet_enable(struct hid_device *hdev)
 	for (p = drvdata->rdesc;
 	     p <= drvdata->rdesc + drvdata->rsize - 4;) {
 		if (p[0] == 0xFE && p[1] == 0xED && p[2] == 0x1D &&
-		    p[3] < sizeof(params)) {
+		    p[3] < ARRAY_SIZE(params)) {
 			v = params[p[3]];
 			put_unaligned(cpu_to_le32(v), (s32 *)p);
 			p += 4;
