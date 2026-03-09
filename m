Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873B3A63F7
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065699; cv=none; b=GsKgcfJ7WQCsDdpsbBvCasp0IiXy6xQHCpTN1ZtpoUxc/D5VRF5x5IB+1fa9rUhjDIawAy53sF4lulNHhIRSkpe/G6CVqOw+/IrQR55EgWzqMierPHUJn6AyR9yKedwgNwkrq8u3+SNlfjiQdY582a+hBXJdvPu7RoP+tcrFcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065699; c=relaxed/simple;
	bh=9lvQX9fmBjyeTI1FZ+BGSlZlpfTaB4KXQ4dV+V05t8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F62fKy6EyPKO3cs5GrL5wV1Nia23Gk2TTrVZv8kWU/lJSXwCBMEEgcgbVapCdXuicjUTGkJMbKCZM3p6ALyelqj9tHUznJfYtCa6drjLK3WdElpTdQJYzk2YqHBZgW4P3TsiRBuQScaoJFFlXBzvOY94kQ6fbXFmp/anUR66Pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOGHoVlb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOGHoVlb"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439c56e822eso6183229f8f.2
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773065697; x=1773670497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lvQX9fmBjyeTI1FZ+BGSlZlpfTaB4KXQ4dV+V05t8A=;
        b=cOGHoVlbC5Yzh5OUNO8niSZUooqHHH4lN8anZMAGBbsHk3cpOmuVImni6dI90kSVLm
         MimA+HY9Z9odDOV+C8oZFLml9N3Puf/6NYrXQigUQBHJQOWLoX6czyxk/XIwaql1ksKF
         pu+mc9hdb4+XTHHbgxtC5y+2+h3sKeYGL7tSu/WJv/mRBLw6X+kbqvCxNKR605KLa3ft
         q603wsoEstDxwI9kjW9JATn3JEP8afzrq2lplQXKj01nkNQsNKb9i5ozF7aMeoeGD35P
         lcZZQ/uRZwwF6NycXJ5j2jp1L3OfdS7Hljl8Z8cYzL/KJ3aW5cD+2uQhaNeC3z2TUh5q
         oB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065697; x=1773670497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lvQX9fmBjyeTI1FZ+BGSlZlpfTaB4KXQ4dV+V05t8A=;
        b=bWB83El+pKEF6XMZSBJaWK+hGzbhS2KAo4Ze/HqseIqecsK/F6d/RsALfYFuwRfR3g
         faGc5SPUtqQM2EFgejxvpqpdPsvSip1EpOrHWMh1fKnVXEwq66TQRPjUZPMLDNZGORAc
         L9VgZ/cKRH2FBEQFCbEe7HvhKIrY+5rOMaX8aPWHL4rGlC3elTGec7y8t/irhpSJqayB
         EBzeBvUQ7SLYQuH7DZtzHwh7qnyjKjoOsKU5E6wqcmrr5KUWRkdEZ+skyK7f85mqM30k
         27wBRV2GpFq4ZRUIxfY25hICAGgJSIPXBFKHFHH72+03Wnvr8KNBkCVPod48Ob6PyZfa
         OcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJFmjjkaLQ3SMzYDs9c9qeV4PGMaLfqWuSL6PK2bOupW9IVgU3K0MfRBL5zQzxGE1KaYFO1S9pCsnEdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzYCBlsHbtaf3PtnIdeWwMBJI0W6vpDHM6xUb7D7l5cm0gIov
	cU2YE1Fe2RZyDuHb1jWXQMJ4EgcT4LfRTd42VfN8IqPQlIrvIas0a5qY
