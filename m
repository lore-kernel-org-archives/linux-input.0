Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BB29B78F
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515420; cv=none; b=MlCOhslxYGyyDWKixqDhvgr32bnUfutIxm/q2Na9AngqlteIWoDcQKrsAypJ6Tf6sD+7qIZ4VTFZdmBzlcaBwyn+H6vO7BEc4GNMHciPxV/lvGW6NgjPqrbIvOYbiXJI0nfatsBPQsiorQqwfkzWf+6mOaZzIKEItzbO0D589M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515420; c=relaxed/simple;
	bh=uDcwtqP9rNC/ypOOCxMk03DNsKczo8BBWweebMLzcn0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ELRbEjbbEse31Ohq0RwLPhR4mYXBVj2Lj1NFVFfDBMpb1VuZhuZZm/zgyAA5cEG4MLuStd2XKoYsV7EuAXcJZ+r1nXIhpplsyJOjIS4PNk9/Cn8QELlfi0/tCk73MzipfYLYs75vxsiQvEmRH37T544Yd+D+hq1y0JdlInw9Sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Cxqhkk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Cxqhkk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caea3f742bso43697045ad.0
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787515419; x=1788120219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uDcwtqP9rNC/ypOOCxMk03DNsKczo8BBWweebMLzcn0=;
        b=P0CxqhkkUmBy/qbfPRQCpp6znjKZzmlDnhIWBRU4eDB2MeuHpPHcP/baT59FFc4pLy
         4RhjMIgP2RnVRXgtL2RWG4T1p+OBzNiO25QmGzymTxXNwXUeEsayet5ZzD8z4e5vLZTR
         o57O92Mwi4RO9xqOIGsvfIkxgAs8gd3rU14bYdAjdu1TClamlj26U4sFajCEcouEriom
         zCxheQ9WumVSYe0d1/waG/BS57L5cib47CWGZ97qxe1LBxCTJfaaA2IX1ele+sSp42zr
         JmZTCtDOliDTJPkf4F7LIRbQNl3ugObYjDbOB9GLInSAHd6lYxdughFuxgGWIv66JDYM
         cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515419; x=1788120219;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDcwtqP9rNC/ypOOCxMk03DNsKczo8BBWweebMLzcn0=;
        b=DDzNhx+3fbXok/YICtivMnAbjlcMDIEE4Vd0t5Py6+EfuyDU9f8yLBNXEcl8cz85+2
         vGbXQLezFFes9z8dLNXXQzExxRlCqX/socN01SyMmQIXBUghiCZTTiRbVCUNcSPIKqB/
         qI0pZjuYTeGp9xsLR1aXPSifwCXuV9RkMsb7I9XD0rkxxOd/jkenXXLXfhHi7cg1WJbD
         pqcyR7PQUKHt68dCspFkjSq38ycNf3P8sRMEeNI1FoN1e4eRduVeDBxjbb0WU6tqx0v7
         mqyAmHIGzIuFHy2BbbwHDbMnXX2a+1Bk+2tW/T9c478WIjoOk4/v/dlrxPeUbuiHV17H
         gmng==
X-Forwarded-Encrypted: i=1; AHgh+RqPgiD2jo6Dielpijas9JZrOtsMRkMD50LC1LEanoM0TLKJeoZjX/fLfYRDi7lFZHD1+gPv/Xo+BQeUVg==@vger.kernel.org
X-Gm-Message-State: AFuF++kyuAm/gAS9W0c7bKnHVfd3nnf5nWd2bkrjT0gu1pqKVxEjZUHz
	OHVXSPn59ilsDHS1bfFV6c4DXiVy7pMq/MSM+AL05dWSr2+2qoyzD2RY
X-Gm-Gg: AR+sD10g5OTJyi+4lmXttcbsfgly4x2V1f6J8UiTalFjkCSDs9Uqcphfeqw/xgXpAie
	aWCW/4Fd73SPVJyloiG7pqpxmLif8ILAIOYgTCsqXq2eP4MBfTMAp1xwGq6RXrufWrypPtnmRC4
	5wQI/8Dr1Z7RrnkWRHQU0of9zRe5YuO5jAkyBpADMd30kch5wM2l7Z0GaxMnospbjXZDW00Suta
	Ws4+LD9+CImhxPg44M5hGF/uCzC9zQGcg1FkfgScI6VC5OKlWp2g4+UgQFHqInw8XU5bblGlUbm
	LdITz5dDqTKjWhsXl6vtcA9Ymj6dtC/GpqTZIHfqvSvBimogUUhmxgD9iUc72AhAXDaqgaoLuAz
	NKAIlpCsbnYWA66+kOhdLmMh57UyTMn9aQKd+lxu5l4Nr7Sg30y7yd1TcOwKRqCxW0xOS7B4Jc2
	ZFsW8FPUe1rs1RarVC3FzdktPm5ksbyqoaxtNqxWA4v++vsa4ON/A/k9t1iMinz15SITp3jkV9N
	RQGmqMMYw35j7ICvoaxo0VlaiZ35h3CnejEZTPn/pTfsDkQnX4SBgXrDcE=
X-Received: by 2002:a17:902:ebcd:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d64afa4e37mr413363595ad.6.1787515418856;
        Sun, 23 Aug 2026 13:03:38 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280d116cb1sm7851302eec.10.2026.08.23.13.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 13:03:38 -0700 (PDT)
Date: Sun, 23 Aug 2026 13:03:35 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
User-Agent: Thunderbird for Android
In-Reply-To: <aotPsVYWXXt-X3mN@pve>
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc> <anJGWjlmRxNMoVLG@pve> <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com> <anK_oQqFpZLwCA-a@google.com> <anLtyBB-Vq2D6REw@pve> <aotPsVYWXXt-X3mN@pve>
Message-ID: <3C5BB154-A1A9-47DA-876F-635569AEF6C9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 23, 2026 12:53:21 PM PDT, Shengzhuo Wei <me@cherr=2Ecc> wrote:
>Hi Derek, Dmitry,
>
>Friendly ping on the question above -- is there a version of this fix
>you'd like from me? (A minimal v3 reverting to
>cancel_delayed_work_sync() and dropping v2's probe change, or should I
>leave the whole thing to Derek?)
>
>Happy to go either way, I just didn't want the thread to go stale=2E
>

Hi Shengzhuo,

I have some other priorities currently, so it would be best to have some p=
rogress on fixing the outstanding issues=2E A minimal v3 would be great, an=
d will also ensure you get the deserved credit for the change=2E

Thanks,
Derek=20

>Thanks,
>Shengzhuo

