Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D568346A04;
	Tue, 12 May 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597343; cv=none; b=DU7Ojq2KmmVYu5z9OmqGjHpmAuS9MXtkjsYZw/CZj6MX7Yf6aKHavRmq73KenD+CMgIncd3b8auKj8Na5iO+3l8SVzp4lMQ14kLb/588LOU0eFd8F6/7a37uHBk9mI20juk3FZIBSMirBlYlZg/uwY9ZlD1XMf6Y6whRNwhXtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597343; c=relaxed/simple;
	bh=HqMWsj5xhVtEVnrADxvN0x0WXP1ecXU7oSbUzyMJ87M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiKan9VzObWGWrv1rEV1ZdK2yK2GMRfxBbXq2uE8DaXZT4YKWdV3u82/aGQMuzxbV7f0vhlQXOJhDrPX1G7pjRY58NDxUL8qaaY/qzHpbN11x47IWuhlWLe1cvD6nEef8IGVgeUP0AUQyDLGvnVIuGLdJhcE95P+q5ryP7BAFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE/5yAkl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE/5yAkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB8BC2BCB0;
	Tue, 12 May 2026 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597342;
	bh=HqMWsj5xhVtEVnrADxvN0x0WXP1ecXU7oSbUzyMJ87M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iE/5yAkltDhxuPVUcng64WH8yyhDz/sAKT1fBdOmrvmx/LNih1u4QUqcrcynoolrE
	 p++udCnlcA6f4zjfUYcmxRL2FDmcUmMyiVjWIhnjRuLifc/vt+e/iSe+DfaEui1tqc
	 7TcW8imBKHR1GPvde3R4KbPdIL3t1u5OCBBQAZHdZPSmtV+n4mzG23M4CROqQR1GI4
	 uh1QF96qLu6Vm9BeF7ToPxLdrPvef9rckW+MAhRh9NP7V9I3SqMy/z4QY22xWV5NDJ
	 4A2zPkA05hApRvstKMLG6UN3XnwD6aooZ7idiR0EcTxKIIJ/iFlbcNHsji0YhGMYP3
	 HUc1m+9zMx2Rg==
Date: Tue, 12 May 2026 15:48:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jikos@kernel.org,
 nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Zhang, Lixu"
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Message-ID: <20260512154853.10aa2902@jic23-huawei>
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 22:16:16 -0300
Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br> wrote:

> This series refactors the HID sensor drivers to standardize the
> initialization of the iio_chan_spec scan_type structure.
> Direct initialization using compound literals was used.
>=20
> This change improves code readability and ensures that all fields
> of the scan_type structure are properly zero-initialized.
> Additionally, for the hid-sensor-accel-3d driver, the channel
> initialization loop was refactored to iterate directly over the
> scan indices, eliminating redundant logic.

Series looks good to me but I'll leave it on the list a while to
both let sashiko catch up and anyone else who wants to can have time
to look.  Also ideally get some testing.

Lixu, if you don't mind, please can you give this a test on top
of the more radical refactor patches?

To me it looks safe enough but this is the sort of series that subtle
typos can hide in!

Thanks,

Jonathan


>=20
> Nat=C3=A1lia Salvino Andr=C3=A9 (6):
>   iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
>   iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
>   iio: light: HID: hid-sensor-als: Refactor channel initialization
>   iio: light: HID: hid-sensor-prox: Refactor channel initialization
>   iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
>     initialization
>   iio: pressure: HID: hid-sensor-press: Refactor channel initialization
>=20
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 27 +++++++------------
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 24 +++++++----------
>  drivers/iio/light/hid-sensor-als.c            | 18 +++++--------
>  drivers/iio/light/hid-sensor-prox.c           | 19 +++++--------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
>  drivers/iio/pressure/hid-sensor-press.c       | 19 +++++--------
>  6 files changed, 42 insertions(+), 85 deletions(-)
>=20

