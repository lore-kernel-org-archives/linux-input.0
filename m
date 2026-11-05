Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907206;
	b=nfyceuWPE3tDYEb+l973tdQu4SiJQEGn/LfYM635GgkZlR0CYSxfDlFpz7z+zCmm+6f1
	 ijvXGwpCuIuM+cTodxRZ47BWntewiq1hIa4zrZ5e8jsKQ4hwlhm8dik0uc+lP8aBgplKg
	 hWAUwPzuC1ldsoGatgPvVu2u0Vkow611CpsTa2ma2f+f8SJOHWN5c2pfAsFCqvbp7aE9P
	 Xl1i4yCZqXiuaRRj1V2icaXyNfpG6Nl0XlunS5IarC65f0GqcfNkFMjOXVW+7sRNoxrck
	 RIfdF+gma5xZuYDL+6rViQH45nJQpFMlTKzAk1TzaBLGkEBMd/Qc0S2y50Fi4v2Xgpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EvpZI9955+r7YV1EdFMzZ38SK1XJK4ZYMuMFRS7yiFw=;
	b=e7Kv/MEW5btgpzsmOW81j7NEitOceqrAueNRUfm1vVO4LP8kLR6OQS56K5E+EXxUrVJn
	 5WgMi8NBDLJL+5FaNZqMS57vfgrcuJ8mSBcWR7XcfdRgl0fYdPJwS7VHIPPYwiEYhjjpw
	 Ok6w9b0C/Yu0/ynx2D9MWW/nJs+eaqsIaWPN76JDvH6Rh1kBAxGdiDUFmbNluCRKo4FWD
	 iNMM6fS3BAUJ1ntLyDoJ5p0Za+O2i06aBrDRhzzvVAGOAozlRLLxrADfRHVodJuk/3xD1
	 JnoYkMsI738+H3aYGavlRCKF+QoBBVRP3/cio7q4ag6sDD2U0wiDBCycK72L+2hdhVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QLR7H4/b";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCD606A31B;
	Thu,  5 Nov 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLR7H4/b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A671F000E0;
	Thu,  5 Nov 2026 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907205;
	bh=EvpZI9955+r7YV1EdFMzZ38SK1XJK4ZYMuMFRS7yiFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLR7H4/b0oyzzw1VMkjoG1BzPTBR1Nvo4tsZfh27suKMP+B+Av1WIZBOCBLylt+wA
	 5MxLeOYNuzO9rvJkK8T0l39m3tdmYeEkE0UF784D60Df5QwojGuln4C+dEoIIDMpDm
	 7GBM21V9rk6W9fVLT5eOGIf7zYFkQLRrMamzuzLzagbobTJFnS6hXKVdok0UEjY7xj
	 9jnTiBNuMraLHa7zcPRJNieSuPpQ7wkGGMEB4lENnZQ5CEV+DYIz7PIqe1QlIqISod
	 QJpr9QnHUAmxFKyRKCyRzpopIcH80B3DWj6G4YWyxBIYZWb26xF0fVdhE5w19BKMCG
	 JIhef0z3zMuZw==
Message-ID: <sashiko-outbox-199924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/5] HID: spi-hid: isolate DMA transfers from
 protocol buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jizhou Tong" <fqwqf@fqwqf.xyz>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <010601a1ad2a17c0-5662bcf3-7e66-41d1-9c33-1edff447995e-000000@ap-northeast-1.amazonses.com>
References: <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
 <010601a1ad2a17c0-5662bcf3-7e66-41d1-9c33-1edff447995e-000000@ap-northeast-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:33:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: spi-hid: TX/RX overlap in spi_hid_input_sync() if ARCH_DMA_=
MINALIGN < 5
--

commit 62a7cf26838a2cb27b111ff47187ee064977f44a
Author: Jizhou Tong <fqwqf@fqwqf.xyz>

HID: spi-hid: isolate DMA transfers from protocol buffers

This commit allocates a separate DMA-aligned transfer buffer in struct
spi_hid and copies TX and RX protocol data through it under io_lock to
avoid DMA mapping unaligned or adjacent protocol buffers.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index f2b21066003cb..db0432251732e 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
> @@ -193,14 +193,19 @@ static void spi_hid_populate_output_header(u8 *buf,
>  static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 lengt=
h,
>  			      bool is_header)
>  {
> +	u8 *rx =3D shid->xfer_buf + ARCH_DMA_MINALIGN;
>  	int error;
> =20
> -	shid->input_transfer[0].tx_buf =3D is_header ?
> -					 shid->read_approval_header :
> -					 shid->read_approval_body;
> +	if (length > shid->xfer_size - ARCH_DMA_MINALIGN)
> +		return -EMSGSIZE;
> +
> +	memcpy(shid->xfer_buf, is_header ? shid->read_approval_header :
> +					 shid->read_approval_body,
> +	       SPI_HID_READ_APPROVAL_LEN);
> +	shid->input_transfer[0].tx_buf =3D shid->xfer_buf;
>  	shid->input_transfer[0].len =3D SPI_HID_READ_APPROVAL_LEN;
> =20
> -	shid->input_transfer[1].rx_buf =3D buf;
> +	shid->input_transfer[1].rx_buf =3D rx;

[Severity: Medium]
Can shid->input_transfer[0].tx_buf and shid->input_transfer[1].rx_buf
overlap in spi_hid_input_sync() when ARCH_DMA_MINALIGN is smaller than
SPI_HID_READ_APPROVAL_LEN?

In drivers/hid/spi-hid/spi-hid-core.h, SPI_HID_READ_APPROVAL_LEN is 5:

#define SPI_HID_READ_APPROVAL_LEN		5

In include/linux/cache.h, architectures that do not define
ARCH_DMA_MINALIGN fall back to __alignof__(unsigned long long):

#ifdef ARCH_DMA_MINALIGN
#define ARCH_HAS_DMA_MINALIGN
#else
#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
#endif

On 32-bit architectures where 64-bit integers have 4-byte or 2-byte
alignment (such as OpenRISC or m68k), ARCH_DMA_MINALIGN evaluates to 4 or
2.

When spi_hid_dev_irq() calls spi_hid_input_sync(), the 5-byte read
approval is copied to shid->xfer_buf[0..4] for input_transfer[0].tx_buf,
while rx for input_transfer[1].rx_buf is placed at shid->xfer_buf +
ARCH_DMA_MINALIGN. If ARCH_DMA_MINALIGN is 4, both transfers in the same
spi_message share shid->xfer_buf[4] (and spi_hid_alloc_buffers() only
reserves a single ARCH_DMA_MINALIGN unit for the TX region in
shid->xfer_size).

Should spi_hid_alloc_buffers() and spi_hid_input_sync() use
ALIGN(SPI_HID_READ_APPROVAL_LEN, ARCH_DMA_MINALIGN) for the TX region size
and the rx offset instead of bare ARCH_DMA_MINALIGN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010601a1ad274a9c-ca=
2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com?part=
=3D1
