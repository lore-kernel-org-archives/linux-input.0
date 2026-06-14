Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E2179A3
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472287; cv=none; b=NJMh3kFVEQLNsr29R3+4v1wGTdfwaa6bV+TiAM+79c9B+RgcsgiLyAFeaI9iNJo4QoZHFtBTlsLduvIjxSI+vwgE6JjRJoPkZ43Kkg9OUsV9w7RBswTN39SxOp6oTBSkkGotiaXrW7bAHl23qhR9awfMz+OVAq1jXAb7/CCQBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472287; c=relaxed/simple;
	bh=XxBdA4BXaeozKYYBYuSw/1FQ6CuFD0RJKEjncMA69S0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F9+LEW+4f49DM0Fu7bo7P5fQI9VDTGjb/E70FoU6vlVxbdpOLeIQLLIAOFR9W9avYbYf81Xr9Gk1BGJog+kdjWAC5YEGwjfC8DgCAe6+WbJ2BtpCZVlQXns55d9VVfgWtDoqYPCxFjzOSsOpU23WlTN5mX66uil8fE++c+rF+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nis3flTT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nis3flTT"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915d64fead9so386490785a.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781472285; x=1782077085; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT+kdFMa8x6bQgtH/7AkogoY3MWUlKu35QK/VLka/7k=;
        b=Nis3flTTP0gp0jwDUxjlUneStLWFXJJXe8TrEpkjl5dS16glCnpeIJPVkx2Eq3HOr3
         WoQDQ6/s/u7sX2PEaXuDitOuGF9uKubImIJJFVl0Gc38xBK5h6LGIquuaTto6rWPAtgA
         iicDiHVh2c2LV8MT0dqAxDrT03a98U8UQmSvaxHGCSfozEEtH/mBei72to5tIPSp0KxV
         0fe0QoSYYFahf94VDb2u2i+tNOO49TnwQ4AmmbnV/Gc3zkIaVX3vw6ijlGQF8Bb5sPEh
         9JAkUj0h+uOA4r9i7+Lm/VEJbX+95YTHDYqdVpwUxOSLPB+JDGNDfMEb9h4iVRiu1Sk1
         Q9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472285; x=1782077085;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hT+kdFMa8x6bQgtH/7AkogoY3MWUlKu35QK/VLka/7k=;
        b=ljVrx/PapRNEDnvNHZTDGJwelhNOmgdKP/4F4urSGCLjTWrLxTUhGr25tuOM3VbMat
         3C+Phjr/lRwu9FMunUM5OZKcXVub3/+w5A8PICBEnStE4dLCjRQEO3PNpSZIGI//6j3N
         x1NvU6TKcfsIiMgzc+IzYa0C8zbHgmotfN9T7NLVJEWJPvuElSRv35APTCgx6+1M5yKH
         rvOni8B2CyzUXzSNsTNU8eQoGLAEyevvXe//WOLOJvRZBzm34MdPwnXYwKPUl3EC3/29
         3nMomzNMyPjx5G/00S0kOOooNBn7CDv82gJPycSZQ8ukEwHI88cMZM3ydtfrJZyZFxoj
         7L9g==
X-Forwarded-Encrypted: i=1; AFNElJ99FAzRq8LGN57DrgHc1YFq4TQuwhRCUkLgvuicf96XVQgfirObYO8OqzQVBBByXKNxKqC03elUGF9/vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygJdbH1CiSPT93j4ApxzCsTsouVz9B9Ydfrlgx5wt5uGwote7P
	F7+Emz5mkPV5Vn8HZOOCjsiHqOM/O4+x7qGUeZOLXpAfE2KIyq/zVWsN
X-Gm-Gg: Acq92OGXXwnHNFgMRtdWAtIAgs9E9t2xJTjnZW56KyP4z88MGKoy942sTar4x4RwRkB
	C+30FhJS4+0b4ONhqwQi6yWhLF8w2+E3MENjfijo0WoogNv9tpa40ATnoAabaHjjjBJb5ecqQVX
	jNn4gDsro4w+Qgsh+wnvm8OHR0hYJHPpuj0fagE8gxaZ26ne5cLNQLpUPny55yU5heqLNYbXsAY
	7O3Xpcwb7o1YybLLsS6Ot2GzCPFnRlI3iLLbTo0sk8XhmnNGG05xQWh/gjWnB792Ji5lMmdsAYO
	ZNzwqCye/7V9dfke4cY6xfm05b61ZifyVDkaKC/49eIwfqiZkI3fWC48E51hSFdKBEPwmq0+0Lq
	H0pLKBu8vMvAE/MSNOeUmE+m7xfANvLmkuwpwQV4U078F9HNPdWJBxa1stugktfdH9Z4AyrTJi3
	Z/M2V4YR7wBjoo9LenhHGsQBUdY1enlSHqX1kjZO3G3Txgm1nlVCN64wxRjjJ2rseriw==
X-Received: by 2002:a05:620a:370b:b0:915:98b3:a356 with SMTP id af79cd13be357-9161bf9225dmr1512255085a.11.1781472284962;
        Sun, 14 Jun 2026 14:24:44 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb90:eae2:4af:a16a:929f:e43c:51a8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a03d6fcsm836971385a.35.2026.06.14.14.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 14:24:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <20260614160213.085e1efc@linuxescape>
Date: Sun, 14 Jun 2026 17:24:12 -0400
Cc: jikos@kernel.org,
 jic23@kernel.org,
 srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org,
 linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
 <20260614160213.085e1efc@linuxescape>
To: Maxwell Doose <m32285159@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jun 14, 2026, at 17:02, Maxwell Doose <m32285159@gmail.com> wrote:
>=20
> Hi Shuangpeng,
>=20
> On Sun, 14 Jun 2026 15:19:21 -0400
> Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:
>=20
>> I hit the following report while testing current upstream kernel:
>>=20
>> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
>> hid-sensor-custom
>>=20
>> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>>=20
>=20
> Is this correct? It seems to point to changes in HPFS.
>=20

That commit was the linux.git HEAD where I reproduced the crash. I did =
not mean=20
to imply that the HPFS merge introduced the issue.

>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
>>=20
>> I'm happy to test debug patches or provide additional information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>=20
>=20
> This bug report also seems to have nothing to do with IIO after
> investigating the call trace, seems more like for the HID/input folks
> than iio. HID folks, seems like it was caused here:
>=20
> [   73.163547][ T8356]  hid_sensor_custom_poll =
(include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
>=20
> before _raw_spin_lock_irqsave() gets called and KASAN triggers the =
slab-use-after-free.
>=20

Thanks for checking.

I agree that this does not look like an IIO-specific issue from the =
trace. The crash
is reported from hid_sensor_custom_poll() in =
drivers/hid/hid-sensor-custom.c.

> --=20
> best regards,
> max

