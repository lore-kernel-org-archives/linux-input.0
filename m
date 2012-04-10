From: Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
Subject: [PATCH 3/3] HID: hid-aureal: Removing excessive dmesg information
Date: Tue, 10 Apr 2012 19:29:06 -0300
Message-ID: <1334096946-18788-4-git-send-email-jrbenito@benito.qsl.br>
References: <1334096946-18788-1-git-send-email-jrbenito@benito.qsl.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334096946-18788-1-git-send-email-jrbenito@benito.qsl.br>
In-Reply-To: <alpine.LNX.2.00.1204090207090.24006@pobox.suse.cz>
References: <alpine.LNX.2.00.1204090207090.24006@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Franco Catrin <fcatrin@gmail.com>, Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
List-Id: linux-input@vger.kernel.org

Avoid excessive dmesg verbosity as per Jiri=C2=B4s suggestion.

Signed-off-by: Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
---
 drivers/hid/hid-aureal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-aureal.c b/drivers/hid/hid-aureal.c
index 9fb676b..ba64b04 100644
--- a/drivers/hid/hid-aureal.c
+++ b/drivers/hid/hid-aureal.c
@@ -22,7 +22,7 @@ static __u8 *aureal_report_fixup(struct hid_device *h=
dev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	if (*rsize >=3D 54 && rdesc[52] =3D=3D 0x25 && rdesc[53] =3D=3D 0x01)=
 {
-		dev_info(&hdev->dev, "fixing Aureal Cy se W-01RN USB_V3.1 report des=
criptor. Keyboard Logical Maximum =3D 101\n");
+		dev_info(&hdev->dev, "fixing Aureal Cy se W-01RN USB_V3.1 report des=
criptor.\n");
 		rdesc[53] =3D 0x65;
 	} return rdesc;
 }
--=20
1.7.5.4
