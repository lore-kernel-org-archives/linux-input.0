Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795416038;
	b=zNuaESGId2Q10wNBq20M4J+S83xsyLD/AsORqVOAPFRIY62nN3ryojC7K7HlCyy7lwOi
	 aayZN/rndjyEVzYt2kF6CtUsG6wd1x6m9C6S98qB+FHzbTjjlS7wxq78dgjLwrZtgJX5m
	 CYEr08iazUznXXMJTNnF3drbGZU8bKu9piv4nPL4Mmqm727smY9aetZqJoWbBZ4YHa8hn
	 ZN4z+EuLC39irotb2tLfjwIYmZM0o2PtrCt25oCVwMaa2IqVAiN1bU/sDzDgz0NhOqgaA
	 GA27U65LOoBUCj9BWMMx42c+TXrz+sPFvTnDC/w+4PHV32PrxEQYhs5zGskgUmVDDAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
	b=3prXKanEDV2N/xRpH63uEG0jfv1gX+LainCldtYXhCFfok9aoajd4luKKZBLKHYbw0ER
	 g7JKr68uS164Of065YX0ZThchmmzXikebqJ9lggNxqVXNfY9/Xj3HA9pzp6zOezpvDOHg
	 vNbw0ihfw2GVolinb4hueMe06NWfy6nJ9InIP6RKxyueDUFSNRAJctEqcMHRemQlTFAbC
	 ClEZo5MF2vXEfXS2uBNZFIDbT9Mgj6nrQLwH71/oVv5BfMgw4uZLJ3fXDsVmziB7A/S5J
	 3WCOPkCwfbLuSk5t5gvtzwWXUS8p6ixnbQf7Z4ZkVFulpfizmlU2Nmp2bWHpZX+U++g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tj7oNz/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDE606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40DDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tj7oNz/g
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1109967c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795416037; cv=none;
        d=google.com; s=arc-20260327;
        b=fFsDYe7tO8bLJM9/IHAYMUmv1QUIlMxuhUzSI9YabhdC/SbWGX3kA3iKGMP6ImLXGU
         eCCmrpogJeFmRHcrfIPC0uhxBRNJ09CBvJaeLO4oxQwlulMZ1fhJFxGcboM9mYnXrIdy
         hWPcsN9fyWtfKl5OuUSpxN56/TxnMY3TwKWyoCDqmg33OdbXRIz5ml1v2h5ZRQ08Ry7H
         epeaodNUbLJLt34jnEVuInh1yzOWxPDvRiUPTSlUl8B0VxwUGL12gMGkbwv7HexcKTbE
         yunU9wzw+XJ5bRzW3H6L6peeVK+2543dqgzrhlIFdxITV31mpZuGpJfaK7fOhoeoKlqr
         P0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
        fh=7Rssv86B1U9u7PU1yGlRtpZTEbuoFmWMsuk+9STfmaI=;
        b=JVIaugg+K4TAo5EcZZXhJ/jNFnGTIYi00Dj+HWLr29g++DihUlRaa6b07GBecqnV6M
         lmqy9Tndktw1Awk6qUIYAghs04Tt/RNKlejp4IEOjiPNZrzsFl9mf3uAnY0lUOYexQgZ
         irzswbCrMO2ywT4UKgSpxhpRKNDMi8axkX3z9EyEw5cCVaq6TN/3hm74c4cMN9Am6g6A
         HLbu5SCvOUsDljuQcD7Jgffm/4w1kkHwKrIDRVz7ZArFnFx7AG2X4jQu4e7KMCsjKSVy
         kEghq7lJBF6K/RdhFrDkm1XpkGIkxJP+4XZulUz/157PbtyTJ7hBdEXrEl7Rvu6R2+MS
         ysiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416037; x=1796020837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
        b=tj7oNz/geF/WMXYxTdQF8S73V971uV/32Yq0koMbSYdL/PioOpHn9SOBzqOlqUljxR
         8ssbWO7m06sjuxD7HxI7bNAULBrMuiu9iy0BKjrA+YNVRlDDan1yRAoJUklSqaifEZ3w
         deQAbjFhMSsBlsXexIFRTdNB/uArYZjbPGOd9N6v4ii37VMLx5LeKoIj7bvDeK+nNKfb
         gzY77YNZTvfMsKYY61cw4NpGoa9OsSWbybgZqWzuys5/Zd7KevJLcfziwsFg8FRwMtf1
         H5pDmahyoil88gCFeziexDgRA5VoG1aPlfqmpZXxx5tVSz4+f990JEqm/DVhaYQ5Xq46
         i4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416037; x=1796020837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
        b=CGOtkZefEauRnTC/IM9xjR5jJ8X6Gdr+2qhdyMU9kwo/tHzOxIxeUEUiYHfkTvRe/Y
         q7GAuSJRbLtaqkikbLJKUJP0aTI0RFvTsLHPZzmGeIoJel1mqMPHVJioJDrPTz691FR/
         xf061/zgZ65JFx+XD/bFOncG6JL1lPoizZKX9quE4/ewDRejb4wZyjKV2yHFFVLlUPXT
         0TmwVCHGQ9VWi2CPWBAZQjuCv9pHmN6q7ApI2UReF7ZG8nxctNBASBeEMdJTQZO++Nu+
         nKUXfEpXZwSVZzYAhFPj19iryTwe3JAwIFiDNMdD816ai1p1xMN3YVcXhQEav440XtIZ
         /oDQ==
