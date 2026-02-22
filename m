Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46135B65B;
	Sun, 22 Feb 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771797429; cv=none; b=M6jYCB2suqQQG01fWgCtObykv2pA5pQSxaNP3UP1YZ+KywWhDZpPzoi+9UFXed68PMEb4sSxrh9AZND7DOXz0ccqepl1Pm20m17147oc4/v0qAa3EKff3Qmv0JVeYnOYFRJkIUrwVNu5Bt67pdwworQ5EzBYzf1Bdxa25l1cS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771797429; c=relaxed/simple;
	bh=McjHn6jkVHdj6P2nTzDe/FXFI7Jf+V/aB/sNZ2jB9SQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz8aMkYIOt07/Gz322qqF4RavUQ6yAdiX/zB4PfEaXtFKYLSiB31DBxhyAeAY0Te3VJx4QIKLf0Aiff468AYwNF/bboHQ4nPYclKGG1XZ2Tqib1Sk35BWZ8IXX29DJd2T+s6ZmWgKQ9VCkG30Pye1qo59/rZ375K8T8pBVX3jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TVky2ps5; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TVky2ps5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771797419; x=1772056619;
	bh=ptRJYrCLVAOt6A6mpsjoMxnjsIgp6VIvHTySExynfVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TVky2ps5ynDMuQJG2uayZ1iNqGbKxbu6Z8BI64ceMAXjj4UWYfenC4g6dxtTgzzN1
	 Gun6Ex2XFsG77K7R2jtiZhzVPfyTAyu2p+/75X0pj4tcbnoPUV1N/tzkszBQEpb2LE
	 F9rsP5De+YbJb78AwFogx77uy1oIwZwmMNFvlJqM9/P1W8HY4Jla7X5al52L0ylpPh
	 YSnHJj4gmrkE5ux/v9wL+HaYbirvF6AOdsO96nA9zzJkbmuiC/DMwJZH6oikWT87AS
	 rMd1e38wNOiUF97i+oS7m+WJCrcBVe5ScFryEDrEB+otM1rdsUKlplysC+1rZ4aKDB
	 E/627sWEcF+4g==
Date: Sun, 22 Feb 2026 21:56:51 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v6 2/2] rust: hid: Glorious PC Gaming Race Model O and O- mice reference driver
Message-ID: <20260222215611.79760-3-sergeantsagara@protonmail.com>
In-Reply-To: <20260222215611.79760-1-sergeantsagara@protonmail.com>
References: <20260222215611.79760-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: fac78e5b704abddf8d1be6fa4ea3eec263425d83
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Demonstrate how to perform a report fixup from a Rust HID driver. The mice
specify the const flag incorrectly in the consumer input report descriptor,
which leads to inputs being ignored. Correctly patch the report descriptor
for the Model O and O- mice.

Portions of the HID report post-fixup:
device 0:0
...
0x81, 0x06,                    //  Input (Data,Var,Rel)               84
...
0x81, 0x06,                    //  Input (Data,Var,Rel)               112
...
0x81, 0x06,                    //  Input (Data,Var,Rel)               140

Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    Changelog:
   =20
        v5->v6:
          * NONE
        v4->v5:
          * NONE
        v3->v4:
          * Removed specifying tree in MAINTAINERS file since that is up fo=
r
            debate
          * Minor rebase cleanup
          * Moved driver logic under drivers/hid/rust
          * Use hex instead of decimal for the report descriptor comparison=
s
        v2->v3:
          * Fixed docstring formatting
          * Updated MAINTAINERS file based on v1 and v2 discussion
        v1->v2:
          * Use vendor id and device id from drivers/hid/hid-ids.h bindings
          * Make use for dev_err! as appropriate

 MAINTAINERS                           |  6 +++
 drivers/hid/hid-glorious.c            |  2 +
 drivers/hid/hid_glorious_rust.rs      | 60 +++++++++++++++++++++++++++
 drivers/hid/rust/Kconfig              | 16 +++++++
 drivers/hid/rust/Makefile             |  6 +++
 drivers/hid/rust/hid_glorious_rust.rs | 60 +++++++++++++++++++++++++++
 6 files changed, 150 insertions(+)
 create mode 100644 drivers/hid/hid_glorious_rust.rs
 create mode 100644 drivers/hid/rust/Makefile
 create mode 100644 drivers/hid/rust/hid_glorious_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fee14024fa2..1f9167221639 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10808,6 +10808,12 @@ L:=09platform-driver-x86@vger.kernel.org
 S:=09Maintained
 F:=09drivers/platform/x86/gigabyte-wmi.c
