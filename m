Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795568632;
	b=aJdY/R7Vn/Oi1pLJHkiaSKHghIlf32o5sxT7RS/aU53NyT3AvvGwjHQ2sumqXB3apN1B
	 MnE5HcSqbzi+/nj7/3jtpN5J2YNU+BsfHwmgzzTESgb6jXTBZTr8aN9KCMjMWn/RQHytg
	 SvXcPOzOI2ezUR/QMTh4OOhjw4L/1KiMej9d3Ic705bnNwXCCpOqDUN/gRG52YctQdpvx
	 lCYdp3/Wch4+3b8sNEHtYZ4nI4hDQBqgzH0VRRjcE7lBXgEUYZbo576RwWJxEVnEWCeCN
	 Ysv02dU+gMR9hBL4LmMN2u7WejD0O4al44DQxgGSOJS40jAo2rGeSxUl362wwi10Vmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=W88WW+gfbkXrh8jQ6u/YK2qbC3+i3JqjF6J2gaF05Zc=;
	b=4UejeqFLQ/FsGNq8tRQ76pW0BcvGveCwfWtuDGaC3epfTuOT6D88C6ZkN6N6hHt5isUD
	 s3Niy7BW/861FHc4uT6ZwIQWNuXXHdysSc4+McAuW6F/M2LFAGFK267WU7YiPrUN/fVjh
	 fPpCbpFitpikqAxr3vu9YFI7ZMO6dX0UMFlSnEafMUb0DZIQgaPgM4ykV2JRolBSdEMU8
	 I1fxHVrZESeLy8UDc6cxXDn99JNq5j2eGbCDSpvWyl8nBkPSUYg4mehomm8scc+OIL/eQ
	 lXe85xPkYnHC0Ru+5/GsBu4mD8j3oQxiuZn6a6jSb59gxy5Ir8pAahuULTOhBuHRv8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zjhgQaVk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A93606A323
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 01:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24A93606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zjhgQaVk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so2685382b3a.2
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 17:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795568631; cv=none;
        d=google.com; s=arc-20260327;
        b=UM27UnxNZFAVPIc8yasrD8ehXj+JKElNdA2T/Uz4W0eAlo+c2oQaMIpxaniBKIWqKG
         aR0Q/lB+ssb+CFfOt6iP81nnGDDC3jW4r23mFcKzbe4hMVjmDx7G1Wa4oCDwQziJtkam
         x6lwTbK0gFkTbJLHLJaOJ0sHbife1NoMkaWO+biD7AhttvvzgUaKiXOnSygtGnVHqnf9
         rqke/jMNEP94jw9lBuWit5fcLxn9XSyz7MAWwOJ4TLX4VgHItlJ5E5wovVdTxSYovrJB
         +70uDRHXATSpkUfhPnAtrV3vEmbrvP2ZKVGtaNReRaR4xSRG7bu1uTkEMU7LOkaH0NJg
         UYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W88WW+gfbkXrh8jQ6u/YK2qbC3+i3JqjF6J2gaF05Zc=;
        fh=LxBnF6jb99wCtkr/EEeZSXmt+osxzT6om6yv84dB+m4=;
        b=cAcYV4lpFKQnZzuSxBij6ve73apQkco1XaMFV9zHcG3sHiTyMuYsCeCTaAmhG2WZFR
         1d+QGmFLbAfMR9P58DzD0Hl8IngxwmA1bUchpMint3OeVA/YItn6beA2hGIwPff400We
         H9iUJCPvK7PorsK966Jcn0hwXemtnBYRH9Y/lUF5cvmPpEuLGE74AixombL+f2cKUKfm
         6BYG2aL3e03+9QFvxPqCpbLOMZcdaV5khkYjiIl+u1t2B/8oCn7Ff1XU3UZ6JWv/RCzW
         ERMEMPE7DnVyQUPBVayHeriHFYfpj0tZGuI4VNxkc/aGgm09T1+heYU4oZ6rKNztSi2F
         cMuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795568631; x=1796173431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W88WW+gfbkXrh8jQ6u/YK2qbC3+i3JqjF6J2gaF05Zc=;
        b=zjhgQaVkfwM581VCmQR6qXJDME1WkG59FazRGZil+BDh9+5cn2UKu5IxHk/bnrNEY7
         ADbH4ZmfoOLayS62tV/H5wSxVQUWVDyvatU1CbB38jWJxkii/iXKvn2zJL+ZFgk1y5+K
         zxsFGYlBdxIElsLGFFqb5OatJU8U2mzISmcdSmg7Tn4+nAk4xXyotYhmTl9R/6aKcSdm
         SouzwoCj2CalbZk2s/mEXwyMHxoT2DnfTt8M+rRD1jqgtOHLdvIKsE6itYzTcq+p2Hqn
         bClGXI1FMWH6Z/nmLMj6A94nysg4v9Dt6JJG9SUiTwAuEjyWK4bPgheGXnWuPUCLD9Ex
         UyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795568631; x=1796173431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W88WW+gfbkXrh8jQ6u/YK2qbC3+i3JqjF6J2gaF05Zc=;
        b=mdruzBvrKq4u8iSHH0reIttRNbznRxaVyXHJy6CF3kqYA4u009bQeOvcaMFYbcA5rz
         +VwsChinYxwYBe3XEH0k4icqQooOsaPCJg+usO7oawQm+hVnmsRkMn6B6kO2yu60vH+m
         k9EpUbYXJ6wf5xYn9ZW+2u+3wQOuO9D4B5DGHgA5pTkD+JgwJ4ZltHRbmCj/9ESjKZKS
         ZYeGuI+8Tjfjl2BnbMtc3hK7Qwtwah1H7tIxFspfKaHojSwe/mbOIpHimxCfLUaMQpNM
         AXUSdt7C8T1XHJZ73A+3A37cjbmkq5dIvv/Ba25E0NssCmbF3SMJ0V7PM0EdwLARMkUW
         tBjA==
