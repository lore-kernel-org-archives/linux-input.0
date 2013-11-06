From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 4/5] HID:hid-lg4ff: Initialize device properties before we touch autocentering.
Date: Wed,  6 Nov 2013 12:30:43 -0700
Message-ID: <1383766244-2336-4-git-send-email-simon@mungewell.org>
References: <1383766244-2336-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50303 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab3KFTbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Nov 2013 14:31:09 -0500
In-Reply-To: <1383766244-2336-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, Elias Vanderstuyft <elias.vds@gmail.com>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@prifuk.cz>

Re-arrange code slightly to ensure that device properties are configure=
d
before calling auto-center command.

Reported-by: Michal Mal=C3=BD <madcatxster@prifuk.cz>
Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5d140b7..5492809 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -589,17 +589,6 @@ int lg4ff_init(struct hid_device *hid)
 	if (error)
 		return error;
=20
-	/* Check if autocentering is available and
-	 * set the centering force to zero by default */
-	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
-		if (rev_maj =3D=3D FFEX_REV_MAJ && rev_min =3D=3D FFEX_REV_MIN)	/* F=
ormula Force EX expects different autocentering command */
-			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_ffex;
-		else
-			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_default;
-
-		dev->ff->set_autocenter(dev, 0);
-	}
-
 	/* Get private driver data */
 	drv_data =3D hid_get_drvdata(hid);
 	if (!drv_data) {
@@ -620,6 +609,17 @@ int lg4ff_init(struct hid_device *hid)
 	entry->max_range =3D lg4ff_devices[i].max_range;
 	entry->set_range =3D lg4ff_devices[i].set_range;
=20
+	/* Check if autocentering is available and
+	 * set the centering force to zero by default */
+	if (test_bit(FF_AUTOCENTER, dev->ffbit)) {
+		if (rev_maj =3D=3D FFEX_REV_MAJ && rev_min =3D=3D FFEX_REV_MIN)	/* F=
ormula Force EX expects different autocentering command */
+			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_ffex;
+		else
+			dev->ff->set_autocenter =3D hid_lg4ff_set_autocenter_default;
+
+		dev->ff->set_autocenter(dev, 0);
+	}
+
 	/* Create sysfs interface */
 	error =3D device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
