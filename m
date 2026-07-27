Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085A40929C
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157186; cv=pass; b=nH5uGjmgvHbF14OefqTdIBPBVd1ILTjK+kep7CMrPRVA2plcQxtN09kh9PmRf/5KUnzyMECtep+ELuKF7olhfky/eogM8N0PtMm/A0Xux9hPqI1EAOyh0pibesft+oqTq3s8WXeAQ/LyB1t/+xY600X8JWLxTsmS8+Nvaj4kYb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157186; c=relaxed/simple;
	bh=luUc9ZQFmCjynsr/029wplBmFfuONlqLQlNMir6ffmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsH5+yhBZokgGMReNooKU2foZTwGF3COx3XmAui3+Nvx1QVfhl7ovJHXpLBE3H03qBK7sgAgd36ublumMWQ7pbKNlgJ2nzcLrtvTUv/XM3030t4XMJxLlwJV4XcCpEkN8cKFgz3ZQmgw40RwTmyTg6nKxIjda3bpO+7jm50815o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq+uwgTQ; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq+uwgTQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80cebd41372so29046997b3.3
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 05:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785157182; cv=none;
        d=google.com; s=arc-20260327;
        b=dkRq2FLQ8JU57/gRr1UCZxQYaKO/1TrA49hfE3pGRk8X7VpNRBAXO7IcwQKrElXHTO
         y8KgMzKNnLSFci7I2P0E4ItUDnlaPbXVz2VDac+im7dnC9PyAIxcuD6ABANDqja+R1yS
         eN5CibXklDim2EPSqIGgBrcBqkSXTuJFheZAOLgffFOTKgATgMd9ptaUzK7zBirL1vlK
         ZWWzY/OB+VBqagFUw/6ncizJ54TgYfe+au80cWOT1u56lFNLhKyeu5KGtpoiyYGzubEE
         tmGnrb+RCARBsiQWUfEa2lS5SkIpGKVlLSxrHGUNslxjf0LO2Fkeho+DZ35iBgrwOG7s
         7nSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        fh=HSSoztuXrNDMv7+ZlkoBrH2zewPqwL1bFLxCpIrNUls=;
        b=GvSV1sglxXOCdCfTihrp2d0k6EvaUaNVFAuuBtG5YVGSTFEE8dpNos3DBB+YhEQM8c
         1UitBlsobH8l8kL0X2C7oSZlJ27seFS706+a2t97QC0TukgwrW3EQhJdxumV0IyIzIg1
         xui6OZY5DH/IdZmhGDBO1VhRoDrNymEHH5nMduUWa6E1ZI8Xa1iIWfjLRJmfaLN2ddEY
         73Nv23uTKXbrsz0CYjOELMXWV6Tb7ttbamme5J7o8qLAeDU5UuJOEPAUMt8SQZ7dbz+J
         vsN71k+xXVNjPbK2/PVJAmZL7SU2sLwnxjewXKdo8zgLMTIZaxEo3GNtmgK3f+ai0QI0
         YCgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157182; x=1785761982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        b=Jq+uwgTQ0O1mmHxnBGxWcL+kdE/a9RtHdIP1tjT7Ei9n+xl4gDgXDSpklqMXUWUDZJ
         ac+GrumYYzSuNYK88A3/T4fkN6MG4wQqkhyc+crip1OV9Ijk+VP1IqgTH+CDfXD7MNfK
         izYR0QrNtnZH5422kCYtXpZUgaLbeTRubkLzot33FEHtm/0zOCL+zY/SYXVb/YZMHfi9
         1UT3syyMpKMiD5iEheioIjGtc40Mtnrnje0QPSkcU+JF6Fi7cbHX042hz4Kxs0mUOVq5
         ese1af/Z/IOALMSRWCj+UGhUzDc90HKs6jlW61M0+1P4+BJjqXHXw0K6Q6tEdTQomu6E
         hxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157182; x=1785761982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix29oOBbLOf7nlyiJN1FbRfyq7KaaHwmDtcPHELsDuI=;
        b=Vuogx9kWoQH43Jf9cPQ+pI1+o3/pSiCNFA/MSJMBVwS5pCTn6am7H0oJdAEYxvE9aw
         eFZUNT1bOSsqYYZPyuKPARAha/crkWe891WQqUydRnRwdu8HMPgRkJQ+dGusJFefltRl
         nuKtaMu/pvj+g47nKPDFvbmmfB7oq/usMlXy5rg6r/gEx1bEJ34DBJ1E3MPD0on5OCBk
         QpDbx0emhh2WRS5MXdGqDC7AwN1hQo/tX4O36rtxXbPmOKQOWSsQOBITMIlh//AvA/T4
         cN4SH4RRcr9O7fRSHIzsk/uyb1NaLgkhtbFHwbKWbW6/eVndPc+dHPKHzL7WcC4IpEAr
         xnWA==
