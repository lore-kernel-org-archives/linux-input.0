Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180A35202A
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721470; cv=none; b=ODHocn8EaYuL6CE6MQyJO0MpxQnez4jrspQuNbAaTUefEdTAMftvaqjIau2SQ5u/qTeap/IlY10GiiargHyY4qRdS4xmTbgM4aEEb/MBRkYkxeV5B3bLfvCk6y2BgCpFv0fzfAEiZwrh9W1vitAt1UcTPYMVqDB2F3s1K6Grp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721470; c=relaxed/simple;
	bh=JzVBc80EWQh66w3C+Web/Vz7LpJBWeiR8kD/Pt9Yvz4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Sfl7yq0V03XKe3VHp1rLLd1YuRGZvQpeIMlF1IfXM32/kvdN3DZFsh6Ht0eFFdXAnTYdWztXnlg8f5wdbmSGKDcoOAHHMC0aoCb7f6Ypi14uuIczBtQ3hDH9FPyuovuGIrqrewLwfMyhk2yl/TLeHAmnKZOZW9KY/nCJDz1aK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6okpU7r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6okpU7r"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so57995a91.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781721468; x=1782326268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzVBc80EWQh66w3C+Web/Vz7LpJBWeiR8kD/Pt9Yvz4=;
        b=N6okpU7rYZVN6KRHZ61P3cgQzCh2jOgBnLEeNsXLWBglOaEP8ut18ia4aFdvR89ZA4
         QnzrlN363gQV9xPwE5cWW31TBuizWRMdeHMMtEnCWaeKyYzbvW43tauLlm3mIFOJuERL
         5ZTtHs8IWm6+S+3ZoM4RGIFCxB/+pB8jjjnRasQd07VF6P8STQ8p0R6OUg/7pz367jgq
         cfQ7sHJq3fr+atAfIcsepM54zryohOjlwQZa+cTz37NiXqWSIpiUMEc7vkdovh00/YAV
         2/39TlamUubFjr9WMdcTFAXZVT5hN0zRKzdJZ0ZaJf7j/CcU65q58uc8uSwdgLkGABO4
         hAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781721468; x=1782326268;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzVBc80EWQh66w3C+Web/Vz7LpJBWeiR8kD/Pt9Yvz4=;
        b=UL3DnRWkNayKws4+u6Fr6LVdHx8tOufovH++ieD1HfSJmKhsl6hvrg6MBwCHEflKtJ
         Om7Cd56kHNMHf+QRaWdw/ElZulD4W9wlR6oYPwgxvU31hYMjmaaTS8FrKDUrCcUraH+s
         s0l3zuy+tPH+DAnYZGvorCNqrTJNtfRxCP5BXIg3UBvxfxYRcLU7JefzVKkVZbGMdubo
         JJ3l26k+CKkR4UD8Xr809azyoGFa62va7V3U4vxvrjYytUtK+PJBJbt3PzQMgN08uqG/
         CtLT10acgFA+Db0UURuob5ZI3v3qXFLcVRFfNByNc9LQDz0A2ng3Zmpu8xLPy6NUrH5t
         yd5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/np0Nh/4K2d2xmAeUCumfQN3QspabmxTbaPUVBK7OKrVhLd3/rh4PC+xMIzfCtZZjky5GbL+kB1ES5GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1u86mrwjnjc00c++8IEtUchczyhP1yD/hi32Lx6xfHExNvC+Q
	oOYBdVjajToVExDbQ8+qj4fPS6rdnxR1+ztC3ZU1YHNG1F3Bv50ULVIz
X-Gm-Gg: AfdE7ckjvCzzyITbGoX2GEoNdSe8CoCKRh9/Wh/wtN4OD8mkoG70VWkXXgntOP7fiom
	iGaHZXpFu/K2a8zkxCAe7Dz99VLl1Mle4K1sjE9kmPmrhfsWU3EBwVCY6wr0X396d/mi9xGxZ2q
	arqjpFSOCL6FFoCa5b7v/pBlZNHI7ebLIP5tiidN06Q/L35x4h4RkvTWh+w1UsNP54UCOP8kE6H
	BEBQ3viy/09sHu0QbhxBqN74b9QqJ53hQOihv18KC+HKxiL3fFjXfPwdpkQ5b0EdxtsMNtZflWZ
	sUP+GQ8xnBRpGkzD2xcp7L7qVS1y7IQqaDat1LzuAOULoptIgk+ZAF9F0yIZV4wsLweoS+xc9G5
	poataQuUZCIRrdUoYvPz+YX4jIg+GPmfY3z4S9qlzLVwd6vTzx8yae7fbwTVWVsjcR4u5t7wM0o
	29WypYwv+BcXpHPkpnoEi5Fkd9EdyHzEDVlGg=
