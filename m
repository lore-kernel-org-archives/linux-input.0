Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BC37B3FD
	for <linux-input@vger.kernel.org>; Sat, 14 Mar 2026 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525412; cv=none; b=C3Qp7A7w79O7bGhx1YoOGdYrlPXdJEoL6t6VXA6MeBqKsNNMy22/KmfsNYxffIWsqnvl3gHIyuVL00xtBaeHfuD9bTsbdflodvQs0xPrV2nLgLJKs74OqbYwjuefY2oIxZZXhhOw99vaH3CFG3bDRJnEl3di2lwfit/aj/xfehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525412; c=relaxed/simple;
	bh=pGIfi+gJfbYBcYeRmdqBYUu+37Q7jVeRyZuzBSmy+Fo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGEiYrhdOpiGILK/yboSdpEckOOPzLYjVBjwgr+mH18k3A0WCQPMN6Zm+Gz9k7uXKgoQOii79fBc6KSB209J/Fyf5jTzkCwjrDKUNnn/j+Q9EMxuBrVPsp/9+OmiBVDWa+RvBJw94zdCFlEEyB7OUHPuCAN5jAk9f3RMNsWjcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Q3RCptXb; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Q3RCptXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1773525402; x=1773784602;
	bh=FpxDasQC2M25ArxR1D/QwcKHAY17oNNAdzqo9i0QNTs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q3RCptXbz0Z6nZNPDlBiRofdy78E57MCNgA+pCZ6OuJCW68RqNSXHy0QiPIxtl9R8
	 1f90fzuXQfFEEM2SPgVCc51A7jikxpChWb2xzjaxDF4MGmr9kAxxKf5W2zsaSDybj3
	 YO+JFkuJUzQW3vpwCkv3YXve18ji9tB8wSchz8nVrm2Rkj8MxSi/bAXojh3b/JKVbX
	 +cB0IDhyjwsgIUidAZZC4NvMJwZxoO0DK3jN0R7jpqXmsubFa2I1xdgHnhrkMSsz4j
	 6BkJ8bjAz3rPLxKlUvNOoN0qWruae/fXFomlnpegsmhoaynAzYdREDp8KgH/0R1Qup
	 21Ygm024rnqjQ==
Date: Sat, 14 Mar 2026 21:56:35 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu, linuxhid@cosmicgizmosystems.com, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v7 2/2] rust: hid: Glorious PC Gaming Race Model O and O- mice reference driver
Message-ID: <20260314215527.57575-3-sergeantsagara@protonmail.com>
In-Reply-To: <20260314215527.57575-1-sergeantsagara@protonmail.com>
References: <20260314215527.57575-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: d0012c9a737ccfda2a163f06a67ade57a61d47de
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
        v6->v7:
          * Removed duplicate driver/hid/hid_glorious_rust.rs source
          * Made use of HID item bitflags
          * Updated report_fixup to use a single lifetime
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
 drivers/hid/rust/Kconfig              | 16 +++++++
 drivers/hid/rust/Makefile             |  6 +++
 drivers/hid/rust/hid_glorious_rust.rs | 67 +++++++++++++++++++++++++++
 5 files changed, 97 insertions(+)
 create mode 100644 drivers/hid/rust/Makefile
 create mode 100644 drivers/hid/rust/hid_glorious_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index be3638209bf3..66d977114efa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10805,6 +10805,12 @@ L:=09platform-driver-x86@vger.kernel.org
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
index 000000000000..09951fcdfb0d
--- /dev/null
+++ b/drivers/hid/rust/hid_glorious_rust.rs
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Rahul Rameshbabu <sergeantsagara@protonmail.com>
+
+//! Rust reference HID driver for Glorious Model O and O- mice.
+
+use kernel::{
+    self,
+    bindings,
+    device,
+    hid,
+    prelude::*, //
+};
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
+    fn report_fixup<'a>(hdev: &hid::Device<device::Core>, rdesc: &'a mut [=
u8]) -> &'a [u8] {
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
+            let desc_val =3D u32::from(hid::Item::Relative | hid::Item::Va=
riable) as u8;
+            rdesc[85] =3D desc_val;
+            rdesc[113] =3D desc_val;
+            rdesc[141] =3D desc_val;
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


