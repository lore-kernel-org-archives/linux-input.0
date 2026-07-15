Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6E420484
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131690; cv=pass; b=pb4aOXU61ZNNNzD4znlYAvwpp6ZEWhf5V98wWzpEX+YJkhKAuhT1Z1nBsUN+Vs6jh7d/3YPoyux0r4MYSfdXNDBukH9aWiZKF+pRR76jBq0T3byYqaCUgz4F4V242+c7AGnskEMjXzea352z8qm9mqihcdK/WGi3UWwlwkLj3fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131690; c=relaxed/simple;
	bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEi4RGf+zZaeWAEtt6PvBOwP2bXCnPsAICYZiYELNQFXLjDblYOw615GqfxYJ85w/QnRIDttKxbT9jTXy4ZETldKxGxT0U/4PpBlA+leJKasjfs4QmCsxVvGC1eKi5afKgyGJW/+gzQ3dy3KU59yjDjAZgPviXzGo7Ymn15ENhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu/RPsnf; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu/RPsnf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso436280a91.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 09:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784131688; cv=none;
        d=google.com; s=arc-20260327;
        b=HhjCLBRMuMKGDWNyPiXKKAiNjx/vkrFGBaiulySJmjfqAOENuUG1c8cXN+8MVXyrRW
         +TrD7+mk5XGX29WftNLrjtb8EPh2vR9Vh3eCM4tuRDVwmSIhkxeDu/JXhmG3KfJ2YgRl
         QddCydXNarTIVE1ayXYENOV8JyuR67XuCwW0xt1RtRCQII50pV9LNs7BlNZoLLx8EQa+
         +6cSIN18iI/vKBA8QdSfbO2XC8giIL2eFZSBsjP8ll8pfg723Fh3KzsSsknfj6Fs858K
         NYQRjA9QhrZrg8a2CexdQXygStiZzoZUUrN2+Pzn75QqzAqOEizAaceNYhpEwsBMuKxF
         xfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
        fh=RaT8e5Jpv5JFoLYyR2jyux/Zj92KpSmx7Ik3dk56sVc=;
        b=suFakBZ2hoVQd03mxUWBaZrZUZnCFMpSnVMeYi3NbSwKb6ksFO0SpAEiEx87SZYMl/
         aVvibh7FsRntFfDRy3kzm3vj38DoSeF3d8CHBXnFzUWrgGUebNHgDjg32gz4hrXgGDXh
         g8wwmoJICELeymC84QPVVogj6tiPOfzKZebkQ4adOm6AkAVLxckRmhMsQnUtxKbg6ol9
         ylJ6SltuY1NPWYT2lhc9Jtmuth2dQc61RAx9upn/2RwMpvroKxLkZUsX/UtzWYKQN4cw
         cq0JeCDw5Z847X3v8/4oBAv1TSEMH2GRMTd+Vi5E4mooRZa/XEqsBrRlRyUnXgK3UkKe
         zRlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784131688; x=1784736488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
        b=iu/RPsnfyDqpPchvA6zhbsd8baIfx9s/oUwQ/QZKW95zvN6UyBpVTluxMD85DevFBy
         Pq1jdi8FJVn1fWp8CnRcoaIjj3JvGJIda8YralZEwBp2qFZdEjymXcra7LHYpGzk+vVn
         LbU7XJ48/AlGlAddTaMsHqu89Il+lw0Ix7KKNoKoFqlzGRsc0jWcsZ6Sz2rx8xg3mkRh
         faxQJzNFg1NsvXmOIMIHwMQesX/KIQ8HJDnQpRFjZiBaqSdnEGJiHOJaU69cTnB2ByER
         s6Y8rUvdoPoncc75SVNg7NiYHhwPozRQi+ERuWULCJsYgrHkrVCQgPZIFiwZ3lz9b09X
         vvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131688; x=1784736488;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/CnMUoFxfJHS8Sz8D/SuZ7T9cQ58RayjuJ4fMCkblQ=;
        b=KKJNHyKnJSoUakAf4p5LdrzNVxHHJN46duDrmUQ7rDAfDD0HAPOswCPDFEG6lMu+cs
         mf72F1Kq4pbnJE09nooIIjUazO116/LavXqdA2Qj4ts/VYI3ioc90Mf3p3shHlC8ho8n
         crZIrdPpjt3ZzsgwsYNJZol7Io7gjNlHLV0HHQHE/tAGURshrawb8pwA3Q+b/3ufGHxu
         jJO5pDxJ0fNzfbjZwfvSMKCVoN5nTcFIa0OIxPZqK9b725aTCwcb8Lg3WEc/RJTNSND2
         327LTJy9THrPro9B7lxtGkCzqmRN1pWM4IMKqqUFtZExwUeqGok3ouxNu+81KE236sWE
         neFA==
