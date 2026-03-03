Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5307382291;
	Tue,  3 Mar 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535519; cv=none; b=iYfzx8i7+yKHtw2lh8MhXgTjhV3kuLY8dv1Bq5vS2UYpg0KyXQ4GV2pGd9IIQGRJUMvqDbmhVVOccHTJZCcz2h7yJsEIjl8O+PUBfrHMob0VF6HaMXbmjbCmhuGPkM8wS1lA7UVnugje7eqC29gkmL6QE5lNKHTyIzpuuIJ6r2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535519; c=relaxed/simple;
	bh=7TkAJKJpK9MK4kmpmJuLjrdBNybeGzJdW/mJzGVBJGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxtJM27rv1NszuEt5MJ4fiiuY2Z7o1q2huEkuhTRrRI578QXJvJCh+1AT68SMm5VjsksINYHhSG1wDC3a2GPX+HU9gq1+JGuAW1Rv2+sb7dCnpPQEd9YZzBoKjHsGsnFgzVbk9clTdDjohZhiyfWYY7faHZJVWjwBl/r3mtBbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B5F23E9CF;
	Tue,  3 Mar 2026 10:58:27 +0000 (UTC)
Message-ID: <9cd6f871ea6d8f4a802936fee8193c5a5f291064.camel@hadess.net>
Subject: Re: [PATCH v3 03/18] HID: quirks: Add additional Arctis headset
 device IDs
From: Bastien Nocera <hadess@hadess.net>
To: Sriman Achanta <srimanachanta@gmail.com>, Jiri Kosina
 <jikos@kernel.org>,  Benjamin Tissoires	 <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wood
	 <simon@mungewell.org>, Christian Mayer <git@mayer-bgk.de>
Date: Tue, 03 Mar 2026 11:58:26 +0100
In-Reply-To: <20260227235042.410062-4-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
	 <20260227235042.410062-4-srimanachanta@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepjeeuhefhvdefgfelvefhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrhhimhgrnhgrtghhrghnthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsihhmohhnsehmuhhnghgvfigvlhhlrdhorhhg
X-GND-State: clean

On Fri, 2026-02-27 at 18:50 -0500, Sriman Achanta wrote:
> Add support for additional SteelSeries Arctis headset models to the
> HID
> quirks table. This enables proper device recognition and handling
> for:
> - Arctis 7 series (7, 7P, 7X, 7 Gen2)
> - Arctis 7 Plus series (7 Plus, 7 Plus P, 7 Plus X, 7 Plus Destiny)
> - Arctis Pro
> - Arctis Nova 3 series (3, 3P, 3X)
> - Arctis Nova 5 series (5, 5X)
> - Arctis Nova 7 series (7, 7X, 7P, 7X Rev2, 7 Diablo, 7 WoW, 7 Gen2,
> 7X
> =C2=A0 Gen2)
> - Arctis Nova Pro series (Pro, Pro X)

This seems premature, when that code is introduced, the headsets are
not supported yet.

Those definitions should be added as support for the devices is
introduced as one would expect intermediate commits in a patchset to
still be functional.

>=20
> Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
> ---
> =C2=A0drivers/hid/hid-quirks.c | 26 ++++++++++++++++++++++++++
> =C2=A01 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 17349eac5c3e..65a6f6ab30b9 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -714,7 +714,33 @@ static const struct hid_device_id
> hid_have_special_driver[] =3D {
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_SRWS1) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_1) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_P) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_GEN2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_P) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_DESTINY) },
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_P) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_3) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
> USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO_X) },
> =C2=A0#endif
> =C2=A0#if IS_ENABLED(CONFIG_HID_SUNPLUS)
> =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS,
> USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
