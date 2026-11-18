Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795030266;
	b=z+3X37+946N41HAeTpyf9tVhzNtKzGFbq5DGkPV5nqDR6isu4YlVyAMsT2wVB1b/mbLy
	 /CoxDJaU/BYsEo/SvNHUmrMIN8xTocvpJ6SdZZCtrH7RkRt+S/0T/3f5EvIGQee70pBbe
	 hbRNSgixZ1BQ8w/3kEOqpydEvADODM//5Z12s5Okbxyv6oPyW2e8hecg0P2Rj43kMUlFT
	 HvIPCtf8dT2tacRnmcIfP4sNXZRpRQsu4Yro/e4S+KLrhdwxP6m0+lmbXWc56Wymcm+Q+
	 BxAUDQtCKVEaT1QCaWTxWA8bz7E61SBwFLFfTXba9DFSRyxYgsoRk2R5TR5oK57E79g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
	b=LaeWlyLb8F++qilbKTqx+DBqeekwcyq3GZhxlbfhcD0/Lt4cW5VPlS5xtGtSUhug/w4Y
	 zW9eg//L6Payt3UpT9Of99snrZqlhqtVJ5n8+whu3zogMtLbvucdLJLEmy7mx0qu6Gr6N
	 DPzLo32uRq5SqxIaxfxDR/RGIQNM1oBHP0D/anY1sdXeaCkuYreJDfOi2/KP9TVw6/3PB
	 aaneydFliDZSZ7x5RVNHEAo/Nx3IouOvdXZb3hmY6k2lETQDjs+9coIu4bac1RWy04Tan
	 4b2NPzFhxK0hhGEqcILTNqq0Yi4yQbujcBXGum68oz2Ltj+ZyFEjtvzdNw5PxB+OflQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YYTxxlax;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F2606F50F
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 19:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61F2606F50F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YYTxxlax
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so211581566b.2
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 11:31:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795030264; cv=none;
        d=google.com; s=arc-20260327;
        b=XU/ZUo+pb0wmqyw8SIHYkFGp2LB8Nxuf7DkTC2gsyQUQfAMWd4h2pnxmdb/sN+D28q
         HFZIr/i1GskopKqqu8ZnVBpVMTs5FJBsjZA+L4p/VSre+ArbDQDbkGO/7n5dq5tVF+VC
         GVCeMn7qAizeR62eX9knOHUxnk30Tj4Dx9HlnbrRh1ATeN0jUDk9x4SH/Axs6t72xndV
         ISrTsVpkImJMqoqdRuqeont7xeL0L4tOR9GsC5VIWGtBK2vnzZfccCTwpsyqw1IdYtkh
         mqffH+nEEO8bWJj0SwbJMOvKPHn/JOnapZIkbq1FVwD8/+XdF0zvRS3940hs7xcCEa9Z
         NAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
        fh=3ioeJ6tNPKJUA5jAZ6G06loEkPDvmdka4KTEurNc09c=;
        b=Xy4FYhLz8GigZBs7WaB7YN8Be0WV3l0OnrEhq0Gz7wffTT/GYS9boYgt+a5Oxx7nRr
         tn7siO7rrViw9guH9k8hwydCXsHnH3uHzCXLexBuIlCckUk1Gr9SGbRkrICs/GpYARSM
         xydPc2eeaHQOBBXsl0Zb0w8MmFBwM1w1BTKjs56qvJJZUZLSMvRgKsK1KSFgOwXcWhkq
         PEEbXZXt2m7I5OSe8G2WwlCGK4ra2IWB1pKwXxiGsV4bPYcHL1Kb8hIQUpSvC4rFJAEQ
         zD/q26bwuI4FBRzxdA6IM5OUi4o+6XKt7VAY3GZ3Db7NEaRT24O4viA/R/cl1d9IDWlM
         V+OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795030264; x=1795635064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
        b=YYTxxlaxQ2WfhHso/oEI2r56Wf/FngEvX4IGgjBf48e9sct9kQaN5+W9clSYP5LlZW
         9lGoVnhGTEg9+TUbmq/jjF0sC+rmU+Buy7VOy6sH/tPxGdqjjnXGgl2MbLOCk/+k9Rho
         IZJxpHNo6bOT5jZstLoYdAJHZylRxqvtOwCldTOD8whfdnvEhqKJXAdU83+/L7lRIx9v
         fzcCiYcUTwNu01GC9OfJiH6YaqiVEysh0kMaSWmSU8YUIYlmG2BvarbXEefoJFvoMsw5
         PH5l2eEIFL9NtYcZ9lHXeSizazga9SFSOqqZtZ+ipAiyUSM6RiF73meQ1GDoIrwk7+Wd
         OScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030264; x=1795635064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iAbjlXus0iw2LllxqZoryy58tCqmnnXTzlAaD4u02/I=;
        b=C6XhKnpxfzRjPw8os9/VzyE7kAh5WNDfFkkZsdNinjYJ2HuIfSmNv8Ldcbz5MNnl9u
         YEm7NN6nzv4GJd82T/BXnVVR6O9t7+ENUtzBNIbJfZuBKk3mDZMrrAbkp+ccUl/Feov6
         Dg0WSktvaeoqK2/fvrIuRxhrKOSf8UiMt9yYBtTYbrkVT5nnDoWUQQe4UqDVxcnhtn0Q
         qUaSbcQUHs4yAqH4rYvcXkROS9RpNR5lsXsZmkn3npkjY2nzmSBwf7ZxctV2ECC6PQ4b
         FeCouGB/qlJ0cJ0FwM8STYLKc0RgzD1HPgxbIDooxgsyp17k6z34rxi8kYC6jV2K0I1G
         uX8Q==
