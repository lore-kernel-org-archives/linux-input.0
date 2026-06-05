Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550074D90B2;
	Fri,  5 Jun 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659625; cv=none; b=kV0Vw2wvw/5Y7gDbJTxsMN1c3bCw/kndrVtElxD+2+7Ma5LXBBMte1ozzWcAOmge5d05ULPjz1HGyXwCiUzspocjYo1XsYhfBwHq77fLdgx3lvV4/qSXZu1806mKxwU7MOqBf+AJwfpfCmdbKULZBi0Fz/Fo2fUXAv2mOTqZeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659625; c=relaxed/simple;
	bh=kQxgzON5kWuLJeZG1pt+vAE9qV8jr3cE2R7wGrK6yEo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fuN4fNCjvYRgxqSeicnK6tzN2PfpmZ4sARW9N31V1aw268u4m3bR6LgmTutfpTpsz1t9x3NDdDQK3XEkgcyyXd5maGZ+n5jdVut5CBdgxZIN3u4h7TgFN/bnjQCyi6gIHhghU/hUsJ+D7/VSNREUZXIj/2DhDQOlh/Xl8Xu881o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev; spf=pass smtp.mailfrom=ghoul.dev; dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b=X3heJ0S8; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghoul.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ghoul.dev header.i=@ghoul.dev header.b="X3heJ0S8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ghoul.dev;
	s=protonmail; t=1780659608; x=1780918808;
	bh=TJdRRyW6oQiteJM4L08kQ6KhtpMiKxYqh4EM/Zm2Dlk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X3heJ0S8A5wGADarRc62DY+uOrtKK5jhtpKMCiN82qfDZHcu+z2tLXVLqwgs9j7C2
	 2Di7poOqLRKPiI9qnUw8hz5z/Uk8Fszqh8Jfc8pv7DQtCo5zHERTS+JKx6qs0xb7ox
	 5p0ZxMXlDB+76MvGeeJTMWELTR4+P2KG6Ahz+GuBmWYBetAtzinnuQHG8M3+P4QSy7
	 o5qAyskAVKDxYhR3C9ltrqiiYE3rBCZI/svfYwOxuirECU8E9kRq66ciwQVmtIx5h3
	 W0505Oyae0pIIkqKlH0DeuGXYa/++HfCZrZ2UtzKFFDugGUisIBk2PWAo7w3HRW8FG
	 P072wH/1ZRMQg==
Date: Fri, 05 Jun 2026 11:40:01 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Ahmed Yaseen <yaseen@ghoul.dev>
Cc: Denis Benato <benato.denis96@gmail.com>, Antheas Kapenekakis <lkml@antheas.dev>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ahmed Yaseen <yaseen@ghoul.dev>
Subject: [PATCH] HID: usbhid: skip interrupt IN polling for devices with no input reports
Message-ID: <20260605113952.38435-1-yaseen@ghoul.dev>
Feedback-ID: 177610485:user:proton
X-Pm-Message-ID: d88ba283595d5a4531c8f681f67ca5b294a34a3e
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

usbhid starts polling a device's interrupt IN endpoint on open
(usbhid_open() -> hid_start_in()). If the report descriptor declares no
input reports there is nothing to read there, so the poll is useless,
and on some composite devices it is also harmful.

The ASUS ROG N-Key keyboards expose a second, input-less interface used
only for RGB control via feature reports. Opening its hidraw node (any
hidraw reader does, including SDL/Steam Input or a plain cat) starts the
pointless IN poll and keypress reports on the keyboard interface get
dropped for as long as the node stays open: a lost key-down drops a
letter, a lost key-up leaves the key stuck. usbmon shows the dropped
reports never reach the URB layer.

The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
asus: early return for ROG devices") is what exposes it on these
devices by keeping the input-less interface alive instead of ejecting
it, so its hidraw node can be opened and the poll started.

Skip the poll in usbhid_open() when the device has no input reports.
Feature reports and hidraw output keep working over the control and OUT
endpoints, so the interface is otherwise unaffected.

Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
Tested-by: GameBurrow <gameburrow@pm.me>
Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
---
 drivers/hid/usbhid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..90a8b34d9305 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -688,7 +688,8 @@ static int usbhid_open(struct hid_device *hid)
=20
 =09set_bit(HID_OPENED, &usbhid->iofl);
=20
-=09if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
+=09if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
+=09    list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
 =09=09res =3D 0;
 =09=09goto Done;
 =09}
--=20
2.54.0


