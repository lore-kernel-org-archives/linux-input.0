Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632502046BA
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333007; cv=pass; b=Wd/zNc37tB9HZ+XQO+w46g0OsGiHk5s/BVxASkuI/u8mFoYLEpC9EEsECorKmW8pFYtg+AXbMBwH05EA17a9EVZpWOmgjGmkLXKwo+RkVuBNDU7kTsBcPZAtFnCldvRhzgmD4K7mlrswYZXeQgwF3EoMHiibGwFPkRKDrI/IKls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333007; c=relaxed/simple;
	bh=IFML3rF9djtar7SwsjcOXZQUh4NL6BJakKNcU6x9ydY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKWik3MeA2RYzlrzPK2GvFCbmwkbM/zU5il4NTIZvyU008iikE4Uje5DetvSsUCVUie+Y2r5908EbIAQURv16SgQqFNolh0a1YdlipXaZ0/H/tt1H62z4kBcrmB8bsPSesW1F+cJ4vgu7k1UfenZjNXs9dGevNyTBCJlgQVk9Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XZm+bugB; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZm+bugB"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8111c0c7561so28557687b3.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 03:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783333004; cv=none;
        d=google.com; s=arc-20260327;
        b=aH8b04fn2Wy4hnwd+0CYo620IAKAg877EucdwgsU9mmuE+s2bO56fVBzw/ybmutdDm
         fq/nCxvdAfkneFhxsffBlKvazaokOpY6kTwFnRb7DAg7Mz1kOhIB5TSIqRUc0aI8YDaZ
         /U00LiacZnC/DXXteVv1S8rQ70jsuLiZAbJgd+2v+/ZPVJLrXb9PGyIcPOlruazgsyte
         WwH0CwZfvKGiaIISv1ONhZk5syyHtHV4MsHXIDwZsABPFm9qU7ET87rw3+qYXyR2OqCM
         Qi77JBn3A0o/pXXvBSZyXFEucFprRgTp2/ltm1LnQYjfNuG8OcXbdFgXJxH5cbaQV113
         BTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ZFMxJ4WY9L/AhejN1XNCOeUtwifJmbyAtlJAOc91pM=;
        fh=UJRXYo+eZpXYPMSEw5ofmiWF7Hb8hxDEFWUZa351GwE=;
        b=rM8ZkxhkC9tiiP2d8JPCX7QPjGnYGcYHBKfdYZaGs5rm/jpjHZ7rAkkzIrR4s/NxAT
         yD0ju1cGjwnFHxb30n4fBM2oFgKE3QAT+0Q1/p/Xit7rxLjj1IiMoUlWCvJOPLiJHJnO
         QdvFCfgL5sphf4o/L+6tZ462jyK42fRO5OzBK2/Ou0srL/Iff5mJyMCSLzy1q4uk5G6N
         Q7kp7mydDVqyOCuyVzwKNu/lp7s7uiE801AY10TAYdpRBAc6QWBlY+bOdnsXrZIqIeuY
         AKywWVqYgV/7actNjfl6hktlpGe7zf8ZHk12HzPCI7ZgKaoBlfTclfziaPfJKuGj4v4Q
         3s/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783333004; x=1783937804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZFMxJ4WY9L/AhejN1XNCOeUtwifJmbyAtlJAOc91pM=;
        b=XZm+bugBNlaiFspxkELP8pTjwS2xLTLuJ6yW8hWfWkEs+NJyx9j+jDupw2dCS5lj3o
         rY8v6Rc9886wfchIMH6ut0KiCc/tvaPxRAah6duWryKnMdgGZbyDYDyZTsLhCq51e6jF
         6a9TekRA6qvM82Y473syY1mIzsduC/DgiW8zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333004; x=1783937804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZFMxJ4WY9L/AhejN1XNCOeUtwifJmbyAtlJAOc91pM=;
        b=jiWwX+NzcsUbn5sz3jtC08qPw59gQaMzPworfruzPoATji5nQiCL4cyck1m5BFrMmn
         2NBORxkww+1PEohD/qNdj0KRKU5arYbiWjxUwo0uxfQUlJAjA4Vjpr8TTBBoP5PScEOq
         fo4feihlovAxc58UGj82DdKaaKg1ilAEgwkBKe9xtjc1lLVrLc4Qkp7UHZCJbkO5K97l
         NMvCGEMjvt69uyX1K0uB+NQESn3U6bPfjfdY4HrVwSIqlvAEQsyYcbK0pixDHXiR8iNC
         Ewm1TeeZ5eHn2up8KTNEml0AlhrDMVCWIDxZQ03inr2dLzdX1xA14B62C+BtePYQSo6V
         QJPg==
