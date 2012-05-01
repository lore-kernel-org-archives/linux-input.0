From: srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] hid_parse failure
Date: Tue,  1 May 2012 09:07:52 -0700
Message-ID: <1335888472-19053-1-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13849 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758007Ab2EAQTr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 May 2012 12:19:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>

When logical maximum is 0xffffffff, the parser fails even if
logical minimum is equal to or greater than  0.
By HID specification, if both the Logical Minimum and Logical
Maximum extents are defined as positive values (0 or greater)
then the report field can be assumed to be an unsigned value.
Otherwise, all integer values are signed values represented
in 2=E2=80=99s complement format.
---
 drivers/hid/hid-core.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c757f10..b616f4b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -225,8 +225,16 @@ static int hid_add_field(struct hid_parser *parser=
, unsigned report_type, unsign
 		return -1;
 	}
=20
-	if (parser->global.logical_maximum < parser->global.logical_minimum) =
{
-		dbg_hid("logical range invalid %d %d\n", parser->global.logical_mini=
mum, parser->global.logical_maximum);
+	if ((parser->global.logical_minimum < 0 &&
+		parser->global.logical_maximum <
+			parser->global.logical_minimum) ||
+		(parser->global.logical_minimum >=3D 0 &&
+			(__u32)parser->global.logical_maximum <
+			(__u32)parser->global.logical_minimum)
+		) {
+		dbg_hid("logical range invalid 0x%x 0x%x\n",
+			parser->global.logical_minimum,
+				parser->global.logical_maximum);
 		return -1;
 	}
=20
--=20
1.7.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
