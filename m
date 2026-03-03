Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA33D6673;
	Tue,  3 Mar 2026 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535544; cv=none; b=qBscTZxge/hg7WM/h4EYy/wFoQOpOWrxn8tvkMC8JOmx5alOSNxYeFVSczALPJyhhXdMeTa6BPMNTeoFhWDfJkWF4tdARS1nTDiXtMhEVVX/975BMtlLr9+72MpwKZCt+3/MYSGx37Gujx7nsBE4/sEL40zQyuB0je4iU35QWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535544; c=relaxed/simple;
	bh=Duq04GA/L2SghYYbRS8Wa12ZQS2f2lVtk4iJwEllyaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrsZFLt8azu0K+wRyFIV/o95tlH+30HxFcfqgfIew3xEx8quK9ZNyJKXNPhHFZgnlJUYk6Zru95EGK/4+TO+aVUGH38uNTUj5QSuekmlZLUh/GdzswB44YfA/waj5VjPvvU6Filj85GlugSYx7mM8fgPKunTX4ea2BsBDOIMzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6ED14391F;
	Tue,  3 Mar 2026 10:58:58 +0000 (UTC)
Message-ID: <0e5804e810fb4966883f95246c438f8eac3dd43f.camel@hadess.net>
Subject: Re: [PATCH v3 18/18] HID: steelseries: Document sysfs ABI
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:58:58 +0100
In-Reply-To: <20260227235042.410062-19-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-19-srimanachanta@gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepffeigfffudegfeeludfhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Add Documentation/ABI/testing/sysfs-driver-hid-steelseries
> documenting
> the sysfs attributes and LED class device exposed by the driver:
>=20
> - bt_enabled, bt_device_connected: read-only Bluetooth radio state
> - inactive_time: read/write auto-shutoff timer in minutes
> - bt_auto_enable: read/write Bluetooth radio power-on behavior
> - <dev>::micmute/brightness: mic mute LED brightness via LED class

This should probably be documented in the commit that introduces the
new attribute, rather than all of them being updated at once.

>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0.../ABI/testing/sysfs-driver-hid-steelseries=C2=A0 | 87
> +++++++++++++++++++
> =C2=A01 file changed, 87 insertions(+)
> =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-
> steelseries
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-steelseries
> b/Documentation/ABI/testing/sysfs-driver-hid-steelseries
> new file mode 100644
> index 000000000000..7b8d29282ed6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-steelseries
> @@ -0,0 +1,87 @@
> +What:		/sys/bus/hid/drivers/steelseries/<dev>/bt_enabled
> +Date:		February 2026
> +KernelVersion:	6.20
> +Contact:	Sriman Achanta <srimanachanta@gmail.com>
> +Description:	(RO) Whether the Bluetooth radio on the headset is
> currently
> +		enabled.
> +
> +		* 0 =3D Bluetooth radio off
> +		* 1 =3D Bluetooth radio on
> +
> +		Returns -ENODEV if the headset is not connected to
> the
> +		receiver.
> +
> +		Supported on: Arctis Nova 7 Gen2, Arctis Nova Pro
> Wireless
> +
> +What:		/sys/bus/hid/drivers/steelseries/<dev>/bt_device_con
> nected
> +Date:		February 2026
> +KernelVersion:	6.20
> +Contact:	Sriman Achanta <srimanachanta@gmail.com>
> +Description:	(RO) Whether a Bluetooth device is currently
> connected to
> +		the headset.
> +
> +		* 0 =3D no Bluetooth device connected
> +		* 1 =3D Bluetooth device connected
> +
> +		Returns -ENODEV if the headset is not connected to
> the
> +		receiver.
> +
> +		Supported on: Arctis Nova 7 Gen2, Arctis Nova Pro
> Wireless
> +
> +What:		/sys/bus/hid/drivers/steelseries/<dev>/inactive_time
> +Date:		February 2026
> +KernelVersion:	6.20
> +Contact:	Sriman Achanta <srimanachanta@gmail.com>
> +Description:	(RW) Auto-shutoff timer for the headset, in minutes.
> A
> +		value of 0 disables the timer. The maximum accepted
> value
> +		is device-specific.
> +
> +		The encoding sent to the firmware varies by device
> family:
> +		the Arctis 9 converts the value to seconds, the Nova
> 3P
> +		rounds down to its nearest supported discrete step,
> and the
> +		Nova Pro maps to six firmware-defined level indices.
> For all
> +		other devices the value is sent in minutes directly.
> +
> +		Reading the attribute returns the last value
> reported by the
> +		firmware. Writing immediately sends the new timeout
> to the
> +		device.
> +
> +		Returns -ENODEV if the headset is not connected to
> the
> +		receiver.
> +
> +		Supported on: Arctis 1 Wireless, Arctis 7, Arctis
> 7+,
> +		Arctis 9, Arctis Nova 3P, Arctis Nova 5, Arctis Nova
> 5X,
> +		Arctis Nova 7, Arctis Nova 7P, Arctis Nova 7 Gen2,
> +		Arctis Nova Pro Wireless
> +
> +What:		/sys/bus/hid/drivers/steelseries/<dev>/bt_auto_enabl
> e
> +Date:		February 2026
> +KernelVersion:	6.20
> +Contact:	Sriman Achanta <srimanachanta@gmail.com>
> +Description:	(RW) Whether the headset automatically enables its
> +		Bluetooth radio on power-on.
> +
> +		* 0 =3D Bluetooth radio stays off at power-on
> +		* 1 =3D Bluetooth radio activates automatically at
> power-on
> +
> +		Returns -ENODEV if the headset is not connected to
> the
> +		receiver.
> +
> +		Supported on: Arctis Nova 7, Arctis Nova 7P,
> +		Arctis Nova 7 Gen2
> +
> +What:		/sys/class/leds/<dev>::micmute/brightness
> +Date:		February 2026
> +KernelVersion:	6.20
> +Contact:	Sriman Achanta <srimanachanta@gmail.com>
> +Description:	(RW) Brightness of the microphone mute status LED.
> +		<dev> is the HID device node name (e.g.
> +		0003:1038:12AE.0001).
> +
> +		* 0 =3D off
> +		* 1 =3D low
> +		* 2 =3D medium
> +		* 3 =3D high
> +
> +		Supported on: Arctis Nova 5, Arctis Nova 5X, Arctis
> Nova 7,
> +		Arctis Nova 7P, Arctis Nova 7 Gen2