X-Forwarded-Encrypted: i=1; AHgh+Rrt6694XOJ6qb/qzSnndB8i7ARyWMOkhRyWTazMperMLdDb6jNXrC+FO8QcqMrJngLYiCPpvdZ22017JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVt+tvqNJJu3wcm/WQHp15PI/UZVzgcO6o7xkaFQOt1cGnJfT
	gem0Clvbf6zjnyG/d8AQ0ASO6t0SIex9M2u/lWMHFDlq+2V9PGmI79YmrlxU8IBVVgy6INPkSwh
	4szS/UUuwDZAq7YOVKrj4WoLguHu2fqcoYN8OXQ3OwvKakzVmXo8=
X-Gm-Gg: AfdE7cmF1AJPtDq20UMQ1E8jnL2AtgTHaT1QQBuuP+Xjv9FTkvYsdmekRZY9mm4fqxE
	4arZajZnIy7Q5vONLdD+EZIjxuy/fZ8TPH5nzDeSgPYUmTrAE+verk0ZwCWXYz7O+WuddhG/C1g
	X8+W7ihQUAEvoF0hopKzEwApJ9arDeQftwnZICWggK1VgAESX+3HeTlJr4Ot72caU3WDY7qgH5k
	sG2kDJgZ/n+yS6lzT1zMeNg34r2GaNBHtBxpAUolfiUDmEAS8ul8YXBFbvQk0Mg1ZkFo7G/gMbO
	DBOg7fd9Xx2LL97ZyDs8EBxmDTg=
X-Received: by 2002:a05:690e:120c:b0:652:5567:b3ec with SMTP id
 956f58d0204a3-66652e2416cmr8660052d50.37.1783332545405; Mon, 06 Jul 2026
 03:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703115601.1323491-1-wenst@chromium.org> <20260703115601.1323491-2-wenst@chromium.org>
 <akmZOC_J2ZTl4zLX@google.com>
In-Reply-To: <akmZOC_J2ZTl4zLX@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 6 Jul 2026 18:08:54 +0800
X-Gm-Features: AVVi8CdednA09-ELXrMS4uc6xSUtulA0xKkThvjfCvkhmpOamhA7IkBdQY8wb_E
Message-ID: <CAGXv+5H_SXO0DtN9wjrXyAvuzG+CkYh2-4eMg=biOSsFV=E1=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Input: elan_i2c - Wait for initialization after
 enabling regulator supply
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 7:44=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Chen-Yu,
>
> On Fri, Jul 03, 2026 at 07:55:54PM +0800, Chen-Yu Tsai wrote:
> > Elan trackpad controllers require some delay after enabling power to
> > the controller for the hardware and firmware to initialize:
> >
> >   - 2ms for hardware initialization
> >   - 100ms for firmware initialization
> >
> > Until then, the hardware will not respond to I2C transfers. This was
> > observed on the MT8173 Chromebooks after the regulator supply for the
> > trackpad was changed to "not always on".
> >
> > Add proper delays after regulator_enable() calls. To avoid impacting
> > the boot time of existing devices that have the power rails always on,
> > skip the delay if the regulator supply was already enabled. In this
> > case the regulator is either always on, was on by default at power up,
> > or was left on by some other driver, such as the I2C OF component
> > prober. Either way the controller has had ample time to initialize.
>
> Unfortunately we do not know that [it had ample time]. For this code be
> reliable we need to record the time at which given regulator was turned
> on and then execute/adjust the delay as needed. Until we have it we need
> to assume the regulator was enabled at the time of regulator_enable()
> call.
>
> I am not concerned with increased boot time too much given the driver is
> set up for asynchronous probing.

I'm a bit confused since you raised the issue for ACPI platforms that don't
go through the regulator API. Now you're saying it's not a big issue?

Either way I will add some new regulator consumer APIs to handle this.
This needs to be in the regulator core to prevent race conditions, such
as when one thread deems the delay is enough just when another disables
the regulator.


ChenYu
