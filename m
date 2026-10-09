Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920B2D77F5
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512945; cv=none; b=ENo7JwG2LgMeb8JjgTm2BHbvXb+EsUBl+IP7zOtTBVQzQCCOWALXkch6xdG3JpVbHTZV6GB/EforCSBzaLETfegYErsvg/aofoYA0Klx38I28ZqVZOrBrAv73+kZt5L+eEbduHKUf0nbWJ/km7f6+6l27OrKIQX5BYW8ZvPSlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512945; c=relaxed/simple;
	bh=TuC/A/pokqXk50Ycj6h+wi8MD3BDJSY20rcJITIaRHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gO0knYUTl0ce2pn+APXJ6uIz74Q2c7Q6ryF438AFJAtCW9wvyKbPxScJwCKNNjliDB7b0aP2gsNl/a1UFcRDXy6OduFLgK3HzmlF1UTEDzFxEhR9+AYIys4Q7jmcTGI/Kj3/k7uII5lx74d7qaOplV3ru7Y+GmY9IFL5BtpDHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=W36VRPht; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kdY9jUTI; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="W36VRPht";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kdY9jUTI"
DKIM-Signature: a=rsa-sha256; b=W36VRPhtL6im5L+jyS1WcNZRmffJVT6BGX25rcKOpv4OsDs8e6ZJIbcqqSfFjRI+GiRMEUAuNW62YXuARpY7VoPyP+0EOgzFOHXN8utvf3cV3TLGqXdUg90fg80ijETJzlUqwEZJnn90LnUca/6nypb7yhY4s1OJyUP6WnvSYvK2UFdPhnuvqKT90GmwuUqE80vviaPSVTxNaNCeid1qI64cTWy0nM7IZkiQ/pZK4dJ0242RQrHdCtmGKly8thhaKPEfcW88vKBnJTk5ED0hZ395B2Pa/C3FPniwlTHR4MU7ljLcbflY9Ie52fz41Bw2eX2F/B1FTZT9Lg/WfiUOkQ==; s=purelymail2; d=rcpassos.me; v=1; bh=TuC/A/pokqXk50Ycj6h+wi8MD3BDJSY20rcJITIaRHw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=kdY9jUTIA7ye+342UGnQ9KYUqLgYZnGvug1exh5+6htz/yFp1F1S5zW2TqRAXcVQqOuLS4NjWfO/1U1FlOKZBBUC2EB3qFIwdJE/SrII+RNs/HtLxbRaK3zKTQfCWaDsn6pIoa++hFq7Z0VA/rhzO4CjQ4uIugaPsvLCYE167FXuD3hbH+a8tDszq1/W+NW1dyQ/A/9rovb85dGl9tT02xY87nlwA0wDzZWSrWV5nqOZRG0ImdzBqGLNztSRgPWi4lj3MltWxv6puVMNA6M4inxjijrQ4PuCo+XwbNEP+9kNSrr8grwvtCN1r1amf9x2rInIT2h3lSMMlFOZ+wxUzQ==; s=purelymail2; d=purelymail.com; v=1; bh=TuC/A/pokqXk50Ycj6h+wi8MD3BDJSY20rcJITIaRHw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 703998172;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 09 Oct 2026 02:28:38 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v5 0/3] HID: wiimote: new LED behavior on connect + scoped_guards
Date: Thu,  8 Oct 2026 23:27:58 -0300
Message-ID: <20261009022844.2790778-1-rafael@rcpassos.me>
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

V4: https://lore.kernel.org/linux-input/20260817213840.1053216-1-rafael@rcp=
assos.me/
Changes from v4:
    - dropped wiimote probe with scoped guards (previous 4/4). It was too c=
omplex.
      Maybe we can still find a simpler way, outside of this patchset.
   =20
    (1/3):
    - drop previous wiiproto_req_leds call from wiimod_led_probe
      (covered by the new one in wiimote_modules_load)
    - On the call to wiiproto_req_leds in wiimote_modules_load:
        - Use U1 and to avoid integer promotion rules.
        - Use ARRAY_SIZE(player_leds) to avoid the hard-coded size
        - move call into spin-lock above
    - add guard to ida_free (was places in thw wrong patch)
    - replace ida_alloc_min by ida_alloc_range
    - change hid_info "registered" log to use the wdata->player_id value
    (2/3):
    - fix some whitespace/tab indentation mixup
    (3/3):
    - split declaration and assignment in the kzalloc

Thanks!


Rafael Passos (3):
  HID: wiimote: turn on the LEDs indicating the controller id
  HID: wiimote: replace spinlock pairs with scoped_guard
  HID: wiimote: led_probe with scoped cleanup

 drivers/hid/hid-wiimote-core.c    | 277 ++++++++++++++++--------------
 drivers/hid/hid-wiimote-debug.c   |  67 ++++----
 drivers/hid/hid-wiimote-modules.c |  22 +--
 drivers/hid/hid-wiimote.h         |   1 +
 4 files changed, 183 insertions(+), 184 deletions(-)

--=20
2.55.0

