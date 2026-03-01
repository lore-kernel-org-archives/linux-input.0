Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A42C3261;
	Sun,  1 Mar 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772356770; cv=none; b=PuvxrLOAntlMfM7QzRYYnBy5znZvmiu5p/2t23iz3DKcXH7bCssgsTwFfTFophfFsP3i/hI+lboep6VQowCHR6mCFgluIB+nDbTrsF14yQAKbggFMf4dh2r+1oqDmElT1IvPhI4p9Uw7/4N9av6iRMzJqCktdA85AJcV/5mDBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772356770; c=relaxed/simple;
	bh=L2SdQH8ywpK/e6o+yBg3PENhr+Mc69+1QMFSMkGaQJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDQrWr/pe1tObZu3nO01aDHZlQDs3Vdlb/RqBBWU3mB6wRHAZvhX548lSCCS7VFFomPFUxVFNcYcv+SaRdlQf7ntISo/tizqLXHSyykuj5HO8AfgaKGNb8Pkdo2oQwsGh1OyUh/8sXpHUsU1KT555tB3QXo2r1AegpDxzZrbFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65B894316C;
	Sun,  1 Mar 2026 09:19:19 +0000 (UTC)
Message-ID: <ee5fc583c7d6dad138db759cddd84e409190d1ae.camel@hadess.net>
Subject: Re: [PATCH v2] Bluetooth: HIDP: cap report descriptor size in HID
 setup
From: Bastien Nocera <hadess@hadess.net>
To: Eric-Terminal <ericterminal@gmail.com>, marcel@holtmann.org, 
	johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Date: Sun, 01 Mar 2026 10:19:19 +0100
In-Reply-To: <20260228172657.53040-1-ericterminal@gmail.com>
References: 
	<CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
	 <20260228172657.53040-1-ericterminal@gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeggeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepieehueekleegfeduieevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepjedprhgtphhtthhopegvrhhitghtvghrmhhinhgrlhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrn
 hhnrdhorhhgpdhrtghpthhtohepjhhohhgrnhhhvggusggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Sun, 2026-03-01 at 01:26 +0800, Eric-Terminal wrote:
> From: Yufan Chen <ericterminal@gmail.com>
>=20
> hidp_setup_hid() duplicates the report descriptor from userspace
> based on
> req->rd_size. Large values can trigger oversized copies.
>=20
> Do not reject the connection when rd_size exceeds
> HID_MAX_DESCRIPTOR_SIZE. Instead, cap rd_size in hidp_setup_hid()
> and use the capped value for memdup_user() and session->rd_size.
>=20
> This keeps compatibility with existing userspace behavior while
> bounding memory usage in the HID setup path.

Cross-sending this to linux-input@ for review, they would know the best
way to deal with oversized HID descriptors.

>=20
> Signed-off-by: Yufan Chen <ericterminal@gmail.com>
> ---
> =C2=A0net/bluetooth/hidp/core.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 6fe815241..31aeffa39 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -755,13 +755,16 @@ static int hidp_setup_hid(struct hidp_session
> *session,
> =C2=A0				const struct hidp_connadd_req *req)
> =C2=A0{
> =C2=A0	struct hid_device *hid;
> +	unsigned int rd_size;
> =C2=A0	int err;
> =C2=A0
> -	session->rd_data =3D memdup_user(req->rd_data, req->rd_size);
> +	rd_size =3D min_t(unsigned int, req->rd_size,
> HID_MAX_DESCRIPTOR_SIZE);
> +
> +	session->rd_data =3D memdup_user(req->rd_data, rd_size);
> =C2=A0	if (IS_ERR(session->rd_data))
> =C2=A0		return PTR_ERR(session->rd_data);
> =C2=A0
> -	session->rd_size =3D req->rd_size;
> +	session->rd_size =3D rd_size;
> =C2=A0
> =C2=A0	hid =3D hid_allocate_device();
> =C2=A0	if (IS_ERR(hid)) {
