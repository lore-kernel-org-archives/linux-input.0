From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 05/12] HID: hid-lg4ff: Update a warning message for a case where device is incorrectly flagged to be handled by hid-lg4ff in hid-lg.
Date: Sat, 21 Mar 2015 12:47:35 +0100
Message-ID: <1426938462-884-6-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

The original warning message was highly misleading. This warning can be
triggered only if a device is flagged to be handled by hid-lg4ff in
hid-lg but hid-lg4ff lacks support for such device.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index d1d5d45..a2f47ee 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1021,8 +1021,7 @@ int lg4ff_init(struct hid_device *hid)
 	}
=20
 	if (i =3D=3D ARRAY_SIZE(lg4ff_devices)) {
-		hid_err(hid, "Device is not supported by lg4ff driver. If you think =
it should be, consider reporting a bug to"
-			     "LKML, Simon Wood <simon@mungewell.org> or Michal Maly <madcat=
xster@gmail.com>\n");
+		hid_err(hid, "This device is flagged to be handled by the lg4ff modu=
le but this module does not know how to handle it. Please report this a=
s a bug to LKML, Simon Wood <simon@mungewell.org> or Michal Maly <madca=
txster@devoid-pointer.net>\n");
 		return -1;
 	}
=20
--=20
2.3.3
