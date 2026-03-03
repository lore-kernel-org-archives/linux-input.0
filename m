Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD873D2FFC;
	Tue,  3 Mar 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535552; cv=none; b=I6pcD83XmaCkBnwObsRFeopkcb5VgGRRLmIK2Y6YR18y0VmxmpoPbRsS9QBoM4JYxqo98Zy64R0+MbI32TrKBr0HRXaKIryUVY2gnOR9te5bgkqxb0EPcmaNQldmTXZuO4t2+ws4/LxFRzsxiU3xR6EgNuKU+dOoVYGZ+hbYrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535552; c=relaxed/simple;
	bh=z1FXeazYYbtRQJUSiMAejVpbRB7EQD8GCuk5IflKPk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qq4jfvxaMhQgp1c84f4s6HGEsmeHpcQDfn/Icdvz7XYBbW4Yt5nWYixfuCL6AlTa0qqogLUr26BYYdy0SSw55PEx64C+CGFz3esm4XSjwF4mDQPe+536BIdkGPgdaBiJHRpOxJ473vCVEbdS1DSP8IzfiM8wzoMZ4mK/x5ugrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42F62432F2;
	Tue,  3 Mar 2026 10:59:07 +0000 (UTC)
Message-ID: <b2e27cf3743fd703d3c5aa6b325d3729003af542.camel@hadess.net>
Subject: Re: [PATCH v3 00/18] HID: steelseries: Add support for Arctis
 headset lineup
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:59:06 +0100
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgedvhfeivdegfedvhfdvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean

Hey Sriman,

Great work splitting up your original code. I'm afraid that I see some
of the patches as still needing more splitting up to be easily
reviewable, especially "HID: steelseries: Add async support and unify
device definitions".

The code looks good to me from a cursory glance, though we probably
want to get more eyeballs on the sound code.

I won't have time to test this patchset on real hardware for a little
while, but I'll test this version or any updates if there are any when
I have time.

I also don't know what out subsystem maintainers think, but, if you
have the patience, this might be the opportunity to split off the
headset support from the completely unrelated force feedback steering
wheel driver. I'm not going to block your patchset on this but
something to consider for the future.

Cheers

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> This patch series adds comprehensive support for the SteelSeries
> Arctis
> wireless gaming headset lineup to the hid-steelseries driver.
>=20
> The current driver provides only basic battery monitoring for Arctis
> 1
> and Arctis 9. This series extends support to 25+ Arctis models with
> full feature control including sidetone, auto-sleep, microphone
> controls, volume limiting, and Bluetooth settings.
>=20
> The driver restructure uses a capability-based device info system to
> cleanly handle the varying feature sets across different Arctis
> generations while maintaining support for the legacy SRW-S1 racing
> wheel.
>=20
> The driver also sets up future support for async device control which
> is currently implemented for the Arctis Nova 7 Gen 2 and Post-January
> update
> Gen 1 devices as implemented.
>=20
> Tested on Arctis Nova 7 (0x2202) and Arctis Nova 7 (0x22a1). All
> other
> implementation details are based on the reverse engineering done in
> the
> HeadsetControl library (902e9bc).
>=20
> Changes since v2:
> * Expose audio related controls via ALSA mixers
> * Implement async inputs from supported devices with known protocols
> * Overall code cleanup and improvements to initalization logic
> * Fixed several logical and protocol issues for Arctis 7 and 9
>=20
> Sriman Achanta (18):
> =C2=A0 HID: steelseries: Fix ARCTIS_1_X device mislabeling
> =C2=A0 HID: hid-ids: Add SteelSeries Arctis headset device IDs
> =C2=A0 HID: quirks: Add additional Arctis headset device IDs
> =C2=A0 HID: steelseries: Add async support and unify device definitions
> =C2=A0 HID: steelseries: Update Kconfig help text for expanded headset
> =C2=A0=C2=A0=C2=A0 support
> =C2=A0 HID: steelseries: Add ALSA sound card infrastructure
> =C2=A0 HID: steelseries: Add ChatMix ALSA mixer controls
> =C2=A0 HID: steelseries: Add mic mute ALSA mixer control
> =C2=A0 HID: steelseries: Add Bluetooth state sysfs attributes
> =C2=A0 HID: steelseries: Add settings poll infrastructure
> =C2=A0 HID: steelseries: Add sidetone ALSA mixer control
> =C2=A0 HID: steelseries: Add mic volume ALSA mixer control
> =C2=A0 HID: steelseries: Add volume limiter ALSA mixer control
> =C2=A0 HID: steelseries: Add Bluetooth call audio ducking control
> =C2=A0 HID: steelseries: Add inactive time sysfs attribute
> =C2=A0 HID: steelseries: Add Bluetooth auto-enable sysfs attribute
> =C2=A0 HID: steelseries: Add mic mute LED brightness control
> =C2=A0 HID: steelseries: Document sysfs ABI
>=20
> =C2=A0.../ABI/testing/sysfs-driver-hid-steelseries=C2=A0 |=C2=A0=C2=A0 87=
 +
> =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +-
> =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 35 +-
> =C2=A0drivers/hid/hid-quirks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 27 +
> =C2=A0drivers/hid/hid-steelseries.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2329 +++++++=
+++++++-
> --
> =C2=A05 files changed, 2184 insertions(+), 299 deletions(-)
> =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-
> steelseries
