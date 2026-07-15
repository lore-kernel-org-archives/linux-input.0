Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF03BB66C
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150753; cv=none; b=hTSn0Ug0Oox2IBf6P5lrdDwUwhL6yrx846HSGtch+5+eOVKe74lfzh0Y2qgRrTmdmz/fe+ye1cLof7obCpy7CVLejxCdwnHT2b45C9FE+ZLUNjcjnDPYk+2o/EklQzLMFL/Y1Vz8tOu6vGoZ3HANFeTMSQEOM3M92jJqE87OEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150753; c=relaxed/simple;
	bh=qcD7WlVdPavbczBs83iYYaTqVTBuiEdhulH5KGIUSYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K5v0btNsd1iA+U9eRzafD1zxzy5QQfdVYyh86nuaBBXvynkxy6HAHORI+XufsElHcDTrwN9K+pFSWVyMp3NxvpZ8KAGtKDyKltOZ9xMXeFjfYMtjS1ncUNdaqXxxdTj0At7gsJAgdlJPoqzCMDK702QSEZ53TzYrnRKZ9XuSZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=JHouU2jy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=o3jbkg05; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="JHouU2jy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="o3jbkg05"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=JHouU2jyvD5fk7HiVeo9s04ZhrTcE3jiURLuRLEo/r1U3v+EtQKL3Fspb9oB0DuFAPUQSnSAaif1mCcbhmDedafm4iLGAawdzwsa5Ox7InNW2V08AnbH7QVT8lF8iYljUGcNsERCAG8TTd4kW9BC/+QA5NIcxh79FhnHB+jq8GL9ekGDSVtMde2CBiZIfg3TKHXmPBjBdhJt+ACGUvIhkP+s0Aw5MjHJyddcGdjr4r7NaeaAhqRu4RJG9mMoce+MxiEU1Y6Hv1EkwYzIKrXXz1+IXcGfrQX8auCXk60opuKFxs4uPbJcE7zjR1QEqrwF+DIKnbNj3MOeMdzeFWPuhA==; s=purelymail2; d=rcpassos.me; v=1; bh=qcD7WlVdPavbczBs83iYYaTqVTBuiEdhulH5KGIUSYc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=o3jbkg05YmCLQRfIaQypPBxbBOweK2/NAM8M6V1jZUQgFG2NPSSdDrg2lAa+uxV82mqdJc9gAH4z6QDGdYuLG4WLLg3QxWaicbbBTGeq/Qs/cb/2mg0cjXWyYxL4jc8XJ/t9WG/oUZfSByWjr6+rq9rOi2dNbxwlcRA1kBjMlI5emEchfQDKVKLxYAK8dCtWS3hzNNcTXdR07bB58MEU6M2PGh5HRb6uKNyPsFWN0/K2RVwuX6616U5s0qK9bTNQ2L2KWGa0/DXiWJVZmjk89jF5/cFb4Npx+sXj27VL2YbxKXkGHntuDEaW4QzuXCC9Yu8ZMY6TKbRDaI1ZdwesgQ==; s=purelymail2; d=purelymail.com; v=1; bh=qcD7WlVdPavbczBs83iYYaTqVTBuiEdhulH5KGIUSYc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 471802508;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 21:25:29 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: bentiss@kernel.org,
	david@readahead.eu,
	jikos@kernel.org
Cc: jkoolstra@xs4all.nl,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 0/4] HID: wiimote: new LED behavior on connect, scoped guards, uaf
Date: Wed, 15 Jul 2026 18:24:52 -0300
Message-ID: <20260715212501.3920033-1-rafael@rcpassos.me>
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
This patchset contains one feature change, and two cleanup patches.

The feature is turning different LEDs for each of the first 4 wiimotes conn=
ected.
From id 5 forward, the LED will cycle back to 1, and so on.
This uses the ida struct, so its quite simple and lightweight.
The hid_info log message prints out the controller id.

While implementing this feature, I decided to cleanup the code using
scoped_guard for the many spinlocks in the driver. There are two places
where the original lock/unlock version fits best, and I left them
untouched.
Lastly, I used the __free scope cleanup in the wiimote and LED probe functi=
ons.
The LED is trivial. The wiimote_probe required a new state tracker bitmask.

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
      (I will also send in response to this patch, what I used to test it).
    (4/4) *new patch* :
    - sashiko found a pre-existing uaf. Unlikely, but correct.
      implemented using the playstation driver as an inspiration


Rafael Passos (4):
  HID: wiimote: turn on the LEDs indicating the controller id
  HID: wiimote: replace spinlock pairs with scoped_guard
  HID: wiimote: use scoped cleanup in wiimote and led probes
  HID: wiimote: fix uaf when hid events are handled during destroy

 drivers/hid/hid-wiimote-core.c    | 335 ++++++++++++++++--------------
 drivers/hid/hid-wiimote-debug.c   |  50 ++---
 drivers/hid/hid-wiimote-modules.c |  24 +--
 drivers/hid/hid-wiimote.h         |   2 +
 4 files changed, 215 insertions(+), 196 deletions(-)

--=20
2.53.0