X-Gm-Gg: ATEYQzxYwinhCmYEB5rGNCFfE0T1K7UEMumM6dM8nN51F2yBO0melvQdEKMr0R9cSze
	A5CknD95eYdE0B0d4VBao0wzLIw06MSjYQPwicChrPxAbvPZ5uvqSh1htuNoWlL/Ng50lww/TDT
	55aVBiTPX/zv8aYKhHWs2JDoZpYfNJ0RW8PX8epc5C3ZFDo7kCp+m7Ff+GznTnUjUF0R3kVfQt4
	2d3flTQfLnM8LnJqetUxddp3pP2Y8mX/Mnrk6Pe+Iuh/wh8qDcBjHQ6As3NDykXY57EAevGKgHr
	K72sG8o6E/MIMQk3M0Cpwi6mPnPNlvK4c4fuYjarXV0PVaBjH3uHxu4aVkn4d5gpuDgPnkiixdV
	0Cfx85Fb+3s3tmXTHUyAcnX3pWNmSQMX9VjxCfwuf/L+s/ZackjjBc9uyvkMvbbo4EEJ/riuOwJ
	l5veaMBGpTLVEDzjJoHO4r939T4dAGlyA=
X-Received: by 2002:a5d:5d89:0:b0:439:b932:b445 with SMTP id ffacd0b85a97d-439da5553bemr19249202f8f.2.1773065696441;
        Mon, 09 Mar 2026 07:14:56 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9fbsm27354711f8f.23.2026.03.09.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:14:56 -0700 (PDT)
Message-ID: <00213b587ae4f9bde11ec928081abb60ddbed09a.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] iio: buffer: fix timestamp alignment (in rare
 case)
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Cameron	 <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?ISO-8859-1?Q?M=F6llendorf?=	 <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang
	 <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Mar 2026 14:15:41 +0000
In-Reply-To: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
References: 
	<20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 19:44 -0600, David Lechner wrote:
> In [1], it was pointed out that the iio_push_to_buffers_with_timestamp()
> function is not putting the timestamp at the correct offset in the scan
> buffer in rare cases where the largest scan element size is larger than
> sizeof(int64_t).
>=20
> [1]: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huaw=
ei/
>=20
> This only affected one driver, namely hid-sensor-rotation since it is
> the only driver that meets the condition. To fix things up, first we
> fix the hid-sensor-rotation driver in a way that preserves compatibility
> with the broken timestamp alignment. Then we are free to fix the core
> IIO code without affecting any users.
>=20
> The first patch depends on [2] which is now in iio/fixes-togreg. It
> should be OK to apply the first patch there and let the rest of the
> patches go through iio/togreg (the later patches are just preventing
> future bugs).
>=20
> [2]:
> https://lore.kernel.org/linux-iio/20260228-iio-fix-repeat-alignment-v2-0-=
d58bfaa2920d@baylibre.com/
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> - Don't say "HACK" in comments.
> - Cache timestamp offset instead of largest scan element size.
> - New patch to ensure size/alignment is always power of 2 bytes.
> - Link to v1:
> https://lore.kernel.org/r/20260301-iio-fix-timestamp-alignment-v1-0-1a549=
80bfb90@baylibre.com
>=20
> ---
> David Lechner (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: orientation: hid-sensor-rotation: add=
 timestamp hack to not break userspace
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: check return value of iio_com=
pute_scan_bytes()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: cache timestamp offset in sca=
n buffer
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: ensure repeat alignment is a =
power of two
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: fix timestamp alignment when =
quaternion in scan
>=20
> =C2=A0drivers/iio/industrialio-buffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 46 ++++++++++++++++++++-------
> =C2=A0drivers/iio/orientation/hid-sensor-rotation.c | 22 +++++++++++--
> =C2=A0include/linux/iio/buffer.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 12 +++++--
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A04 files changed, 66 insertions(+), 17 deletions(-)
> ---
> base-commit: 6f25a6105c41a7d6b12986dbe80ded396a5667f8
> change-id: 20260228-iio-fix-timestamp-alignment-89ade1af458b
> prerequisite-message-id: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2=
920d@baylibre.com>
> prerequisite-patch-id: e155a526d57c5759a2fcfbfca7f544cb419addfd
> prerequisite-patch-id: 6c69eaad0dd2ae69bd2745e7d387f739fc1a9ba0
>=20
> Best regards,
> --=C2=A0=20
> David Lechner <dlechner@baylibre.com>
