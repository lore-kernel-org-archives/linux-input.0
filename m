Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB03EC80C
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343840; cv=none; b=GKildhVC8jhDuEd8RbnSwm4fIhAVMh2LtUVC/NL8ApjYxaAVq4mKPSY8k/sYKXy6uV7EUUdouNqFBBzy2Spx1SUg5WoAIku/y6fNly2zBZ2t+r7xuxWK2QPQZA1lpSUtUxsnHOQ7odBQ65bRwjhzIbPtjWCdyKdxFPUglI7YSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343840; c=relaxed/simple;
	bh=fMPRPATVYuVbIaMBbYkUz7HJNKPybOYOUz3YwZXFITk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExcX6FGrHQV1B6B1+Brvj7Nbka68dzje1yzHO8xke4c5wqtop68Lg0T8CCAJyVeZIlRPFXAa7kqqdCvsPf9MCp6bYuS2qZs0cJY+FnjANefyliVKioSmjpOkgf7fwu0KiYcqt3oYy8LQ6lhK/Ahh2JXjYWMFs1pgckeVk6Snxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=iYddih4D; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=e4jJB2iF; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="iYddih4D";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="e4jJB2iF"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=iYddih4DRXjQC8Bt4NVx8rCU2u48r6ffuGf71YWK7mRXsaITv8pjOjEs2pkWEwayyz2FKYwibhpsduYVVPdvunN+urqAGJ9ENhgeZmiUKV/4Bw/L0Jp04zXOONW15Ps4BxYDizXhUlhlyuOPUZcZHzcWkjApJ83dm6HT0p9pl7BN4UPRwEKbZP6rTwCPmvTcsgVXInB8P9WwduLgHR5FxxC/JwA0jUftz8v0OKUwVYWTyVBvH+P9Yn4oVWcaEXkJOlcY/dJ3PvgLVXffoRR7b7rk+Qy5plxHZ679RFA7iwjnArdN8rfAcb6kEZNdg/AEGukHlXqRjd5GP5embYN7yw==; s=purelymail3; d=rcpassos.me; v=1; bh=fMPRPATVYuVbIaMBbYkUz7HJNKPybOYOUz3YwZXFITk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=e4jJB2iFgx00/BZMNv400Bg8vUyOTSgMSk0PM8+CXjMdyJ78e9fkUyZJJ9zRq3hJEmLs6tv19/KJAk9ELZyLq9V5tSWdlPUroMXMSyisyZPMbjTF/yvZriVYLvOU10BOO8tgTOy4dAzgSGCQsLpRadDnwJIN9U0kyyBpm3yw41TqS0iSQQCEEuARJfT7nmyVe0S8BD3nC77J6alRZmcBrA5oVlaHyN8kRkqn00YLqCrvOWIVLn7/ISkBMkIzJvwPbj+5Ca0zOJsJfcP6V9kpR2xGAreRu5WV/z3oD89jdshaCKx38ZzPEWiHBlXA9ea/NeeYMiVAPCJzYLZyrExzXA==; s=purelymail3; d=purelymail.com; v=1; bh=fMPRPATVYuVbIaMBbYkUz7HJNKPybOYOUz3YwZXFITk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2129648507;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 29 Jul 2026 16:50:20 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	bentiss@kernel.org,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v3 0/4] HID: wiimote: new LED behavior on connect, scoped guards, uaf
Date: Wed, 29 Jul 2026 13:49:11 -0300
Message-ID: <20260729164928.1138468-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
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
This patchset contains one feature change, two cleanup patches + 1 uaf fix.

The feature is turning different LEDs for each of the first 4 wiimotes conn=
ected.
From id 5 forward, the LED will cycle back to 1, and so on.
This uses the ida struct, so its quite simple and lightweight.
The hid_info log message prints out the controller id.

While implementing this feature, I decided to cleanup the code using
scoped_guard for the many spinlocks in the driver. There are two places
where the original lock/unlock version fits best, and I left them
untouched.
I also used the __free scope cleanup in the wiimote and LED probe functions=
.
The wiimote_probe required a new state tracker bitmask. Trivial for the LED=
.
Lastly, I fixed a pre-existing uaf pointed out by sashiko in V1, using
the driver for the playstation controller as a reference.

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

Notes on Sashiko reviews for V2:
    - controller state on driver unload: it would be funny if the
      controller would stay vibrating as suggested. I forced this case
      dropping the connection from kernel in the dirty state, but the
      controller just shuts down.
    - mixed goto/scoped cleanup: there is scoped locking and goto, not
      scoped cleanup. I think this is fine.
    - integer/u8 truncation in player_id: would need 256+ controllers.
      Not realistic. Even Bluetooth would refuse this.


Rafael Passos (4):
  HID: wiimote: turn on the LEDs indicating the controller id
  HID: wiimote: replace spinlock pairs with scoped_guard
  HID: wiimote: use scoped cleanup in wiimote and led probes
  HID: wiimote: fix uaf when hid events are handled during destroy

 drivers/hid/hid-wiimote-core.c    | 339 ++++++++++++++++--------------
 drivers/hid/hid-wiimote-debug.c   |  50 ++---
 drivers/hid/hid-wiimote-modules.c |  24 +--
 drivers/hid/hid-wiimote.h         |   2 +
 4 files changed, 216 insertions(+), 199 deletions(-)

--=20
2.53.0
