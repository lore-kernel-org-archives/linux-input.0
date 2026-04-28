Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7E2D73A6;
	Tue, 28 Apr 2026 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393515; cv=none; b=i9FMzmoFvvUmVtD6wS7jSk6Uhniz2yeXm5VLecPthh7ylQitT01TJQx2QdKKonNOIjDIID9jFKnkxrCrGzAs2pfIcA0bfJTMWQmYT3cI9XAigAq56ZaJrYbOCC3+TTCT4mdYVmX2iHF5Jbo64JAMb8umJCmez6FG8Ej9sYCMcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393515; c=relaxed/simple;
	bh=JKzdRZvuHUchO+e4dsXypCHVPbOfaTJQ+buSRUzuB0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MPRIAmrqGdc7Yy8ptLvNJkUhhx7Ny4HYQpEzNrJAJKJFwZ3KsvOrNBnyOhHDPYye7ddte9Aj3kZLD0yN+0b5qeWhKw7PWF2sDKMtzyghQ6TKtJOGuTWbgPoaTuCPHFkkLaBLX69mhDEYnmeiP6WeetIX1nq2zWewyRmAlUyzSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMPrJVnU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMPrJVnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81488C2BCB5;
	Tue, 28 Apr 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393514;
	bh=JKzdRZvuHUchO+e4dsXypCHVPbOfaTJQ+buSRUzuB0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CMPrJVnU3lmkQvwrW09qBtbJAR3wbpXUm4JO1aSzrX7DL7RgkBDXNLta6ZEiU4w+W
	 efMGVdEgMZNN8PYkrW5IJ91YgjT2mhrMa3+UjPiHEEdLjobTTNKmkeITYphfdr3ZpK
	 AohyWvrIe0pC+kT4DrfH9kFTUSZx7n3u8msZMtM3J16mPKJ027RSDUkj2nnlDreR6Y
	 +SSOzO7otploFfrB5GaPnQQMdRD5L8wXhLEQCb0yuajO0QmXV2lmnSzNGbe+dp25A7
	 byjL6OXF+o9pxogwvZFtppL7clXy6evzEWXzav15vDNRZ29MzgS6v2Sgdmz0at8rNx
	 jPd5UCWJ1sLjA==
Date: Tue, 28 Apr 2026 18:25:12 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Zaidman <michael.zaidman@gmail.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, sebasjosue84@gmail.com
Subject: Re: [PATCH v2] HID: ft260: validate i2c input report length
In-Reply-To: <20260411062437.279838-1-michael.zaidman@gmail.com>
Message-ID: <r8r0ns12-8os6-663q-7476-r7r4nr499706@xreary.bet>
References: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com> <20260411062437.279838-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Michael Zaidman wrote:

> Add two checks to ft260_raw_event() to prevent out-of-bounds reads
> from malicious or malfunctioning devices:
>=20
> First, reject reports shorter than the 2-byte header (report ID +
> length fields). Without this, even accessing xfer->length on a
> 1-byte report is an OOB read.
>=20
> Second, validate xfer->length against the actual data capacity of
> the received HID report. Each I2C data report ID (0xD0 through
> 0xDE) defines a different report size in the HID descriptor, so the
> available payload varies per report. A corrupted length field could
> cause memcpy to read beyond the report buffer.
>=20
> Reported-by: Sebasti=C3=A1n Josu=C3=A9 Alba Vives <sebasjosue84@gmail.com=
>
> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> ---
> Changes in v2:
> - Add minimum report size check before accessing header fields to
>   prevent OOB read on truncated reports (size < 2)
>=20
> Tested on FT260 with I2C-attached EEPROM (24c02) behind PCA9548
> mux switches. Verified reads of various sizes (1-4 bytes using
> report ID 0xD0, and larger reads using higher report IDs) with
> debug tracing enabled, confirming xfer->length is correctly
> validated against the HID report size for each report ID.

Applied to hid.git#for-7.1/upstream-fixes, thanks Michael.

--=20
Jiri Kosina
SUSE Labs

