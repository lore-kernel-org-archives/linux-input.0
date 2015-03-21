From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 03/12] HID: hid-lg4ff: (Cleanup) Replace DEVICE_ATTR_RW with DEVICE_ATTR to have all internal functions prefixed with "lg4ff_"
Date: Sat, 21 Mar 2015 12:47:33 +0100
Message-ID: <1426938462-884-4-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap.devoid-pointer.net ([31.31.77.140]:59553 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbbCULsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 07:48:21 -0400
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

All internal functions should be prefixed with just "lg4ff_". Usage of
DEVICE_ATTR_RW breaks this scheme because it expects the functions'
names to match the name of the respective sysfs entry.
This partially reverts "2f1cec3250e38609bf9252db52dbbe61603c04a7"

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 9a0c0e5..cec84a5 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -721,9 +721,9 @@ static ssize_t lg4ff_alternate_modes_store(struct d=
evice *dev, struct device_att
 }
 static DEVICE_ATTR(alternate_modes, S_IRUSR | S_IWUSR | S_IRGRP | S_IW=
GRP | S_IROTH, lg4ff_alternate_modes_show, lg4ff_alternate_modes_store)=
;
=20
-/* Read current range and display it in terminal */
-static ssize_t range_show(struct device *dev, struct device_attribute =
*attr,
-			  char *buf)
+/* Export the currently set range of the wheel */
+static ssize_t lg4ff_range_show(struct device *dev, struct device_attr=
ibute *attr,
+				char *buf)
 {
 	struct hid_device *hid =3D to_hid_device(dev);
 	struct lg4ff_device_entry *entry;
@@ -748,8 +748,8 @@ static ssize_t range_show(struct device *dev, struc=
t device_attribute *attr,
=20
 /* Set range to user specified value, call appropriate function
  * according to the type of the wheel */
-static ssize_t range_store(struct device *dev, struct device_attribute=
 *attr,
-			   const char *buf, size_t count)
+static ssize_t lg4ff_range_store(struct device *dev, struct device_att=
ribute *attr,
+				 const char *buf, size_t count)
 {
 	struct hid_device *hid =3D to_hid_device(dev);
 	struct lg4ff_device_entry *entry;
@@ -780,7 +780,7 @@ static ssize_t range_store(struct device *dev, stru=
ct device_attribute *attr,
=20
 	return count;
 }
-static DEVICE_ATTR_RW(range);
+static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IR=
OTH, lg4ff_range_show, lg4ff_range_store);
=20
 static ssize_t lg4ff_real_id_show(struct device *dev, struct device_at=
tribute *attr, char *buf)
 {
--=20
2.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
