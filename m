From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: core: do not reject devices when they declare too many usages
Date: Fri, 24 Jul 2015 12:02:22 -0400
Message-ID: <1437753742-3210-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?UTF-8?q?Simon=20W=C3=B6rner?= <mail@simon-woerner.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some device present proprietary collections with a usage min of 0x00 an=
d
a usage max of 0xffff. hid-core currently reject them while most of the
time this is harmless.
Let's ignore the exceeding usages, and hope for the best.

Reported-by: Simon W=C3=B6rner <mail@simon-woerner.de>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 157c627..b403fe2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -427,6 +427,7 @@ static int hid_parser_local(struct hid_parser *pars=
er, struct hid_item *item)
 {
 	__u32 data;
 	unsigned n;
+	__u32 count;
=20
 	data =3D item_udata(item);
=20
@@ -490,6 +491,24 @@ static int hid_parser_local(struct hid_parser *par=
ser, struct hid_item *item)
 		if (item->size <=3D 2)
 			data =3D (parser->global.usage_page << 16) + data;
=20
+		count =3D data - parser->local.usage_minimum;
+		if (count + parser->local.usage_index >=3D HID_MAX_USAGES) {
+			/*
+			 * We do not warn if the name is not set, we are
+			 * actually pre-scanning the device.
+			 */
+			if (dev_name(&parser->device->dev))
+				hid_warn(parser->device,
+					 "ignoring exceeding usage max\n");
+			data =3D HID_MAX_USAGES - parser->local.usage_index +
+				parser->local.usage_minimum - 1;
+			if (data <=3D 0) {
+				hid_err(parser->device,
+					"no more usage index available\n");
+				return -1;
+			}
+		}
+
 		for (n =3D parser->local.usage_minimum; n <=3D data; n++)
 			if (hid_add_usage(parser, n)) {
 				dbg_hid("hid_add_usage failed\n");
--=20
2.4.3
