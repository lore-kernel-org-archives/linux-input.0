Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792706634;
	b=Qed8K2CVC8l8s++GOqtMvNtR7FzrcYq1xUIruf1o2y88kYSNEVs6LqyA6xIpFgunM/sc
	 RJsz45u83g42+UKtb1ofLbbKhRQHCI+qn0+VogBdQIrp+GjKct+AAMwNbTby3RXlCw8jU
	 x6hWQ7/LSadQoq/yALtXDxoXc94fz/vG9APtFQ351z+UmzaBWvLQNpq0YNqmf5x3Qz5ri
	 pUJraEySihGrPaX7WYknwsdG1wcI1w7swoX9fblN++PI+v1PFIoOMBUK9nUfFKgeIw2yu
	 4wOnB151f7TqMAiejL8oNdpzJ3Bh13JRnFsQnypbY3OXK9+Mi8ppmxDTnF4p/0I5igQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t19M2fLty3fy3RtM/IZUFvQguDxu0NSLCPm2klc3LaY=;
	b=u73o5YuHhR1jNly/nXRC3j6z5ECEjcg0jnbON8WuU7XPkkgjUZwFEXrPn7aXxM1id63A
	 nKMb71tvTUYMuZAaI085X6MBbbSZ0BBwsVGwhrMGDcF9khRIEVzUwMTlc9XuTbJ0Bmq6n
	 Xt2AuwhZL6ZrIsDl7UPwXhtu2sOeX9e2GH2rsIrO+M7Us7qItB5wi6yEos4C2cAPJ3nYB
	 Vsal4HzQ73WgFzEnu1Xthtrw9+Q1TrnKAN2wfR5mmxrCBs4tCzttVjL9lyFi/E2yFGg+C
	 26TyYx0KCpGhChmknKbB07SmgvIIaDEGAMOOtcUhKtacLnIWR8jLMf0noaM8RiQt87w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qOqg2KUC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A10606A31A
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 22:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A10606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qOqg2KUC
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cb1c0e851so19890785a.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 15:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792706633; cv=none;
        d=google.com; s=arc-20260327;
        b=onshHPvWQZijUoEGhDGs4qDBArQ/mdpKljhzRP+Mp473zn2gEw9Qjzp0q3EuMEks5x
         815lQYxNqGxOLyh25vq+tJ0GfHPwQEZvRlfIhkedOQh5kSw1i66CzSAkLsWGUmFHzCpR
         Fw7eGTdHlypSo6HVrx/ajVrdmwMalywcY0WXXTKOybVUync+71kT6pp02xxlcUUmPkvW
         vkWe7w4GJLaS4VsX7+llSbrL8RPYbPTt7pg07WzFBEb8bYWC3soItlM+2MF1vXKUNqp4
         eCA/Wr+ITBPu8Am2ryF+hYNiY0DXFD82W4ymdGApdT0Hw7lleEh50jyRxW4UzSZ48XZH
         hhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t19M2fLty3fy3RtM/IZUFvQguDxu0NSLCPm2klc3LaY=;
        fh=XjWZhRglyIOwPVXTU2yzZQx2iGWSkenqa3rm5qL3w+Y=;
        b=N0kWcVBs/3xdu37/5ra6oA0pvHgdDummahxtVji3lH5IhFk61GF6Ebua4q24hbPVKi
         NoXVXVFxXi+cWXJYd5FUwNaVDD/nQ2+n+MrfWbMTOHmxGPISCBMSn0FhxN32KM2Yu5mE
         EYLC+Ohq4RQDa0scVtpr5EMtPr5j+iHULY58hyj/YVm/ucy4YBFf3n0rRvA9dIpvf76W
         06CJsGBMpJwbhAPEJBuH4+CHd2+7+17qUmZWAGVfXMlRKt+k7z5CcVcJznEGd7RjTmYt
         ZjY8V2skE1psDArH0ssUyh1440NcxH4r0fkv0x6rj/E/f2wupSUqxS7xK7FUaScbKDeG
         co5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792706633; x=1793311433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t19M2fLty3fy3RtM/IZUFvQguDxu0NSLCPm2klc3LaY=;
        b=qOqg2KUC1UV9RimwnOePxgEaefmiEHr4N9DYNb/USBrPH8WxpgIm+QOJ9d6IIVezAc
         N/+pKC5lqZkjtCXuXmtK0oVvRpiDI8qkYEcUzqeQhVUn1ytJSZk5GobC6gsFzen+zI21
         BUtAZ3UU5SY58UVzNbEy3hJijuwgdoZQ6dWfafSwm2oseUQ+xMqubPSFRsVCxt8u/7cC
         hmVH1+EXn3EeV8yBuf7rSwTzTXccJV5/3J7BAO0uEjkuKHdQqa5Pm2YP1Du0IPWJdNFj
         /x4ye4JGrDHQVHmUX+ciBCvluJYXOLhjIjopuYTW2Ju9p2RTLy66JJZ2Z0xvCQOS39Dh
         lnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792706633; x=1793311433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t19M2fLty3fy3RtM/IZUFvQguDxu0NSLCPm2klc3LaY=;
        b=lmsT8TaeUq0ykxudJWmcvzpR0/0i2lp9C31vDrAcM4euNAxI5DjtyDDYwsfqbKSzrf
         UINbzy+yUUAeZ39W4ULjqfw78NSXHxuSCzmm9SBs9UbDMUVSf4OPHedOwLzoDHx3oU6l
         QoRkJ7U+xwlULIFitzDUlHIPxiSCLteTCQEzvokVu6ZmqA/P8/LKmQo5uzQBVfBN+Ljq
         MgVzbwSc1rK7K0bpUaTzfVekMWW9pApe1/vRrK8F0oIWx42JELRw+j4oNbGWsTUUPLir
         w0BtMwqoX131oYqH1D4CYHtGrrC49N3Mdu1tNUPOBLF9Vh92Vh05hFW90dpWCyPkcd43
         krQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXT8kFWVSxDIkem+pwtoomxMU8siwUTmhoiKgkQVoZdXXmM4KlhVtDdPqTyOKcJ/I8e+U3tMMQTcmAsQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKT423bkjXi82XWUoZZ5jquyDSaG5Vg8Hzw5PtFlMCNN+mVQYML
	cNwiZxdSx7yrBHwqacL/V1YX2VS3fZsoO4yYsophDc+zeUHNL7BSk6GK/OBOrx6Qercqlzyigfu
	ut2v+tdAgTc2O5XY6C3K9jGrQorIHgS+Nk7kq