X-Forwarded-Encrypted: i=1; AL+hErHw6NhcgbciNZQhSpCQqyYTf8N1noZUK9g04txA4uD67wsYczO0Et1n6b3RVgwH4JH8mxlVPRkEjt6LUw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9IyJuifANpDuIznIJ/zzzTir2DejC06YIhTwWyQYdUcLL+bgiY
	hdwFUl/pjyyaLm5tzIK0+G4OBYuVMAo7Plw3oDGjUDdQo6bUKDNC7i2m5xxgDbMpAmLWBu+E3mh
	ExQ6hWJ7GWygcFMivOpquPmWEhYU2U7o=
X-Gm-Gg: AZFdTZcwJBH1XQSLfNg0AKN1YxBmAJCiBZUJwhfFs9Ih73UpsD+O0YIWdd4465vRcaM
	U4UjImikpedtPYZ2pc/+VYxAGcYic9PZM7/KBkn+9dDVXNmGvXz6N3ksuOgR4O+Zhfu4SB763rJ
	8Tfys/Razp0ilHoJ8c9uSLSAqtVEo1g+wuxX86Y2+BcptTfqD5FySzVa9ggxjfOGklkttX0L3vL
	Ojj+H43pxXY2a6mz1HHeW+zc2NVNzi0TDazDLFxHP/qYY4I+1IWI7WRnClZ4CL40iVWzFvKHoHt
	oSiEDxYc/RX9dhDJEtVQ79/qTtztkB1iKSZNdPr61ZkBimbDtCOyP2pTb+ayluVibPs8+JKPo3P
	06VOKs4ZsNbT1h9ObPnyALVHXOFXzAmm04xTK
X-Received: by 2002:a05:7023:a41:b0:1b2:67f9:43cb with SMTP id
 a92af1059eb24-1b5525e786cmr12124036c88.17.1795416037296; Sun, 22 Nov 2026
 22:40:37 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120210317.184756-1-kapoorarnav43@gmail.com> <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
In-Reply-To: <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Date: Mon, 23 Nov 2026 12:10:25 +0530
X-Gm-Features: Aa3M54pKXHh6UQF7oq3WN8ub3J8erT3GSETIT8vxp_X3pViFXm3_QiDK3Y4XRHU
Message-ID: <CAJi8Lv-orD3VA1NJ71L1Qcw6=AWuBZesVFOHe5Y+bwzWxT8KRg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
To: Zheng Shuhao <viennaoffh@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zheng,

I'm fine with merging the fixes into a single version. I've just now
read the other mail thread.
If you can, please send the v3; else let me know and i'll do it.

Thanks,
Ayaan



On Sat, Nov 21, 2026 at 7:08=E2=80=AFPM Zheng Shuhao <viennaoffh@gmail.com>=
 wrote:
>
> Hi Ayaan,
>
> Hmm, I overlooked the latest discussion, which caused some overlap betwee=
n our patches. Sorry for the confusion.
>
> We can merge the fixes into a single version or find another compromise. =
Either way works for me.
>
> Thanks,
> Zheng
