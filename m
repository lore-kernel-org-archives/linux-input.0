Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08937239E80
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247153; cv=none; b=fbjuSHGC1MwUGHXlkCWCAGcYGvPVxjMhCqOBOJMQmfUcCTkylHiFHAkjiFdejx7OSkVIEnDYI1rmZqOhraHs5eTB+AHZSWRWPfH5gKZutBXHmqponvC/wNQEyhuAA1ioaJ+EuXgy2weHJ7F2r/G/bn6Zdm0c0WUvmD5k3H9gS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247153; c=relaxed/simple;
	bh=iRiJWxUEPuabwNUCG/t4d0Oou0eYdWLxg0onYpx5Rwc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AV2zvWyXTMBN7oo0G9aVsSqvkRXK/OshmlVvY1NscE6NW+ZMjTobg7HtkOBx/h1JXNfxEEfXozHT3i6Kw9rCWOovkmLK9Z38jXmrhQXqROYiqwn0ZFkd2DbqWheqkQbayN1de7/3M+5GQWv9lskN1s6zGHV+JdJK0SQZVLsCrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RA5cQYs0; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RA5cQYs0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791247144; x=1791506344;
	bh=6LByDjMsQpMt9tL2Ap8Ed1rqTyb010JWduSfuiDFQbc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RA5cQYs0rpqRaHgIzbD3KclRtJhDXwwhPGTx/bgHsoaO0qNcK7keGasx3jPSwUiRL
	 +MHjXxqAAyl4d6EAp0G780dvIEuHbsMTZDAEncqKKwOB79qbQDpCXKZxfRACr4J1Q0
	 l9Pj4AI2jKGQy6VFYbIQdNANahHgU9OqnnUe5Gir3BECWx61cM0lMcQd1GolrAKBUs
	 NufS3LxVlIppv7hupUp3ugpV+shcHOJmGxaOwwEySYso9FqGd8ZUZy0JmSsQWWyWXA
	 nqcssX0Za9tCnYTzPXK5sA/vEmjUwOA2NcGuapBCRG7kQYjomkgXqUw8HbQ1BsAipj
	 krqwVPf6FjUlw==
Date: Tue, 06 Oct 2026 00:38:59 +0000
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
From: Bartosz Barc <bpbarc@proton.me>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?Q?Bartosz_Pawe=C5=82_Barc?= <bpbarc@proton.me>
Subject: [PATCH 1/2] HID: uclogic: Add support for XP-Pen Artist 12 (2nd Gen)
Message-ID: <20261006003844.10839-2-bpbarc@proton.me>
In-Reply-To: <20261006003844.10839-1-bpbarc@proton.me>
References: <20261006003844.10839-1-bpbarc@proton.me>
Feedback-ID: 109962581:user:proton
X-Pm-Message-ID: 3b297bd0f1464599a2b5e8f4ed563b4b98425305
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Bartosz Pawe=C5=82 Barc <bpbarc@proton.me>

The XP-Pen Artist 12 (2nd Gen) (28bd:094a) uses the same probe
protocol used by other supported UGEE tablets, but is currently
handled by the generic driver. Add the device's USB ID and
make it use the existing uclogic_params_ugee_v2_init() instead
to enable the correct recognition of the device and its capabilities.

Tested on the actual hardware; pen X/Y, pressure, tilt and pad buttons all
report correctly.

Signed-off-by: Bartosz Pawe=C5=82 Barc <bpbarc@proton.me>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a9537b7bb03d..2166d4ed6e14 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1555,6 +1555,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S=090x0909
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW=090x0933
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06=090x0078
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_ARTIST12_GEN2=090x094a
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO=090x091b
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_24_PRO=090x092d
 #define USB_DEVICE_ID_UGEE_TABLET_G5=09=090x0074
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.=
c
index 0b8a83fa6c5b..5c43647a299d 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -629,6 +629,8 @@ static const struct hid_device_id uclogic_devices[] =3D=
 {
 =09=09.driver_data =3D UCLOGIC_MOUSE_FRAME_QUIRK | UCLOGIC_BATTERY_QUIRK }=
,
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 =09=09=09=09USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
+=09{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+=09=09=09=09USB_DEVICE_ID_UGEE_XPPEN_TABLET_ARTIST12_GEN2) },
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 =09=09=09=09USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO) },
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-par=
ams.c
index ed16f50f21ed..7176b2950512 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1903,6 +1903,8 @@ int uclogic_params_init(struct uclogic_params *params=
,
 =09=09     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_MW):
 =09case VID_PID(USB_VENDOR_ID_UGEE,
 =09=09     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S):
+=09case VID_PID(USB_VENDOR_ID_UGEE,
+=09=09     USB_DEVICE_ID_UGEE_XPPEN_TABLET_ARTIST12_GEN2):
 =09case VID_PID(USB_VENDOR_ID_UGEE,
 =09=09     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW):
 =09=09rc =3D uclogic_params_ugee_v2_init(&p, hdev);
--=20
2.56.0