X-Received: by 2002:a17:90a:c883:b0:373:302d:3ce6 with SMTP id 98e67ed59e1d1-37cdbd45565mr379299a91.8.1781721467942;
        Wed, 17 Jun 2026 11:37:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:6e5a:8e24:dcd:4d7f:c92a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37cb988cc64sm2180161a91.13.2026.06.17.11.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 11:37:47 -0700 (PDT)
Date: Thu, 18 Jun 2026 00:07:40 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
 "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "archana.patni@linux.intel.com" <archana.patni@linux.intel.com>,
 "hongyan.song@intel.com" <hongyan.song@intel.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jikos@kernel.org" <jikos@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/9=5D_iio=3A_orienta?=
 =?US-ASCII?Q?tion=3A_hid-sensor-incl-3d=3A_Fi?=
 =?US-ASCII?Q?x_race_between_callback_registration_and_device_exposure?=
User-Agent: Thunderbird for Android
In-Reply-To: <50ce20dec63080dde13336c6af41c0bf4de43426.camel@intel.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com> <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com> <b3c449ee646fc3bff89dbbdfaf04f731fea87b2b.camel@intel.com> <20260614192442.6eaa1a54@jic23-huawei> <50ce20dec63080dde13336c6af41c0bf4de43426.camel@intel.com>
Message-ID: <3FED088A-651B-4E8B-840B-1B92CB4DF6F4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 June 2026 7:06:43=E2=80=AFpm IST, "Pandruvada, Srinivas" <srinivas=
=2Epandruvada@intel=2Ecom> wrote:
>On Sun, 2026-06-14 at 19:24 +0100, Jonathan Cameron wrote:
>> On Mon, 8 Jun 2026 15:34:05 +0000
>> "Pandruvada, Srinivas" <srinivas=2Epandruvada@intel=2Ecom> wrote:
>>=20
>> > On Sat, 2026-06-06 at 17:07 +0530, Sanjay Chitroda wrote:
>> > > From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> > >=20
>> > > The driver registers the IIO device before completing sensor hub
>> > > callback registration and unregisters callbacks while the IIO
>> > > device
>> > > is still exposed during teardown=2E
>> > >=20
>> > > This creates race windows in both probe and remove paths, which
>> > > can
>> > > lead to NULL pointer dereferences or use-after-free=2E=C2=A0=20
>> >=20
>> > Reordering is fine, but can you show how this use after free is
>> > possible?
>> Agreed - I'm not seeing a definite issue so more info needed=2E
>> For now I'm going to mark this changes-requested in patchwork=2E
>>=20
>> It might be a touch slow if someone manages to get buffered capture
>> up before the callbacks are available, but I think that just means
>> dropping a few samples?
>
>
>Correct=2E
>
>Thanks,
>Srinivas

Hi Jonathan and Srinivas,

Thanks for the review and for pointing this out=2E

After analyzing and investigating the interaction between callback registr=
ation and iio_device_register()=2E

Found that read_raw() (on-demand access) and buffered IIO (streaming) oper=
ate via different paths=2E The primary impact is loss/stable samples rather=
 than data corruption or system instability=2E

Given this, I believe the change does not strictly qualify as a "fix" for =
a user-visible regression, but rather as an improvement to tighten ordering=
 and avoid a potential race window=2E

Treating this as a improvement patch rather than a bug fix with potential =
following commit message in v2=2E

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

iio: orientation: hid-sensor-incl-3d: Avoid race between callback setup an=
d device exposure

The driver currently exposes the IIO device to userspace before completing=
 sensor hub callback registration, and similarly removes callbacks while th=
e device can still be accessed during teardown=2E

This creates a timing window where userspace may enable the buffer before =
callbacks are available=2E In such cases:
- samples can be dropped,
- buffered reads may observe stale or no data=2E

Reorder probe and remove paths to ensure callbacks are active before devic=
e exposure and are removed after device is no longer accessible=2E

This avoids a race window leading to data loss=2E

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Welcome your feedback and valuable input for v2=2E

Thanks, Sanjay

>
>>=20
>> Jonathan
>>=20
>> >=20
>> > Thanks,
>> > Srinivas
>>=20
