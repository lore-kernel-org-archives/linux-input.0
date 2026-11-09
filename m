Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202894;
	b=mqCOzsn1navSK6taXJLngKdIdoDxUmbeJbpyE/OzMIrkYeGjMgUJCsFi72zC/Gy/k5Qp
	 8cRBi6RFD+D9t/b3mO6bcY5N3i3ri/lq30frRWWW2s/cc8vbbfT8IpxEBCk+ocA2Vg3w8
	 QyFUmgvWTF6YY/MlgGeZ7iKk4PEzEEzMISEaZ/IbLZaELhq0SUG58VVVtVovtmY8IYDsd
	 sHHFBbLleKun/yPRiLEI4mvaQEfylzy76u/XRsCx2NP3Pna+8xyB0OG6U2GdHcPqnKUc8
	 zAjJU8lEvD+oEiRjz/f5Bin7nl4g4ChRmuIJBHVymXTKth2ZeB2PrI/yzpgN10CM2UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
	b=wdpgSuDbWVNizRbWRoIH/6gxijHull2HavRkIjIz1P4MuZigMftRa2654NwRK8KiTGrM
	 hMyvMepxBAWxjVE8OJNXaAYvY95zNHo7uB/h7lbrt3xI8gsuc/y/m9g1poeFUsoLG6slb
	 Z0nG2rm8I/EmCHr3NgkF/MprVIjzgWQCrxeY2YLuqG5yuVKTPXUxDeP6PXtBKM7E9pLko
	 p8teMTd3Y0vy1jY7KJXNCwmWxLMdOcsIDGUqULcj9kruTVY0BPaF3Bwz+iZTtZM0y+7q9
	 qZAM7TEZINJC/2Gw/TI7znIChukhWAEouLgeaLPJr7sZb7EzuURPDxhGON5eQ45DELA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ixTT0Vsl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109A606A322
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 05:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B109A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ixTT0Vsl
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679334baa1fso540010d50.2
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 21:41:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794202893; cv=none;
        d=google.com; s=arc-20260327;
        b=BvmJYCEGOOaNcEoIggWptHdxQNAFO7fcsypcUVxHa8SV38UECkLrwgl7XHEG92zQD5
         gmLVZe3U667+gvneiegeA+IFDjIuAsIExfu1UM0NbQTQzR5LI/1ORna/0Bxvdoi+2hsO
         EnStGYFUF5IyJp5VtrXa6VGGRC74Aj1cOLrWj5XZE6OFCP0csDvjRqotDQR7iNIDBT2D
         sRlgN0lrZZpO3HJkCeKwVPf8G4h1eIQWwRnEt8byaGVKB2Grzpwb3/rlMAirJw1LHvjk
         DHUUDUQSZiByX5eugqYwiK59kLrjlvupe8cRToa8Bxp4ypPlLq38w5xQ4AiKMboS14DW
         ns0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
        fh=K/0OC7MV9s2hIm/hjrnz0DGt3qXp6bhZubEmBtywMQI=;
        b=S6fu+Q2Cw/wqlA0BzUJo3V6nPPwGICDZ2v8Ijy2YwdHRxkUv+adflgeKADA97k7ARq
         M+49CQ/Rt0msab4WXapCFfOO2ifLsZZvN2OO3rck7GL4DgR4cWpu4RqnyAyBFMbMIRVq
         mBctW+wclQdEPXDEozF/i08/FziJYDobjiQG3MRICf/Bp+RKJ8sH0+uduTqx/Q/Y21+Q
         LVXrpOxDvglCO+BOev6TCt/rPat7cJmupbRZz8qLWqOjE2sjczeBT2LyCPx3l9LBryzE
         vlTGmrmilJRSRQL67FLvW40dqJf7XbkT53+NrfjA+8p5XAbrOqACYGBCKKmVa5jU0zll
         +v3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794202893; x=1794807693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
        b=ixTT0VslnQORGwqIpda8mBfOWdfApgIl4gRZI/m8GqCr9k4vgh64erx6ypah6o0/ei
         FQqLI8k1GNwoShoSH0KBqfUziMxq4Ouh2W2Y5bKDiFEJ2gweCdL/io5mWG/OmENupnE4
         dgOx6HmnuVCdpk4b220rL/apfUh5F5gOC4pc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202893; x=1794807693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
        b=r97WZvqFBoHQ1UGPYlX8XU36ckyib9ii7vZwg+DCa9I6UKdGldPlns+zI+n+VkUiOH
         HUgltKbhvpWgikmfQLBFwOJe4yFHY1K+I1uo9JiBugvBobOcZpjH1/OOAOcuF3kNuadn
         v3cD7MhpZaJkOcxVKhdRRRLYrWWD85mY8IRX/oZr3x+ZnS9nBZ8RrI7mT0fcPyG2AJ2n
         cAY21ZUDfxXGbpnFgQvuKmrGkOsg37b+hLmNBrQe+HEnYWD+w8SOdUpcwE1I1DhbOl35
         JYE9vslL7rby56UEtgBSLFyd6Gor3QsmALTqrO57FNrlUGS/D/gElRfebTCEkZPJVW1q
         tm2Q==
