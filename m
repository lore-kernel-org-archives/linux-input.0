From: =?us-ascii?B?PT9VVEYtOD9xP0NsPUMzPUE5bWVudD0yMFZ1Y2hlbmVyPz0=?=
	<clement.vuchener@gmail.com>
Subject: [PATCH] HID: corsair: fix mapping of non-keyboard usages
Date: Tue, 16 Feb 2016 18:38:24 +0100
Message-ID: <20160216173824.GA23019@untxi.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35250 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbcBPRid (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 12:38:33 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

This fixes a bug where the Volume Up key was ignored because it uses th=
e same usage code as G18. Special Corsair usage codes are in the keyboa=
rd page, other pages should be left to the generic driver.

Signed-off-by: Cl=E9ment Vuchener <clement.vuchener@gmail.com>
---
 drivers/hid/hid-corsair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 5855196..717704e 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -595,6 +595,9 @@ static int corsair_input_mapping(struct hid_device =
*dev,
 {
 	int gkey;
=20
+	if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_KEYBOARD)
+		return 0;
+
 	gkey =3D corsair_usage_to_gkey(usage->hid & HID_USAGE);
 	if (gkey !=3D 0) {
 		hid_map_usage_clear(input, usage, bit, max, EV_KEY,
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
