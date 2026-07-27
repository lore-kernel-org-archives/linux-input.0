Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF73E8695;
	Mon, 27 Jul 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157056; cv=none; b=WdGBlFqXxFS2uTStwbc54gIrXYHbGLRuTrVwuJgJv9JQTj0dFSebcExC7gWuLgMlK9YPvAETFizg4YlBde5PyRN7FuKF8XpMo5VHxN1hFz0bNSaeyqs4apez8+7NPoF6heALk2g1T1E8ciVeYWAwD4dHQJNRkAWvApX8R6H03XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157056; c=relaxed/simple;
	bh=6Rij7ScHHcHlQFrcoRc4JRj1kJGB4MbagbYGGpcL9lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDOQzVZZdec1IGDI2GiEQXL7ykYvWgp23aPVEvhb9l6GeeEmQIwD+MtLHFGWy0JcTrHymaKTzbkIyab8xMlLXhzKPlsYeSTAeqwRdRY0WhmzCR/a//FJAYVPG2Abo2cnYdNX56bSAM8lAx5ill2DnjcedazUJwZ2ZMKnWiqO3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC8403EC21;
	Mon, 27 Jul 2026 12:57:31 +0000 (UTC)
Message-ID: <d1523afcbf13e612ce38809f43299bae8c3b8910.camel@hadess.net>
Subject: Re: [PATCH v6 0/9] HID: steelseries: split out Arctis driver and
 add Nova 5X/Nova 7 support
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Mon, 27 Jul 2026 14:57:31 +0200
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
X-GND-Cause: dmFkZTFwFcnIaDv4UjnZcSFOkR6zIYBWDXd7Ud/psZ7xNY8Ge2dbXCN7XbQT7ZEiyFbqDKLzmaXwtFUWOcxwP+dc30IOVy0UpczeAEsxeaQcYWdAEtT9izkV9Z6LQSweSRC0eIk8n0Twhwr3UcoKRCSOm4gNwrRFm2vzcjTSGYPnZ8o4xy5tXKzg46X6sBYIj3Rhgh57YqMfR/Ke9BQc9P3Y8lvnS1KwOPiq/W9Qzbi4to1xTB8l66hHHxv54aBoY81emtBlAxHeukMBXfPpfhCMc4nnUMNvmBdWb2QzNm9l1V9jl9Tyh2sylK+mqFiDxc2e03HK1qLRs2AsEJoBqQyQPn+/FnlSGS56hDMJ8ugRxSmamusFg6+nxn1st5NtL/OcXzFOAy4wPWh2s48tVUii0L6hWea0vvoqai6kZMy8RgjEiE0Zvxk/xKsbzblMbvB20Q1u/PltHijfDy761q+jWceIz6VxoU/pVeTbYrCcnoK2ztS5OLVZFmgsFfCbHfj1F9XIpRiJlmgww4igZNd0PlDQ7e18ODI7vA8m3+AlMEpsrySsVUB0AqgIb/WBCkO02O1iiFrdSaHGY//j3zgc1/+Ui+gkPL1Hym1ORAYE+KWQaoMsiqv1hgAVz40nnkJDpGdbpj4N0m0tZdyualEdegHM8q7uVuxiyIPhjIoczlLX1Q
X-GND-State: clean

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

Tested locally, and reviewed all the patches, looks good to me, thanks
for the work Sriman!

Reviewed-by: Bastien Nocera <hadess@hadess.net>

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
