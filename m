Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3E3E5EC2;
	Mon,  2 Mar 2026 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484609; cv=none; b=F2GhC/WJljmIczk//ekqoNDKLsRC/JH4jmpWCKxa68l0xZGa8T7vbJiXoRX/Hn56QmZlGbOOEajJUVVpU861BqI3At/FbT9S9HbLDHs/iEyo5eIgylRDDYHuBuvzG+AuX42Uh+Su2FmlU0Lr3UtfTTk3GFIHynQy2PSIQ1oi/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484609; c=relaxed/simple;
	bh=MhqQJ5x1m0sP7q9+6zLhiLmjDnpZ0Bt8sIUQOAehS2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+cpU+eDLnBQR721+XiA9tEVnrzEGNGPgL4j3mmJWKN119g+d4azYNun4YgV2emGTIMl7+Q0pRdHMOlZ7A7X2uHbTKFfl2kt/M2TvkwoPdOK9ZRbbo3ZGbJJmqusw7Bp/QWvSb/r4xg5al3j4FGwyc9Rlrc2PyGJkyqcgQWyo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buWYSs1f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buWYSs1f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D0C19423;
	Mon,  2 Mar 2026 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484608;
	bh=MhqQJ5x1m0sP7q9+6zLhiLmjDnpZ0Bt8sIUQOAehS2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=buWYSs1fvqlwI0Thv4yXHp5RtR8dRAz4nCDXfBc93uSM65NfkPRyDWKiN7vdx6D4s
	 4vGe2zC/lCOtI/GYKWe2t3lVn/zmw7+8OXErOTFkDWD3jCDBi1PUQ6k2VqqOXs62Jc
	 w/x4FfN1sGmKMBHDEvYeCZ1bb0z3c7dtMIC+Qt11zPFwSrNVL34fasP1j7xcZq95tx
	 GXJHYrC9LfRSWoajvAVqYEBXXNoKFuKbkcsbmDO4EBaQuxZKHaFOk5ymgXLjo4r8CF
	 jb1UOiPEACYu6I9foRXNniOS/RzZf7rqU0hTAnekTZ7UK3mXCI1jCn7qwHYKrYjhhO
	 FdOV3am3LH4Tw==
Date: Mon, 2 Mar 2026 20:49:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang
 <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: buffer: fix timestamp alignment when
 quaternion in scan
Message-ID: <20260302204958.246ce312@jic23-huawei>
In-Reply-To: <a7078fba-af96-4d77-8b10-35a31cb364ac@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
	<20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
	<f481f4ae4d9545bbb186e51a1204ca2d65b74a26.camel@gmail.com>
	<a7078fba-af96-4d77-8b10-35a31cb364ac@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2026 09:42:03 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/2/26 6:04 AM, Nuno S=C3=A1 wrote:
> > On Sun, 2026-03-01 at 14:24 -0600, David Lechner wrote: =20
> >> Fix timestamp alignment when a scan buffer contains an element larger
> >> than sizeof(int64_t). Currently s32 quaternions are the only such
> >> element, and the one driver that has this (hid-sensor-rotation) has a
> >> workaround in place already so this change does not affect it.
> >>
> >> Previously, we assumed that the timestamp would always be 8-byte align=
ed
> >> relative to the end of the scan buffer, but in the case of a scan buff=
er
> >> a 16-byte quaternion vector, scan_bytes =3D=3D 32, but the timestamp n=
eeds
> >> to be placed at offset 16, not 24.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>
> >> To test this, I used hid-sensor-rotation minus the first patch in the
> >> series so that we can see that the timestamp actually moved to the
> >> correct location.
> >>
> >> Before this patch, the timestamp (8 bytes ending with "98 18") is in t=
he
> >> wrong location.
> >>
> >> 00000000=C2=A0 6a 18 00 00 ac f3 ff ff=C2=A0 83 2d 00 00 02 d3 ff ff=
=C2=A0 |j........-......|
> >> 00000010=C2=A0 00 00 00 00 00 00 00 00=C2=A0 5a 17 a0 2a 73 cb 98 18=
=C2=A0 |........Z..*s...|
> >>
> >> 00000020=C2=A0 ad 17 00 00 6a f4 ff ff=C2=A0 35 2b 00 00 ca d0 ff ff=
=C2=A0 |....j...5+......|
> >> 00000030=C2=A0 00 00 00 00 00 00 00 00=C2=A0 2a a6 bb 30 73 cb 98 18=
=C2=A0 |........*..0s...|
> >>
> >> 00000040=C2=A0 92 1e 00 00 50 ec ff ff=C2=A0 ea c1 ff ff 78 f0 ff ff=
=C2=A0 |....P.......x...|
> >> 00000050=C2=A0 00 00 00 00 00 00 00 00=C2=A0 8f 3b a7 39 77 cb 98 18=
=C2=A0 |.........;.9w...|
> >>
> >> After this patch, timestamp is now in the correct location.
> >>
> >> 00000000=C2=A0 55 0f 00 00 dd 1f 00 00=C2=A0 af 0b 00 00 ec 3e 00 00=
=C2=A0 |U............>..|
> >> 00000010=C2=A0 c7 17 68 42 6d d0 98 18=C2=A0 00 00 00 00 00 00 00 00=
=C2=A0 |..hBm...........|
> >>
> >> 00000020=C2=A0 57 0e 00 00 c8 1f 00 00=C2=A0 d1 0e 00 00 42 3e 00 00=
=C2=A0 |W...........B>..|
> >> 00000030=C2=A0 56 a2 87 48 6d d0 98 18=C2=A0 00 00 00 00 00 00 00 00=
=C2=A0 |V..Hm...........|
> >>
> >> 00000040=C2=A0 a3 e2 ff ff d3 1b 00 00=C2=A0 0b c9 ff ff cc 20 00 00=
=C2=A0 |............. ..|
> >> 00000050=C2=A0 27 59 4d b3 72 d0 98 18=C2=A0 00 00 00 00 00 00 00 00=
=C2=A0 |'YM.r...........|
> >>
> >> I also tested this with a different driver not affected by this bug to
> >> make sure that the timestamp is still in the correct location for all
> >> other drivers.
> >> ---
> >> =C2=A0include/linux/iio/buffer.h | 12 ++++++++++--
> >> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> >> index d37f82678f71..ac19b39bdbe4 100644
> >> --- a/include/linux/iio/buffer.h
> >> +++ b/include/linux/iio/buffer.h
> >> @@ -34,8 +34,16 @@ static inline int iio_push_to_buffers_with_timestam=
p(struct iio_dev *indio_dev,
> >> =C2=A0	void *data, int64_t timestamp)
> >> =C2=A0{
> >> =C2=A0	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
> >> -		size_t ts_offset =3D indio_dev->scan_bytes / sizeof(int64_t) - 1;
> >> -		((int64_t *)data)[ts_offset] =3D timestamp;
> >> +		size_t ts_offset =3D indio_dev->scan_bytes -
> >> +			ACCESS_PRIVATE(indio_dev, largest_scan_element_size); =20
> >=20
> > Given that we're adding a new private member, maybe we could just direc=
tly cache the ts_offset
> > in iio_compute_scan_bytes()? Would make the code a bit easier to follow=
 IMHO
> >=20
> > - Nuno S=C3=A1 =20
> >> =20
>=20
> Clever. :-)
Ah. I should have read on!

J