X-Forwarded-Encrypted: i=1; AHgh+RrkPxGLIafFVtQinCjcpzMN8FuF7/QhGkEizB9DaAlhrIdYTcf5q1jHTvT37+ECW2ovZfHQqEeTdml5ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfk0Od4GsVc1pTkTh/9gPYzAmkmQ0kNnXWjB+q8aBGfj2yTjv
	vBw06myqOZpKGkfqmRREDAnxYDUJhkQrRnsHHUQh90+zdAlye98PbtJJwuPNirSLrrT1vWG8xS8
	4et2WMzBDKWWblwx0WkaXABYXeOsbOvM=
X-Gm-Gg: AfdE7ck50I7B0kPhIOJYdWBg/jmup1uU84emXy4Y19B/LWo7XUuohfzX6iJPvmRb5/N
	rKL2F+CEBemi5gP6Nxf6vqe/PSnRMue9TBWO7KtI9cKCYPeZxUTo3mMzLqoxBwk1bm5wrFx4YMB
	9AN3K0H9rJA3p6g6344obiNP15bW/VwTkSU3B0gIgRVm3ghwsu0zZvPTEmmM/bFCCUqtPlv5aPV
	7g6uKuxzaY9FdEDQovAqTGvw2FMEPpDEJTM2xielTTjGQv4djCSJVjNhZvrk0BIbniaoE/b8oEy
	RDdlS9Giga9JiS9JyH4EZ+x27BI=
X-Received: by 2002:a17:90b:2b43:b0:38d:ecfe:41ac with SMTP id
 98e67ed59e1d1-38e29eb265fmr2851845a91.0.1784131688289; Wed, 15 Jul 2026
 09:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715142337.22811-1-harimishal1@gmail.com> <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260715115018-mutt-send-email-mst@kernel.org>
From: Hari Mishal <harimishal1@gmail.com>
Date: Wed, 15 Jul 2026 18:07:56 +0200
X-Gm-Features: AUfX_mxeev5EctzqqOhnXkkLp1lW-oPLOPqW61BCZQn7an58NL9TZTOsb6yp6yk
Message-ID: <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> > nslots is derived from the ABS_MT_SLOT maximum reported by the
> > virtio device. A device could report a bogus maximum (e.g. -1)
> > making nslots =3D 0, which input_mt_init_slots() does not reject;
> > it returns success without allocating any slot storage, silently
> > leaving the device registered as multitouch capable with no
> > backing state.
>
> So let's disable multitouch instead?
>

So rather than failing the whole probe, just warn and clear
ABS_MT_SLOT from absbit in that case, so the rest of the device
still registers? I took my lead from input_mt_init_slots(), which
has its own internal cap and returns -EINVAL when the device
reports more than 1024 slots.
Shall I modify that case to get the same "warn and disable
multitouch" for consistency, or is a hard failure better there since
it's a different type of bad device data?
Happy to fix it either way! Just want to confirm before sending V2.

Cheers,
Hari
