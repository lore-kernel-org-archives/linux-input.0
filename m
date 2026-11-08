Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176981;
	b=srhT5wmEgWbHFh7u1jEU7n5/MfHD1PcnWCSmJPslVaQ18tdBqUYn1my9YuBl9LexuMGp
	 /NTWKblwKcFHAcgoI2zajduolBO3qje8Ry7aLm1yzfI9X28xaX69q8kL176U4RfLggSDb
	 FGcX0gxvjcxmYR08RsIgkS68iE7rbihnrDI33TiF3VREhRxJTRhejVNvlSI3AwSeKNaPF
	 hFVHkgZ6c+3DZckuLfFsMxqxK6p4yXEWMkHLL4IsLT7O6RkEYmd10V4QckD4nnHgBV0AM
	 qbCD7LQIm+mOnHn8QBPwmh44aZ7/m34y0rXtiYJqJbZ6EXVeMQ4ctu/fRL1ambuQM9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176981;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cl3KK+7ELAnJwxTVwpv5cn9kYvFlfkJEccGLK/+EL88=;
	b=1aqgAhAsKJ2RtzaS1BCnJZjNC7ZbGLnC14gyScbh02yKMfrAVKXRMQpybAn/L5hyPyTA
	 jEIJuIktFi6meVjO1Irutf8gO7jP7Vk4mxhNyKvWLY+ENGDd2Y0ElDOgMO0iocdvypS9T
	 JPhXdhsox++qzzL9ck7T/p8OWtoLDYL3YcP6xmOYRIXQrA9RNlEenjB1+9Hh0on5/pHFQ
	 iiuAHoVZjm43jJj6JTHLGM07pYAVSBDHfhjlYzt4CD4Rg2ELZLH5QQ0fH+3SdyWbmVSEv
	 AIOxvBoVd8ICZECDZcIr59Crtrv27fI7xNBixJy3+Z5ef4a+uISHDx9t7Zm7M93eBng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=to3WP2ay;
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA828606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 22:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA828606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=to3WP2ay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794176978; x=1794436178;
	bh=Cl3KK+7ELAnJwxTVwpv5cn9kYvFlfkJEccGLK/+EL88=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=to3WP2ayz9nl2rMQ3K7KlV3we2gmA6niCrqD/wGQvHEFPrlUOw0DW1nkC6Z/FDITc
	 9TVHiziBh8cO6eRnx/f4FfKLwvfrEn/cVVRqyDrr9gWTOd6XrEJ5Gdk3FqVijoh+C9
	 T85fkffQzP5hVBcGsksXOtJgbAYAtVQhcCkAA6KiWRW4a8jq5kWW5drRP1GLKhpWpr
	 GV/WBAwe7wzo30G8LsP7KqYu3FuATnmJQax+9FtrJZqxuC1rMhMHw6F+zsDWj/00Fq
	 yWmc0KYKRSaDb/f4+KVUZqjzO1yq+EuM9Kpc7EP329KRwMPhjK4KguUPbxMwZtMI8w
	 0NeT14SVboMGw==
Date: Sun, 08 Nov 2026 22:29:35 +0000
To: "djogorchock@gmail.com" <djogorchock@gmail.com>, "vi@endrift.com" <vi@endrift.com>, "jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org" <bentiss@kernel.org>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: nintendo-switch2-usb: check URB before use and reset state on free
Message-ID: <HP2LhXZGIipAd2XxKx7dDh8q3SopkJRAxo8IQkuyMxTlR0YfO3rS3CT9NqUkg3ispO72yfhC7Oa4MoZdXgo6lNIEjC1WvQFlrKreFzCnmFM=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 65647a40c734b711a0eec75365196c3c131bf883
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Proposed-fix limitation: the checks below do not establish URB or
interface lifetime across the pointer check, lock release, and subsequent
use. These proposed changes may therefore not resolve the teardown race
or the late-work use-after-free described below. Please review the
locking and work/interface lifetime before treating this as a complete
fix; this is an incomplete proposal for maintainer review, not a
validated resolution.

switch2_bulk_in() calls schedule_work() after dropping bulk_in_lock, so
the work can be queued after switch2_usb_free_in_urbs() has returned
from cancel_work_sync(). free_in_urbs() NULLs bulk_in[i].urb but never
resets bulk_in[i].state, so the late work still sees NS2_URB_IN and
dereferences urb->urb->transfer_buffer / urb->urb->actual_length on a
NULL pointer - the existing !urb->urb check sits after those
dereferences:

    if (urb->state !=3D NS2_URB_IN)
            continue;
    spin_unlock_irqrestore(...);
    if (ns2_usb->cfg.parent) {
            err =3D switch2_receive_command(..., urb->urb->transfer_buffer,
                                    urb->urb->actual_length);   <-- NULL de=
ref
    ...
    if (!urb->urb)   <-- too late

A malicious or misbehaving controller (or an unplug racing active
traffic) wins a narrow window to trigger this; the outcome is an oops
in workqueue context, and a use-after-free if the work runs after the
interface data is released. The patch re-checks urb->urb under the lock
before using it and resets the URB state when freeing, mirroring what
switch2_usb_shutdown() already does.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), drivers/hid/hid-nintendo-switch2-usb.c:51-121 (comp=
letion), 209-240 (free path), 288-316 (work).
New driver merged in this window (zero prior field exposure).

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-ninte=
ndo-switch2-usb.c
index 8b3b684..c846cef 100644
--- a/drivers/hid/hid-nintendo-switch2-usb.c
+++ b/drivers/hid/hid-nintendo-switch2-usb.c
@@ -231,6 +231,7 @@ static void switch2_usb_free_in_urbs(struct switch2_usb=
 *ns2_usb)
=20
 =09=09ns2_usb->bulk_in[i].urb =3D NULL;
 =09=09ns2_usb->bulk_in[i].data =3D NULL;
+=09=09ns2_usb->bulk_in[i].state =3D NS2_URB_FREE;
 =09=09spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
=20
 =09=09usb_kill_urb(urb);
@@ -298,6 +299,11 @@ static void switch2_usb_message_in_work(struct work_st=
ruct *work)
 =09=09urb =3D &ns2_usb->bulk_in[i];
 =09=09if (urb->state !=3D NS2_URB_IN)
 =09=09=09continue;
+=09=09=09/* urb->urb is NULLed by switch2_usb_free_in_urbs() while we
+=09=09=09 * may still run; re-check under the lock before using it.
+=09=09=09 */
+=09=09=09if (!urb->urb)
+=09=09=09=09continue;
 =09=09spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
=20
 =09=09if (ns2_usb->cfg.parent) {

