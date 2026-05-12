Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C735397338;
	Tue, 12 May 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596933; cv=none; b=M2x6I8J9c7vVzyBeXiE4+ulmhHegX2G/i7v+wyQrm4jz6O2Tr682rg/JW0uLAUhu7/rLkJk/8Ct9l/C/2hf9hjAt4lxQemCKQ+ewltJtk+WQSZRbzz0qIygm9pZwlJRHMDbofoduf2B7lKphWHPT4VHqzkD567M90lKXcj6z9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596933; c=relaxed/simple;
	bh=XhldWkwLybGtIRmwWQW/hSgfW/uayjDVD1tfLLqTL9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjGNVQvKAMdxbFgDnk53TiV2msxL3nMEuq5uI72gbQX45Z3PGRhZh6ZXJHRUCoy+H/z/mWTejEwudkDUiDvjudmNpBBgQiDXAv9p4J1jNtc0Hz8QYYaaeRR3lxOavYEao248dQR6OOHGutx8WMJCTXQ4c7zHlaEI1zxZH4jj5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKc96mLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKc96mLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB059C2BCB0;
	Tue, 12 May 2026 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596933;
	bh=XhldWkwLybGtIRmwWQW/hSgfW/uayjDVD1tfLLqTL9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKc96mLYrdKgvd6SkS0yFp4N/l0dvPFEtnA/6+9WFp4Cv+Nqqfd4ehiG1LMGGttCB
	 wMaDOZlfS3IChcs/YwY1FbBW79AklLGvv9G8qN+ep+vd+ijka0ctgr0FFPA1gLrghv
	 AlHwg0W4iKPyPohd8zjegRwcSlwtAsJbdkLvD0KkCeQJ6TBWucpthGLuY5+M6ovNzH
	 HazCfJ15qszNirY16xf5KNACY8b4jrOFQxj6+VsG5pev9IcD5bBD40D5+PLcknRAYC
	 AdfwWDsxD0cYXgy24/Mk+TwSuHyDf2SvW21RR2/K35dGZ7F2/XRL34hWi1yDRVrxX5
	 jZu6HAVAiKPXg==
Date: Tue, 12 May 2026 15:42:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jikos@kernel.org,
 nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Message-ID: <20260512154204.0052b352@jic23-huawei>
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
Hi Nat=C3=A1lia,

I'm a little confused.  How is this v3?  Where is the change log?

I'll review it as a fresh series.

thanks

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

