From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 1/6] hid: sony: Prevent the freeing of an unitialized ida value
Date: Tue,  5 May 2015 20:47:28 -0400
Message-ID: <1430873253-11765-2-git-send-email-frank.praznik@oh.rr.com>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:49032 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755701AbbEFAv5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 20:51:57 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

sony_allocate_output_report() was being called before sony_set_device_id()
which meant that an unallocated ida value was was freed if the output
report allocation failed and the probe function jumped to err_stop.

Do the device ID allocation before the output report allocation to avoid
freeing an unallocated value in case of a failure.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 6ca96ce..4c521b2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1993,15 +1993,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	ret = sony_allocate_output_report(sc);
+	ret = sony_set_device_id(sc);
 	if (ret < 0) {
-		hid_err(hdev, "failed to allocate the output report buffer\n");
+		hid_err(hdev, "failed to allocate the device id\n");
 		goto err_stop;
 	}
 
-	ret = sony_set_device_id(sc);
+	ret = sony_allocate_output_report(sc);
 	if (ret < 0) {
-		hid_err(hdev, "failed to allocate the device id\n");
+		hid_err(hdev, "failed to allocate the output report buffer\n");
 		goto err_stop;
 	}
 
-- 
2.1.0

