Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D463AFD0A
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956123; cv=none; b=CM2ZhFFTZb5LVAFY04e2nir9E9F6fi29DWkoMRpQXsl31+Q8FaRPlyo+gKoNndA0zSUO4ujdxVimKbgQibcPksumserCK4R2dUustCib9TTA3o+NCVhhiqJRfXPuiZp4Hvuc3q904N0wLR14zd1ZBRuBl5y8of36+7HSv1IMjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956123; c=relaxed/simple;
	bh=aO4kFWNpehGDtdrzHRertaCSVfudQ0Ged89ZpzBeIng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItXKEHSrG3Qcroy+SfJK1CHcyb70gOFhuZUAx5R/bw1eY3sGCZPtPWWdO8WgRW3PH8sdo7zUit0M7NPBVNHxu3mpePbcbSL1rvo5t4fbuyS3jRL5g2jHE9tyENMEnAiTmydELj4JyueLhJx/kOWRH9r6OGJWDhLhIOApkiNReLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAGEsw7e; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAGEsw7e"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6d14aaef8so2161579a34.3
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956121; x=1781560921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLteftMqxSBpz8vFkaLokh0cQ8MaetWNL6B6He495r8=;
        b=kAGEsw7e8X7Z7cL+qxt/UsaXovjQ7gJmT87Pe8KVi+N5EcIQQOEwesEAlNPM2Goo1H
         I3l5ZOtIPlinv50YeVCWbczv8EmwBASx6EyCIXi3YmrSi+JpjdAi2Y3t9jtChhVuEF5b
         eZRQOsfoFpbzFLHMx2MhOI/Axc5kK3zTjyl22sr+ub4pDoUkw3s4cBc1OfO/k0Z5OfKa
         /Ra7PJswQrlOkkxTtXL7W7Y7iVVC0DXMg0gpJsyTd1zsx9IgIlU81UWapfGpC1sBqfow
         Yr9KrdjcEX0cukI+GtYghT9PcKGicJnZJahXcM7isa5CWELLuGUbl69SFi1KVWtdharc
         75hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956121; x=1781560921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLteftMqxSBpz8vFkaLokh0cQ8MaetWNL6B6He495r8=;
        b=S2NRe7D72Q9KV/u1m1vCWd+LC7xYp9hHNTz70vabgz8uxiDVqTDhhRQpo/bwFHDh88
         HbLPY0VU5dcPGB/PESezcr1sq0OpSZbEpWZD0dc6C66y7X8AbntQesdYBdjJIBIoopfF
         cVundKuOmT+CJ8QTYZdhAJPoUyZ55kjbAzyehG4bMFtBAfsa+kahDoTJPDy9YNdd5iN6
         m3Css8fh8qc0nVVnhqrlf+Y1vfbscfhn0Br9D1X5Fys60O9EVmJCudiP/rnBl7F6J8WD
         lQjzR/KeL91l+OF7VHBapx8Q7GQWrEttx37bkydnDhLAGqpdipv7r1kSgaumZ75cBnvJ
         hkxA==
X-Forwarded-Encrypted: i=1; AFNElJ+EqyHm3L4daPLYILQ/aQFOdumDBoH1/KSde5cWsI6+AzrJug9FlqF4I/g83dEqUcl3RSjbYMN0eITEOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFg7/7eCm+hHfTE6jHW2EObJTefseu4VVVkOTQDvg5yrF5L6d
	BVH6ezMljLQ/98fpI7oIM8Mvsyz/M8gzKOMf41dKCdc6Lj5+zkc16wou