X-Forwarded-Encrypted: i=1; AL+hErEq2s/MjlP5pmJDEms6V/nz8RdUc7PHzEsXwv7mVu9Di6FVPvBRVRwClovPYC3MlPVCajEkvKeA3NqMvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9O464tGTp8COX9xt15Nxu6fxGxlEiKG7agNny8Gkw00Q4goX5K
	CP1q2nj1UFyFvDTZ+3BbHMnrFZuikdXRoDQKlrpYw3ucZHZVxukiVigADSkMeyAFfRs8leOk3AR
	z5qOqdPni7/Cf2omJqAjfzT6E4eB41N2Wzov8GSQP/lX5mEib5qW1ag==
X-Gm-Gg: AYBFou2AIJlJl6Nf4bHgBeJRE/BYnXJBpX+XhfDbfDpvhbQIBkfCc4RAG6mWmoTKG/L
	sqWSt7snMUG24Yjk9qIWB3q79aEOwL2TC3AA7FdGmtJfvSVvw0snXLvTMONNsdgmqOjDGz9ZGDi
	MjJYI5JJt/+1Pg5CmtffEiHw9UOg+oysbuTb6wnSi40zTbRK4LE4wSL2SWyJC8BS6e1frhffako
	Xtg9guPcdMqkWWWL2w4L2vZ/XQ6HOEZJ+KuWXcafqS4ShDXqYiMAD4rHZR2Y47vlv6DEZQv3sye
	5EVo4lZreceAkLRfuXWsux/KrWrb1FqoblW8+tWnea4HZUZMp/bnoLqB/Rkv8mwEFY3TM7Xtjko
	0oIB+OYSK+KwY9dSzbnona3Y3pPsLqeGdBSJA9w==
X-Received: by 2002:a05:690e:4393:b0:67c:10d:e377 with SMTP id
 956f58d0204a3-67c3d97b42cmr874807d50.24.1794202892850; Sun, 08 Nov 2026
 21:41:32 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103043734.2179858-1-wenst@chromium.org> <179406980914.3424803.6201831446824678583.b4-ty@b4>
In-Reply-To: <179406980914.3424803.6201831446824678583.b4-ty@b4>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 9 Nov 2026 14:41:21 +0900
X-Gm-Features: AclHuK9Uis4PjHZvlrrahSmg0-iKCJazl9kKs9oybOBLW0q8BipFSNFJ0jiQ-bQ
Message-ID: <CAGXv+5G1SozUuj8v64oD07wz6dFbY+bXh-Q3OVvieY7v41ZJ8A@mail.gmail.com>
Subject: Re: (subset) [PATCH v7 0/8] arm64: mediatek: Chromebook trackpad
 supply fixes
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 7:25=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, 03 Nov 2026 12:37:24 +0800, Chen-Yu Tsai wrote:
> > arm64: mediatek: Chromebook trackpad supply fixes
> >
> > Hi everyone,
> >
> > This is v7 of my Chromebook trackpad supply fixes and optimization
> > series.
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git =
for-7.5
>
> Thanks!
>
> [1/8] regulator: core: Add "enable and wait" functions
>       https://git.kernel.org/broonie/regulator/c/9f9bcca6adc3

Thanks! Though I was wondering if we could get an immutable branch
or tag for the commit, as three other patches for separate subsystems
use the new function.


Thanks
ChenYu

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