X-Forwarded-Encrypted: i=1; AL+hErG7uGWeLI0/IDg/hRnQrfyy4wlPXqgLWj4b2h/C7zXK2fj+1JkCprMGRnrK5w7kcnr5qZVAN3cY8Ln2vQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ShekHRFcP2PH14iEnTkZ9HkQ9SDuZLWXR2Or+PYhfHrxD0Uc4
	/mj2YV5l5E45y/xiFNnu1bOhZNkKspytPke1b5kDDRyWK328tG44XLl4TgJHUpOBTdalEe9ilcG
	BXUBiJegRan0KFU4aTHJUszKFuI3WrL8ZwfX0VQc=
X-Gm-Gg: AYBFou2UtuynW1N6oaWq0oXal41BMVh9noOdfn6NHn+48FijhOfjpP8IJuoA0X5CvRb
	BJRYFRo7vyCMQ3p0J09HLL3kpNJRass7OeRFAOdHw+SWK6TzJ8o95/i8/Yxus70nJ5w8Lyxykev
	MCqWKCf2o79FIOVZP2lfrUhCoTESNV+w+CD73kHM1TcE6KSgGG8Z5cQTIoDSLC5Zlh86o8orB5u
	7OlOJCuspXAoN7jKOhhtZDjU4HbLjkoZFKesH6lUmbpJEk+LOBLZHPhqLjq/JPtMziDDnoTFPl5
	w1ZuaIaLXiU/NPHLoJk8XDDbAAjNpefxG6heXxbhLF3Z+Bvse73K3LwoDtGUUOwZyMy5PgWMWIp
	AVJwK0R7WvyhtWyasp1H9F68VbS4ALqnG1Ac=
X-Received: by 2002:a17:907:f816:b0:c2e:317e:d711 with SMTP id
 a640c23a62f3a-c510e398889mr303013866b.27.1795030263845; Wed, 18 Nov 2026
 11:31:03 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105194426.1113050-1-l.scorcia@gmail.com> <20261118152346.GC98456@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261118152346.GC98456@joneslee-macbookpro.roam.internal>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 18 Nov 2026 20:30:52 +0100
X-Gm-Features: AclHuK-Q_ZR_eSDZWgs8r4i-RTkFZUMV5FI3ZV4LgWAQGQjLtUrjcLbEIObtllI
Message-ID: <CAORyz2+7q3BTeW3NsaiwN9riAbHV0Q_tCm6bBV7RoiDeAbcLrg@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> MFD looks okay now.  How many more Acks do you need?
Still need the regulator Ack. Mark Brown provided an Ack for the first
version (almost a year ago) of the regulator patch [1], but it was
substantially modified in later revisions so I dropped that Ack.
I'll move Mark Brown from Cc to To tag in this email for a gentle
ping, I hope that's not against the ML etiquette.

> NB: This patch-set looks split in two in my inbox?
Now that you mention it, I see the split too. Weird, I sent it using
git send-email as always. I can resend it if it's an issue.

Thank you

[1] https://lore.kernel.org/linux-mediatek/20261105195206.3440-5-l.scorcia@gmail.com/

--
Luca Leonardo Scorcia
l.scorcia@gmail.com