=20
+GLORIOUS RUST DRIVER [RUST]
+M:=09Rahul Rameshbabu <sergeantsagara@protonmail.com>
+L:=09linux-input@vger.kernel.org
+S:=09Maintained
+F:=09drivers/hid/rust/hid_glorious_rust.rs
+
 GNSS SUBSYSTEM
 M:=09Johan Hovold <johan@kernel.org>
 S:=09Maintained
diff --git a/drivers/hid/hid-glorious.c b/drivers/hid/hid-glorious.c
index 5bbd81248053..d7362852c20f 100644
--- a/drivers/hid/hid-glorious.c
+++ b/drivers/hid/hid-glorious.c
@@ -76,8 +76,10 @@ static int glorious_probe(struct hid_device *hdev,
 }
=20
 static const struct hid_device_id glorious_devices[] =3D {
+#if !IS_ENABLED(CONFIG_HID_GLORIOUS_RUST)
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_SINOWEALTH,
 =09=09USB_DEVICE_ID_GLORIOUS_MODEL_O) },
+#endif
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_SINOWEALTH,
 =09=09USB_DEVICE_ID_GLORIOUS_MODEL_D) },
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_LAVIEW,
diff --git a/drivers/hid/hid_glorious_rust.rs b/drivers/hid/hid_glorious_ru=
st.rs
new file mode 100644
index 000000000000..8cffc1c605dd
--- /dev/null
+++ b/drivers/hid/hid_glorious_rust.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Rahul Rameshbabu <sergeantsagara@protonmail.com>
+
+//! Rust reference HID driver for Glorious Model O and O- mice.
+
+use kernel::{self, bindings, device, hid, prelude::*};
+
+struct GloriousRust;
+
+kernel::hid_device_table!(
+    HID_TABLE,
+    MODULE_HID_TABLE,
+    <GloriousRust as hid::Driver>::IdInfo,
+    [(
+        hid::DeviceId::new_usb(
+            hid::Group::Generic,
+            bindings::USB_VENDOR_ID_SINOWEALTH,
+            bindings::USB_DEVICE_ID_GLORIOUS_MODEL_O,
+        ),
+        (),
+    )]
+);
+
+#[vtable]
+impl hid::Driver for GloriousRust {
+    type IdInfo =3D ();
+    const ID_TABLE: hid::IdTable<Self::IdInfo> =3D &HID_TABLE;
+
+    /// Fix the Glorious Model O and O- consumer input report descriptor t=
o use
+    /// the variable and relative flag, while clearing the const flag.
+    ///
+    /// Without this fixup, inputs from the mice will be ignored.
+    fn report_fixup<'a, 'b: 'a>(hdev: &hid::Device<device::Core>, rdesc: &=
'b mut [u8]) -> &'a [u8] {
+        if rdesc.len() =3D=3D 213
+            && (rdesc[84] =3D=3D 129 && rdesc[85] =3D=3D 3)
+            && (rdesc[112] =3D=3D 129 && rdesc[113] =3D=3D 3)
+            && (rdesc[140] =3D=3D 129 && rdesc[141] =3D=3D 3)
+        {
+            dev_info!(
+                hdev.as_ref(),
+                "patching Glorious Model O consumer control report descrip=
tor\n"
+            );
+
+            rdesc[85] =3D hid::MAIN_ITEM_VARIABLE | hid::MAIN_ITEM_RELATIV=
E;
+            rdesc[113] =3D hid::MAIN_ITEM_VARIABLE | hid::MAIN_ITEM_RELATI=
VE;
+            rdesc[141] =3D hid::MAIN_ITEM_VARIABLE | hid::MAIN_ITEM_RELATI=
VE;
+        }
+
+        rdesc
+    }
+}
+
+kernel::module_hid_driver! {
+    type: GloriousRust,
+    name: "GloriousRust",
+    authors: ["Rahul Rameshbabu <sergeantsagara@protonmail.com>"],
+    description: "Rust reference HID driver for Glorious Model O and O- mi=
ce",
+    license: "GPL",
+}
diff --git a/drivers/hid/rust/Kconfig b/drivers/hid/rust/Kconfig
index d3247651829e..d7a1bf26bed0 100644
--- a/drivers/hid/rust/Kconfig
+++ b/drivers/hid/rust/Kconfig
@@ -9,4 +9,20 @@ config RUST_HID_ABSTRACTIONS
 =09  Adds support needed for HID drivers written in Rust. It provides a
 =09  wrapper around the C hid core.
