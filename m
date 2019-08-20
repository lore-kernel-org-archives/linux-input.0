From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Date: Tue, 20 Aug 2019 03:01:23 +0000
Message-ID: <1566270066-27546-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
List-Id: linux-input@vger.kernel.org

Simplify the ring buffer handling with the in-place API.

Also avoid the dynamic allocation and the memory leak in the channel
callback function.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Hi Dmitry, can this patch go through Sasha's hyperv tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git

This is a purely Hyper-V specific change.

 drivers/input/serio/hyperv-keyboard.c | 35 ++++++-------------------------=
----
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hy=
perv-keyboard.c
index 88ae7c2..e486a8a 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -237,40 +237,17 @@ static void hv_kbd_handle_received_packet(struct hv_d=
evice *hv_dev,
=20
 static void hv_kbd_on_channel_callback(void *context)
 {
+	struct vmpacket_descriptor *desc;
 	struct hv_device *hv_dev =3D context;
-	void *buffer;
-	int bufferlen =3D 0x100; /* Start with sensible size */
 	u32 bytes_recvd;
 	u64 req_id;
-	int error;
=20
-	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
-	if (!buffer)
-		return;
-
-	while (1) {
-		error =3D vmbus_recvpacket_raw(hv_dev->channel, buffer, bufferlen,
-					     &bytes_recvd, &req_id);
-		switch (error) {
-		case 0:
-			if (bytes_recvd =3D=3D 0) {
-				kfree(buffer);
-				return;
-			}
-
-			hv_kbd_handle_received_packet(hv_dev, buffer,
-						      bytes_recvd, req_id);
-			break;
+	foreach_vmbus_pkt(desc, hv_dev->channel) {
+		bytes_recvd =3D desc->len8 * 8;
+		req_id =3D desc->trans_id;
=20
-		case -ENOBUFS:
-			kfree(buffer);
-			/* Handle large packet */
-			bufferlen =3D bytes_recvd;
-			buffer =3D kmalloc(bytes_recvd, GFP_ATOMIC);
-			if (!buffer)
-				return;
-			break;
-		}
+		hv_kbd_handle_received_packet(hv_dev, desc, bytes_recvd,
+					      req_id);
 	}
 }
=20
--=20
1.8.3.1