X-Forwarded-Encrypted: i=1; AL+hErHdLZElA0hEr61RoYQvcI2PxU/QA4oW1haslo4nnnb8wQeKvT8QlvviM/6fcLdKeqA5rE4NMQnLsSW/Lg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+N8UsB/TxPxSj2PfFR7tTru3wrroxWfS2LTq+mtta1/0S4vtg0
	u6PoiV5J08Zppu9aVG14CjMcyXzLVci6EQReDqWcB0Xnm0NLfmuNphjzJoSaj1F6qFhZMJxSlwN
	Dv9gowJ9fWShwXB3RuaIvPEg3hk9PqFU=
X-Gm-Gg: AZFdTZdp6595ZUIXTWsdPY4d/s+t4S7vdFOVnIkJd62GwwDEPGsB3OMY8YHIgwnNm8E
	1HGMQpJOMnT4x72+/DE/TG13sXOp9x1soZjgriYyc0Go+tPIlMOxdRTcBdeKoEDpkhcPbinrWGO
	mc/9co+WT9Uwt9hzEd9Qr2lX6Am6ADpzJgTnnWsXMskjyOLayynAE/39GcpiDVLMox7yGkvkLXv
	jFuKzduBN3o7yYcFdaq7fL+Vcy8U3jeJJwT+oBQUx9po9cvDcJeLRsdWgPe7jHJye6APz4ZBLqc
	sLh0U4fshJaNKhdyhkZnbkjr+t/rwLgdNoGE/nqW1o6kIOnLmuShWmcrv+0HGxIPSSV5t61qvc/
	aISCe40GObC2GDaySe10vMpPMpl98CAx5+PM5
X-Received: by 2002:a05:6a00:3c92:b0:89e:cfbb:e8af with SMTP id
 d2e1a72fcca58-8c8792a49a2mr13089486b3a.6.1795568631320; Tue, 24 Nov 2026
 17:03:51 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124141315.6745-1-mapengyu@gmail.com> <20261124141315.6745-3-mapengyu@gmail.com>
 <FZtYs5hkRyun2eYsm46vxw@koesling.info>
In-Reply-To: <FZtYs5hkRyun2eYsm46vxw@koesling.info>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Wed, 25 Nov 2026 09:03:40 +0800
X-Gm-Features: Aa3M54rn97kRG-wMiFt0j568D9m2Hk1BUEjAsQuizUsiWSwduJspka7OaeqHOkM
Message-ID: <CALSz7m3iGBEt2TF6e2vCP1BFbN+jzLfwvZ7zCp40H4pAamoddA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] HID: pulsar: add support for Akko Gaming Mouse
To: Nikolas Koesling <nikolas@koesling.info>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nikolas,

On Wed, Nov 25, 2026 at 3:11=E2=80=AFAM Nikolas Koesling <nikolas@koesling.=
info> wrote:
>
> Do these IDs cover all Akko gaming mice, or only one specific model?
> If it's a single model, it would be good to use its real name in the driv=
er
> header and Kconfig help in place of "Gaming Mouse".
>

"Akko Gaming Mouse" is the USB Product string reported by the mouse.
The USB IDs are shared across multiple AKKO PAW3950 mice.

Thanks,
Aaron

> Acked-by: Nikolas Koesling <nikolas@koesling.info>
>
> Thanks,
> Nikolas
>
>
>
