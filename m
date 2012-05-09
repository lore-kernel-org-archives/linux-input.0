From: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] hid_parse failure
Date: Tue, 08 May 2012 19:06:12 -0700
Message-ID: <4FA9D114.2010208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60463 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab2EICGN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 May 2012 22:06:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org

Any comments on my patch for hid parsing failure (submitted on May 1st)=
?

Thanks,
Srinivas


When logical maximum is 0xffffffff, the parser fails even if
logical minimum is equal to or greater than  0.
By HID specification, if both the Logical Minimum and Logical
Maximum extents are defined as positive values (0 or greater)
then the report field can be assumed to be an unsigned value.
Otherwise, all integer values are signed values represented
in 2=92s complement format.
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

-	if (parser->global.logical_maximum<  parser->global.logical_minimum) =
{
-		dbg_hid("logical range invalid %d %d\n", parser->global.logical_mini=
mum, parser->global.logical_maximum);
+	if ((parser->global.logical_minimum<  0&&
+		parser->global.logical_maximum<
+			parser->global.logical_minimum) ||
+		(parser->global.logical_minimum>=3D 0&&
+			(__u32)parser->global.logical_maximum<
+			(__u32)parser->global.logical_minimum)
+		) {
+		dbg_hid("logical range invalid 0x%x 0x%x\n",
+			parser->global.logical_minimum,
+				parser->global.logical_maximum);
  		return -1;
  	}

--=20
1.7.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