=20
+if RUST_HID_ABSTRACTIONS
+
+menu "Special HID drivers"
+
+config HID_GLORIOUS_RUST
+=09tristate "Glorious O and O- mice Rust reference driver"
+=09depends on USB_HID
+=09depends on RUST_HID_ABSTRACTIONS
+=09help
+=09  Support for Glorious PC Gaming Race O and O- mice
+=09  in Rust.
+
+endmenu # Special HID drivers
+
+endif # RUST_HID_ABSTRACTIONS
+
 endmenu # Rust HID support
diff --git a/drivers/hid/rust/Makefile b/drivers/hid/rust/Makefile
new file mode 100644
index 000000000000..6676030a2f87
--- /dev/null
+++ b/drivers/hid/rust/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Rust HID support
+#
+
+obj-$(CONFIG_HID_GLORIOUS_RUST)=09+=3D hid_glorious_rust.o
diff --git a/drivers/hid/rust/hid_glorious_rust.rs b/drivers/hid/rust/hid_g=
lorious_rust.rs
new file mode 100644
index 000000000000..dfc3f2323b60
--- /dev/null
+++ b/drivers/hid/rust/hid_glorious_rust.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Rahul Rameshbabu <sergeantsagara@protonmail.com>
+
+//! Rust reference HID driver for Glorious Model O and O- mice.
+
+use kernel::{self, bindings, device, hid, prelude::*};
+
+struct GloriousRust;
+
+kernel::hid_device_table!(
+    HID_TABLE,
+    MODULE_HID_TABLE,
+    <GloriousRust as hid::Driver>::IdInfo,
+    [(
+        hid::DeviceId::new_usb(
+            hid::Group::Generic,
+            bindings::USB_VENDOR_ID_SINOWEALTH,
+            bindings::USB_DEVICE_ID_GLORIOUS_MODEL_O,
+        ),
+        (),
+    )]
+);
+
+#[vtable]
+impl hid::Driver for GloriousRust {
+    type IdInfo =3D ();
+    const ID_TABLE: hid::IdTable<Self::IdInfo> =3D &HID_TABLE;
+
+    /// Fix the Glorious Model O and O- consumer input report descriptor t=
o use
+    /// the variable and relative flag, while clearing the const flag.
+    ///
+    /// Without this fixup, inputs from the mice will be ignored.
+    fn report_fixup<'a, 'b: 'a>(hdev: &hid::Device<device::Core>, rdesc: &=
'b mut [u8]) -> &'a [u8] {
+        if rdesc.len() =3D=3D 213
+            && (rdesc[84] =3D=3D 0x81 && rdesc[85] =3D=3D 0x3)
+            && (rdesc[112] =3D=3D 0x81 && rdesc[113] =3D=3D 0x3)
+            && (rdesc[140] =3D=3D 0x81 && rdesc[141] =3D=3D 0x3)
+        {
+            dev_info!(
+                hdev.as_ref(),
+                "patching Glorious Model O consumer control report descrip=
tor\n"
+            );
+
+            rdesc[85] =3D hid::MAIN_ITEM_VARIABLE | hid::MAIN_ITEM_RELATIV=
E;
+            rdesc[113] =3D hid::MAIN_ITEM_VARIABLE | hid::MAIN_ITEM_RELATI=
VE;
+            rdesc[141] =3D hid::MAIN_ITEM_VARIABLE | hid::MAIN_ITEM_RELATI=
VE;
+        }
+
+        rdesc
+    }
+}
+
+kernel::module_hid_driver! {
+    type: GloriousRust,
+    name: "GloriousRust",
+    authors: ["Rahul Rameshbabu <sergeantsagara@protonmail.com>"],
+    description: "Rust reference HID driver for Glorious Model O and O- mi=
ce",
+    license: "GPL",
+}
--=20
2.52.0