X-Forwarded-Encrypted: i=1; AHgh+RoEbJIOyO1p9YAUuUJKfqYD+qeWmSv/U+poBBmiY5jbIwY0ms0MHji1evg4kFH3ukYWFaiU7e9NeCf9/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhS+aAJJkRgABhObU33GG2liXT7CXwtyuQO+f1LV9VUvphN3dN
	GvvX4XwAkcgA3Yo5YeAMEHN+TELhgKCty3pX1m6UtlpkJ8elrCv6hmGR7GrmYaJB0oh5cztsazW
	dp2WM9EQ8EI1d+OdAS6Ic7G2LKwCXfP4=
X-Gm-Gg: AR+sD12/B6wW+3uUviyb10FN+NF3Lmdf/Bqd7UsN1Mhq93IgXmEn+nAR4RGlPYKRoZA
	uU8DVl5e1RPk36avqhzY1T9upaEVY30mY55OPN3Oiniu78yA8NmH1Fz72UQ8wPHV8HbB7Y/dejX
	aTTS9AEavk8ctSQyju8irlmRZWxp+xRT5qXts42YO4C31o5Y9YtYx9z+iSH7uNpTz3kYju8Pxku
	gfFWxp5gH25HzFkJ5G8y+G0vPY/tDpZk3L9vESpoY31pr4g0m+OAYae2f78dS6HddecUQ==
X-Received: by 2002:a05:690c:6f02:b0:81e:97e2:2210 with SMTP id
 00721157ae682-81f69ebac17mr31274727b3.69.1785157182142; Mon, 27 Jul 2026
 05:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
In-Reply-To: <adcfc6f2-3309-4496-8331-1ae31e85d363@sirena.org.uk>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Mon, 27 Jul 2026 21:59:30 +0900
X-Gm-Features: AUfX_mxOitBR08KsPWHGWKTOhvBmlqBsOevQYdsbBN1kI3uyZROYcZJFQfRk1pk
Message-ID: <CABFDxMEmB=5UZx6RZgFNZyB5sg-+e2hgx_T1QjV0JzqP+auTFQ@mail.gmail.com>
Subject: Re: [PATCH 00/36] treewide: remove conditional returns with no effect
To: Mark Brown <broonie@kernel.org>
Cc: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Borislav Petkov <bp@alien8.de>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, David Airlie <airlied@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Julian Anastasov <ja@ssi.bg>, 
	Leon Romanovsky <leon@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Matthew Sakai <msakai@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Mike Rapoport <rppt@kernel.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@verge.net.au>, Stephen Boyd <sboyd@kernel.org>, 
	Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>, Thomas Renninger <trenn@suse.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tony Luck <tony.luck@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, 
	Yazen Ghannam <Yazen.Ghannam@amd.com>, cocci@inria.fr, amd-gfx@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, dm-devel@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:12=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Jul 24, 2026 at 03:45:02AM +0900, Sang-Heon Jeon wrote:
>
> > All patches are independent and can be applied separately, but for
> > everyone's convenience, it would be nice if they were merged through
> > a single tree.
>
> Please don't do this, it does not make anything more convenient - it
> results in huge CC lists and makes it more difficult to work out who
> will actually apply things.  If there's no dependencies just send to
> each subsystem independently.

Thanks for letting me know. I'll keep that in mind. In v2, I will send
the cleanup patches to each subsystem independently.

Best Regards,
Sang-Heon Jeon
