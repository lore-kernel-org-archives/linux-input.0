Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F964229BE;
	Fri, 10 Jul 2026 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684943; cv=none; b=iFNflLIHeACBAKZdIyvQYOfDN2VhntjtrRPLzq7lgqpI+MBkQ025X+s2eltQt+wT32eSmILcRFeuVGNZPfs6VQRrM5Z8muBEUBDQehE+xr13Yr8oeFfk4hBNIgMoyxIgz2bDFt6KCI4IVtNxgvd58zgDcm3bGzDTSyXYnVfyQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684943; c=relaxed/simple;
	bh=p3dH5FUCwKwqoTk90XQba0ccsS3TVTfYFaP/tLrpaNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4OpFebYm6f8mwBMo1kUPRndTrE7ALGXzsxS8usXdz/cu2JGYXY+BbXrtdBoPm9w9y8H+Nk3amXFAiOvm3ducbvAPIShr64YSk7cs4X/Rv/PG0K8M1nWlFn4FODAjZn6fDUTY+489/bkPjokTaYhf2DMNsNd4UILTCIuiXBURYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80EF43EC1E;
	Fri, 10 Jul 2026 12:02:08 +0000 (UTC)
Message-ID: <d77b5dc879741958390232cd1a5d04718d33d9d0.camel@hadess.net>
Subject: Re: [PATCH v6 0/9] HID: steelseries: split out Arctis driver and
 add Nova 5X/Nova 7 support
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Fri, 10 Jul 2026 14:02:08 +0200
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: 
	<20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTEyRRH4U592fspNgerfbN9QnX8z/TiKhWrBV89d7q85+StTtyGY51lQdNCUU3pik8ZR0UE0kCQSPOsnTolL+R13LattITEztSZ94AAAbW3abNHUaUO9YA48cnGqOVaXE/Ju4YCzz2eNby7r9hWE6ZxSejWo8jPw4wDsx6WCi5TfD5Vk3HzpXyJTO54EVIN8+RqzQxcb9IcPhBIkMfuCoMOm3t2sfWP45EyZVh9+kwmzNxDO04aoAUuqLHYJEazVI9jXsHnZXDCIM8Ipskqq8zTVt7mjSrYduKva4gWPAOnhVnCRQ619AfULglI5+h7b34d56LMxKAYrGZGP/jtIjEUIilhIebWYvf+4eOBTZsFmg/AIOk0HcuVfIcUq8mwgE31V6ridYUdxsVtRxLX9KBvV0Y7viI/kwJeGxuFPGt0985GQ9QpTlQzAFyRIt7sHpYHkdDffF8n7ctXchqievOc3V7NYbt5OTXtyYIhsZNlD90IkLZ+w9kTnoVMoF+WspyeB2n+eXHV1PvQDKHnKKanCor7iTZhby/q4CoUsbyIa+KjYsnIVB9dg7NTciQGPK2qg1exOiKlJP1dTsR80FQTLxtf5Tzyj6VINSB/bmMKGfi7AMBzehVlN8gpVlceewybI4C/wiK1ukwh/zKDoezrU2g6v4k19H0NkweIqiZpttA
X-GND-State: clean

Hey Sriman,

I won't have time to review the patchset this week, but I've created a
test kernel for Fedora 44 users, which should stay available for about
a week (IIRC).

https://koji.fedoraproject.org/koji/taskinfo?taskID=3D147618251

I'll try to send my review next week.

Regards

On Wed, 2026-07-08 at 23:23 -0400, Sriman Achanta wrote:
> From: Sriman Achanta <srimanachanta@gmail.com>
>=20
> This series moves the SteelSeries Arctis headset support out of
> hid-steelseries.c into its own module, reworks it around a per-model
> device_info table, hardens the battery power-supply lifetime, adds an
> asynchronous status interface, and finally adds support for the
> Arctis
> Nova 5X and Nova 7 families. After the split, hid-steelseries.c is
> left
> handling only the SRW-S1 racing wheel.
>=20
> Changes since v5:
> =C2=A0- Nova: rename the Gen2-only parse function and device_info to
> =C2=A0=C2=A0 steelseries_arctis_nova_{parse_status,info} now that they ar=
e also
> =C2=A0=C2=A0 used by the Nova 5X and the 2026 refresh, not just Gen2.
> =C2=A0- Nova: add device IDs and a device_info for the original (pre-Gen2=
)
> =C2=A0=C2=A0 Arctis Nova 7 family. It answers the same 0xb0/0xb7/0xb9/0xb=
b
> status
> =C2=A0=C2=A0 opcodes on the same interfaces as Gen2, but reports battery
> capacity
> =C2=A0=C2=A0 as a discrete 0-4 level rather than a raw percentage, so it =
gets
> its
> =C2=A0=C2=A0 own parse function that maps the level through
> =C2=A0=C2=A0 steelseries_map_capacity() instead of using it directly.
> =C2=A0- Nova: add the Arctis Nova 5X, which shares the Gen2/2026 protocol=
.
> =C2=A0- hid-ids.h: fix a whitespace-only bug where the new Nova 5X macro
> was
> =C2=A0=C2=A0 space-aligned instead of tab-aligned.
> =C2=A0- Rebased on current master.
>=20
> The Nova 5X protocol was verified against hardware by
> sp4m.an.joker@gmail.com, and the original Nova 7 protocol was
> verified
> against hardware by colin@1101b.com. Thanks to both for testing. I
> previously ommited other devices in the v4 patch series due to being
> unable to verify.
>=20
> Sriman Achanta (9):
> =C2=A0 HID: steelseries: Fix ARCTIS_1_X device mislabeling
> =C2=A0 HID: steelseries: Split Arctis headset driver into separate module
> =C2=A0 HID: steelseries: Inline and simplify SRWS1 wheel driver
> =C2=A0 HID: steelseries: Refactor Arctis driver to use device_info
> framework
> =C2=A0 HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
> =C2=A0 HID: steelseries: Correct Arctis 9 battery calibration range
> =C2=A0 HID: steelseries: Manage battery lifetime with refcounting
> =C2=A0 HID: steelseries: Add async status interface support
> =C2=A0 HID: steelseries: Add support for Arctis Nova 5X and Nova 7
> families
>=20
> =C2=A0drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +-
> =C2=A0drivers/hid/hid-quirks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +-
> =C2=A0drivers/hid/hid-steelseries-arctis.c | 718
> +++++++++++++++++++++++++++
> =C2=A0drivers/hid/hid-steelseries.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 406 +--------------
> =C2=A05 files changed, 759 insertions(+), 401 deletions(-)
> =C2=A0create mode 100644 drivers/hid/hid-steelseries-arctis.c
>=20
>=20
> base-commit: 7404ce51637231382873d0b55edabc2f3b841a9d
