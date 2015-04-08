From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 06/15] HID: hid-lg4ff: Update a warning message for a case where device is incorrectly flagged to be handled by hid-lg4ff in hid-lg.
Date: Wed,  8 Apr 2015 22:56:44 +0200
Message-ID: <1428526613-24239-7-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap.devoid-pointer.net ([31.31.77.140]:33006 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbbDHU50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:26 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Update a warning message for a case where device is incorrectly flagged=
 to be
handled by hid-lg4ff in hid-lg. The original warning message was highly
misleading. This warning can be triggered only if a device is flagged t=
o be
handled by hid-lg4ff in hid-lg but hid-lg4ff lacks support for such dev=
ice.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5a3b3be..04822fb 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1021,8 +1021,9 @@ int lg4ff_init(struct hid_device *hid)
 	}
=20
 	if (i =3D=3D ARRAY_SIZE(lg4ff_devices)) {
-		hid_err(hid, "Device is not supported by lg4ff driver. If you think =
it should be, consider reporting a bug to"
-			     "LKML, Simon Wood <simon@mungewell.org> or Michal Maly <madcat=
xster@gmail.com>\n");
+		hid_err(hid, "This device is flagged to be handled by the lg4ff modu=
le but this module does not know how to handle it. "
+			     "Please report this as a bug to LKML, Simon Wood <simon@mungew=
ell.org> or "
+			     "Michal Maly <madcatxster@devoid-pointer.net>\n");
 		return -1;
 	}
=20
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
