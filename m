Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0B4534A8
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002734; cv=none; b=T2UnIpUvKoEyKfIS0IA89wXRK9SegJj0Q3pa6y9vAQMcqRsSfTSvIzYdmZT6ZJzs7UOsKkO+a4FudzPlvvTFGqF4ICHtRBunQjbDe69ug8Em1x2dyIxabqI1QKO6LUK4N2yOoAC1fqqPhYSUsDfAjY7FLMjiKsnyK1wtqZ33jyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002734; c=relaxed/simple;
	bh=jGUOARt2Wbe1glZp6Gumt26zlKA1ASdKScJg/zrJwqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DPAbfK3A1XjZz9yl6Rf8gI3Hun3RzgYzXzFKNw2HdkBaK3BYHNcdp02P4qHYzbYGMVvwvOtldbfXOPYGYwb7XSozqbr+62hQh7qwfJl8X9GLOBbyfe/qZipj2NxqUVqlRtYZP8giOEpw2Rh+9DWK/mZhSV9b5WMmVYYZCpEISGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=HdGZMWJf; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=chif8Gb6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="HdGZMWJf";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="chif8Gb6"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HdGZMWJfSaSDu7LtWgfXrxi+a0+u91fYtGxZtYgh6bYymutn6nG4+vqZ9DQl4BNI340UE4Wigy3MXd8n6GKljs+i3newLT4W/CgvOVn4oth68h1NiIAntcwFlbGfvZ/8EaF5fdjUPP4OObUyMObUHCYjm+Q+JIO0/x1xKYfxkPYWneaXMk0zaeGB0Q+bXSRG6Hjqtqjm/6Y/aOGaDAw9ga5o2E4rpAa277+8fdyEKTuDn60hasval5lJKvorN/tKYsDCpOjAr7oJCBCwbYRKXlsKN+F+9DBRx4Tpz1nWmM1m6YlcHtVXX0ogMzoUxEYtuXiNhScTfwSqmAhepX04XA==; s=purelymail3; d=rcpassos.me; v=1; bh=jGUOARt2Wbe1glZp6Gumt26zlKA1ASdKScJg/zrJwqI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=chif8Gb6erlzkmuOFFlnkP/zo6K6lStmQwGONiYNYPHpuz0XVpKR5QqjWa5VZeP9NM417xb6vt/VQRe37BWaToGFH4BK7OQm2ESGKd6H1CJJlfCBbXObYObJt2uUpxkXZfCNeHhuKSuV/2bHcXaufr0611sfpR72XJwaaUTxjPErL4zB4ILBV1faxzxN6aO9W8tdSUdGffuy/9fnXpVE95ut2M5tHuFmmZvbG3yQG1V9Dp5iiRRY0nKV+7ac9+uVSOoRJzqldyGK//5zlVCtm+f0bVj9bxmx2f9VylMVuCzyeqIIkHm92kEd/+z7n107sEy7LIFBYvjVo2t6snZisA==; s=purelymail3; d=purelymail.com; v=1; bh=jGUOARt2Wbe1glZp6Gumt26zlKA1ASdKScJg/zrJwqI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1866441726;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 21:38:36 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 0/4] HID: wiimote: new LED behavior on connect + scoped_guards
Date: Mon, 17 Aug 2026 18:38:20 -0300
Message-ID: <20260817213840.1053216-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi,
This patchset contains one feature change, and 3 patches appying=20
scoped cleanup to locking and to the initialization functions for
the led probing and the main wiimote probe call.

The feature is turning different LEDs for each of the first 4 wiimotes conn=
ected.
From id 5 forward, the LED will cycle back to 1, and so on.
This uses the ida struct, so its quite simple and lightweight.
The hid_info log message prints out the controller id.

While implementing this feature, I decided to cleanup the code using
scoped_guard for the many spinlocks in the driver. There are two places
where the original lock/unlock version fits best, and I left them
untouched.
I also used the __free scope cleanup in the wiimote_probe and LED probe.
This was trivial for the LED probe.
The wiimote_probe required a new state tracker bitmask, now the wiimote_des=
troy
is used both on disconnect (hid_remove) and in the probe cleanup.

It was really fun working with this driver.
I tested it with 4 Wii Motion Plus remotes (gen2).
Video recording of my tests (48s video).
https://rcpassos.me/video/wiimote-led-linux-driver

Thanks,
Rafael Passos

---
V1: https://lore.kernel.org/linux-input/20260710153456.2093889-1-rafael@rcp=
assos.me/
Changes from v1:
    (1/3):
    - fix ida_alloc_min error handling to consider negative values
    - remove fallback to 1 on ida_alloc_min failure
    - move player_leds static array to hid-wiimote-core.c
    - s/instance_id/player_id/g
    - store player_id on an u8
    (2/3):
    - add header include for cleanup.h
    - add identation to one-liner scoped_guards
    (3/3):
    - add scoped cleanup function to wiimote_probe, with a bitmask to track=
 state
      Patch used for testing this:
      https://lore.kernel.org/linux-input/20260715213513.3929001-1-rafael@r=
cpassos.me/
    (4/4) *new patch* :
    - sashiko found a pre-existing uaf. Unlikely, but correct.
      implemented using the playstation driver as an inspiration

V2: https://lore.kernel.org/linux-input/20260710153456.2093889-1-rafael@rcp=
assos.me/
Changes from v2:
    (2/4):
    - join the last two locks into a single scoped_guard lock in wiimote_mo=
dules_load

V3: https://lore.rcpassos.me/wiimote/20260729164928.1138468-1-rafael@rcpass=
os.me/
Changes from v3:
    - dropped false uaf patch (previous 4/4). It was a false alarm.
      Discussion in:
      https://lore.kernel.org/linux-input/20260729164928.1138468-1-rafael@r=
cpassos.me/T/#t

    (1/4):
    - I tested how the changes looked if using ida from 0 instead of 1,
      and I believe it ended up less clean. I decided to keep them as is,
      with a few additional comments.
    - explicit initialization of player_id to 0 before allocating an id
    - avoid using a new int during ida_alloc (use ret instead)
    - use u8 instead of __u8
    - move ida_remove from wiimote_hid_remove to wiimote_destroy
    - add debugfs entry for the player_id entry
    (3/4):
    - move changes to wiimote_probe from this patch to the next
    - update patch title
    (4/4): *new patch*
    - scoped cleanup in the wiimote_probe call, using a bitmask to keep
      track of state during initialization
    - update wiimote_destroy so it can be the cleanup function
    - add a debugfs entry for this new entry

As we discussed in the v3, tell me if you like the changes in patch 4/4.
If you prefer not to apply it, I can send a new patchset revision, or
just drop it from the set if nothing else needs changes.

Thanks!


Rafael Passos (4):
  HID: wiimote: turn on the LEDs indicating the controller id
  HID: wiimote: replace spinlock pairs with scoped_guard
  HID: wiimote: led_probe with scoped cleanup
  HID: wiimote: wiimote_probe with scoped cleanup

 drivers/hid/hid-wiimote-core.c    | 346 ++++++++++++++++--------------
 drivers/hid/hid-wiimote-debug.c   |  71 +++---
 drivers/hid/hid-wiimote-modules.c |  24 +--
 drivers/hid/hid-wiimote.h         |  10 +
 4 files changed, 240 insertions(+), 211 deletions(-)

--=20
2.55.0