X-Gm-Gg: AYBFou3nm9SK7po7evL8jTid9+eSJ52E4T0ZxieEjMSlpBb+I5aJXT9BX+58hfIcC3y
	cmgA7W0nAvtdqK8Oh4MP9d5ULoaV1iyN79Ei9hgoXVtrEjU6bp1Pk/iyYQtt2Vmn2puGd2MMP5b
	zFw8rDGrWc/S+5eEmvJsfxWSsej6LEwXMtHeaAt5gFHeoj9QpVdLeN1uHPkQdfXvn06upQtELn/
	v1v2DGJewzNUi5prX9JLDI2vX9ydSQdT+7CZB3X2UM8N6quIixdLrNCcG0g2bfDh154+f3tEbL1
	eXUMHdPnGsSF4M5voSIthfe5yIT6ZUpIC/e94BT1fK0DC6p/lZMu4zywSKU9a9odBD0QZi/Hy+/
	7oYy0BnxOorWucTF0/gQGkVDte1cDo5gGRC3I
X-Received: by 2002:a05:620a:198a:b0:93f:2465:26d9 with SMTP id
 af79cd13be357-93f6f787169mr141361485a.18.1792706633320; Thu, 22 Oct 2026
 15:03:53 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGFfo9K1+WJjuKsSgx+ezLnzcZ+gPFXDBQmZ8W6dDC-oHbd-iA@mail.gmail.com>
In-Reply-To: <CAGFfo9K1+WJjuKsSgx+ezLnzcZ+gPFXDBQmZ8W6dDC-oHbd-iA@mail.gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Thu, 22 Oct 2026 15:03:42 -0700
X-Gm-Features: AclHuK--wR41DUS9O0dYeNHvuhv6QCiLDeFrW6-tgVE-UR-wEFf6PiVkBxyss9c
Message-ID: <CANRwn3Q8XOPThFUfQb4CPUf20o3ehnDN--76i9K1ZHSs-W+tMw@mail.gmail.com>
Subject: Re: HID: wacom: avoid NULL dereference for incomplete wireless
 receiver configurations
To: Indrath <indrathftw@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Indrath,

Sorry for the delay in responding. Do you have a suggested patch to
fix this issue? Its fine if not--your description makes it pretty
clear how we can proceed--but I didn't want to step on your toes and
make my own patch if you already had one.

I would appreciate if you could sent the reproducer, dmesg, and test
logs directly to this email address so I can verify that any patch
(from you or myself) properly addresses this issue.

Thanks!
Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

On Mon, Oct 19, 2026 at 12:53=E2=80=AFAM Indrath <indrathftw@gmail.com> wro=
te:
>
> Hello,
>
> I found a NULL-pointer dereference in the Wacom wireless receiver path.
>
> I verified that the vulnerable source remains present in upstream
> Linux v7.3-rc7 (commit 32c52ec87d6245ee2d12ed5dd509e40062939b50).
>
> I dynamically reproduced the crash on Debian 6.12.113+deb13-amd64
> using dummy_hcd and a configfs HID gadget. The gadget exposes
> 056a:0084 with one interface, binds to wacom, and sends the wireless
> status report. This triggers:
>
>   BUG: kernel NULL pointer dereference, address: 00000000000000c8
>   Workqueue: events wacom_wireless_work [wacom]
>   RIP: wacom_wireless_work+0x61/0x164 [wacom]
>
> In drivers/hid/wacom_sys.c, wacom_wireless_work() unconditionally accesse=
s:
>
>   usbdev->config->interface[1]
>   usbdev->config->interface[2]
>
> For a configuration with bNumInterfaces =3D=3D 1, those entries are NULL.
> When the device supplies the wireless status report that schedules
> this work, the first access to interface[1] dereferences an absent
> sibling interface.
>
> Expected behavior: the driver should safely reject or ignore a
> wireless receiver configuration that lacks the sibling USB interfaces
> required by wacom_wireless_work().
>
> I have the reproducer, full dmesg, and test logs available on request.
>
> AI assistance was used for the initial static source analysis and
> editorial review. I independently performed the reproducer execution,
> crash validation, and upstream source verification.
>
> I have previously sent the same email  but was rejected due to it not
> being plain text
> Thanks,
> Indrath
>
