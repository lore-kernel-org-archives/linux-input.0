From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Input: wacom - Fix compiler warning if !CONFIG_PM
Date: Sat,  9 Aug 2014 19:07:03 +0200
Message-ID: <1407604023-7429-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

If CONFIG_PM is not set:

drivers/hid/wacom_sys.c:1436: warning: =E2=80=98wacom_reset_resume=E2=80=
=99 defined but
not used

Protect the unused functions by #ifdef CONFIG_PM to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/hid/wacom_sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 3e388ec31da8..f0db7eca9023 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1416,6 +1416,7 @@ static void wacom_remove(struct hid_device *hdev)
 	kfree(wacom);
 }
=20
+#ifdef CONFIG_PM
 static int wacom_resume(struct hid_device *hdev)
 {
 	struct wacom *wacom =3D hid_get_drvdata(hdev);
@@ -1436,6 +1437,7 @@ static int wacom_reset_resume(struct hid_device *=
hdev)
 {
 	return wacom_resume(hdev);
 }
+#endif /* CONFIG_PM */
=20
 static struct hid_driver wacom_driver =3D {
 	.name =3D		"wacom",
--=20
1.9.1
