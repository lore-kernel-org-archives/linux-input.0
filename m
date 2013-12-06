From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3.4-stable][CVE] HID: picolcd_core: validate output report details
Date: Fri, 6 Dec 2013 17:46:02 +0800
Message-ID: <1386323162-7676-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-input@vger.kernel.org, wangkefeng.wang@huawei.com, guohanjun@huawei.com
List-Id: linux-input@vger.kernel.org

=46rom: Kees Cook <keescook@chromium.org>

Hi Kees, Jiri or Greg,

This patch has been backported to 3.2 stable tree.
It is a CVE bugfix, and looks applicable to stable-3.4.
It prevents from triggering a NULL dereference during
atrr file writing if a HID device send a malicious output
report.

NOTE:
Rename file drivers/hid/hid-picolcd_core.c
	->  drivers/hid/hid-picolcd.c.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46rom: Kees Cook <keescook@chromium.org>
commit 1e87a2456b0227ca4ab881e19a11bb99d164e792 upstream.

A HID device could send a malicious output report that would cause the
picolcd HID driver to trigger a NULL dereference during attr file writi=
ng.

[jkosina@suse.cz: changed

	report->maxfield < 1

to

	report->maxfield !=3D 1

as suggested by Bruno].

CVE-2013-2899

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
Reviewed-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[Kefeng: backported to stable 3.4: adjust filename]
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/hid/hid-picolcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 45c3433..95f9047 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -1424,7 +1424,7 @@ static ssize_t picolcd_operation_mode_store(struc=
t device *dev,
 		buf +=3D 10;
 		cnt -=3D 10;
 	}
-	if (!report)
+	if (!report || report->maxfield !=3D 1)
 		return -EINVAL;
=20
 	while (cnt > 0 && (buf[cnt-1] =3D=3D '\n' || buf[cnt-1] =3D=3D '\r'))
--=20
1.8.2.2
