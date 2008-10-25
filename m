From: Andreas Schwab <schwab@suse.de>
Subject: [PATCH] Fix hid_device_id for cross compiling
Date: Sun, 26 Oct 2008 00:30:18 +0200
Message-ID: <jevdvgl345.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752902AbYJYWaa@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@ver.kernel.org
List-Id: linux-input@vger.kernel.org

struct hid_device_id contains hidden padding which is bad for cross
compiling.  Make the padding explicit and consistent across
architectures.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_device=
table.h
index eb71b45..0e4f303 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -135,6 +135,7 @@ struct usb_device_id {
=20
 struct hid_device_id {
 	__u16 bus;
+	__u16 pad1;
 	__u32 vendor;
 	__u32 product;
 	kernel_ulong_t driver_data

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