X-Gm-Gg: Acq92OFxzegAYbxkkGDNJZdkq2O1J+GEFhXXoYrkKytJbWIbeTCculSqa6FSfHfjaBk
	PueHSPWjec9dsui8PMzgUKvw3XaIDTsmKs6hgQA3T5hdl3wvRy2hFsm4G1vurOZhZ7yzGf7y+Kb
	mfkTbAKAMbiCiGdhEqi334q47gQEbiFjW7n7MaNlBmBFJJdCiuQAlVbMxGoTFIB8a5/ifQQ26BW
	NsRH3xVCsMcLJw4xtZgQiIYhlT8G8XGe+LHjR+PUYVwtym+AZ9tpV/U1fatnt4THu2PFu3qUVRJ
	/zSShjc4x43cqQ5+jMVrLvOKS8Q5e6wk3ONbLGP2v8d3oDbNc/qXMGlkTihw4R4oqvvcVnERMcb
	BOKFNIhRQEOfir7OKBzgMZq3kXAPPG3TW9fMNJQDFhU5O+7txSa6rD5EbY7y7MMApWtBEIlTb1t
	UoM4zk9VHXQOV5F1fe4wRYnZmOFfrO31xcwRLbQMi+rJ8d8ApefyzkflhCoFuf/l4=
X-Received: by 2002:a05:6830:7010:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7e70c68cd34mr11040068a34.9.1780956120909;
        Mon, 08 Jun 2026 15:02:00 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e71fe69esm13605574a34.0.2026.06.08.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:02:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:01:58 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Message-ID: <20260608170158.3e3b5512@linuxescape>
In-Reply-To: <20260608194047.23791938@jic23-huawei>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
	<20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
	<CAKqfh0Efa1+VShSW76tqaV8XtAZToRfsCy0cTi5sXOUm_nwLiw@mail.gmail.com>
	<CALoEA-yiDwjkKxUE3B=qiTdBhbvinfq-UN8h1H-HysXGm0prSg@mail.gmail.com>
	<20260608194047.23791938@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 19:40:47 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 8 Jun 2026 08:37:38 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>=20
> > On Sun, 7 Jun 2026 at 22:54, Maxwell Doose <m32285159@gmail.com> wrote:=
 =20
> > >
> > > On Sat, Jun 6, 2026 at 7:19=E2=80=AFAM Sanjay Chitroda
> > > <sanjayembeddedse@gmail.com> wrote:   =20
> > > >
> > > > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > >
> > > > Prefer 'u32' instead of bare 'unsigned' variable to improve code
> > > > clarity and consistency with kernel style.
> > > >
> > > > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > > > ---
> > > >  drivers/iio/light/hid-sensor-als.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >   =20
> > >
> > > Do we *need* u32 though? Usually these types are for places where we
> > > require specific bit-widths for a reason (e.g., reading a hardware
> > > register) but I'm not sure that's the case here. I could be totally
> > > wrong, in that case please correct me but otherwise I unfortunately
> > > don't see much value in this. That's just my personal opinion though,
> > > Jonathan may think otherwise.   =20
> >=20
> > Aside from the array of usage ids that are u32 defined here:
> > https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/iio/light/hid-=
sensor-als.c#L46
> >=20
> > there are additional structs used in the HID drivers that take u32 (I
> > had a similar
> > patch moving `unsigned` to `unsigned int`, but it was recommended to us=
e the
> > types that the structs use, hence u32).
> >  =20
> Here the reason for the change is even simpler. These are callbacks assig=
ned to:
>=20
> struct hid_sensor_hub_callbacks {
> 	struct platform_device *pdev;
> 	int (*suspend)(struct hid_sensor_hub_device *hsdev, void *priv);
> 	int (*resume)(struct hid_sensor_hub_device *hsdev, void *priv);
> 	int (*capture_sample)(struct hid_sensor_hub_device *hsdev,
> 			u32 usage_id, size_t raw_len, char *raw_data,
> 			void *priv);
> 	int (*send_event)(struct hid_sensor_hub_device *hsdev, u32 usage_id,
> 			 void *priv);
> };
>=20
> So given those signatures, these should always have been u32.
>

Ah then perhaps I was a bit harsh on Sanjay.

>
> I would like that clearly stated in the patch descriptions. Consistency
> is a bit too vague.
>

Agree though. But given this

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max
