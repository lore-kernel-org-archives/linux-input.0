Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C5233936
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199138; cv=pass; b=iBpEcBg4pU2iVXbymikrZ7pmVegWNjJ9QBin8+p+6PqTpswfah4Pn2SYJFtV9atFW0Mk8NkCJGu1xfcd8QWbcfic3hZYK5xoBau9ToBrlOb8a4dYrf1i3pDOrrMeQpitOO+AyIQN7CT2gG0VW4R9xlwXnBq+alJrsSOkGINk5ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199138; c=relaxed/simple;
	bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyYUa2CkmqraRcRVwpSkK/VbnWzncyipDibSu+PGZtMOOZZymjlkbgoQ9VKBZhsJAtl8QU/goTPEwwkx2ijFkP62GFJibDZWQ5Dc1bEOKagWNEV89CzJSzeHCWRgk+TvFljENF5eDACk4ScL/SNldS77ipvg+9iK8RF3Ln+3Fc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=anDHoMIj; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="anDHoMIj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1671ec8692so395045866b.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 17:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785199135; cv=none;
        d=google.com; s=arc-20260327;
        b=CpinHmEK6TTaHg8aaTRny08r3itBzsRRnqc68geE5oqGROXcF9/lgQq5Nn12flQvoY
         dbfrwnQeRPKK2nPFa+D07gLITyob3szQl7yPY46J6xlmCo0xGQutDGVgPAFEiDyd+oae
         3xw2eDp/GuPReJGWcwW5szEgLfrAQ6/28NFcs4mCpW2GFFNpTTux1y5VrCPEpUWo2EnP
         oKCGY4m6AiYp/xmRKUBS0qy6g6DL6LLDUxkBg6v/N5iKYQggz/dMUjLjAIhT/xiOs68y
         qp1yAcSqpdSZfy7hMBxlhOvMRxTTc0jSC6r95eNTeE/rBbkmSV7X4BgEblktlXPE5X+6
         57gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
        fh=R+REjkpuKUtHm4ioThjvUHMQuU9tm/qpqx+p9aR71nU=;
        b=XdYG3p5Ak7agLTqEkevtC2Qjpmx0f4Tq1oMrUImTzMMvEU7jI1oGVCjtVu71CVp1SQ
         aAcdeONwP68wFR9kk3ceDz9LyiBoBkk/taSK2zIklUUGWNymch/Fh9DNNuA9OIrL3VLO
         pDCupR93GGYAsPGSPl4Bg3KllSoeshE80NGnSJAcxCpagLp7MKT+Gcu/ILys9GdoHEjB
         iQRq2dSkQsAmaXn2mwMVqzktf1q7qCLBY7lFhuokWHphxd+CiEEUZfFUI/kJZhGawivW
         L2FEsf9YRh3xR1EnR9MmqlEK2YKi4lQVJE8/i9Ssh54vIpWXLxI0ywV6TEPRVZvCFBZS
         uo1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1785199135; x=1785803935; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
        b=anDHoMIjIZs1uZz1CAKc8C0GvNWgpOsLCJfHyNLnsBQU7u3XwrCawZr19IS4tXiRBc
         5bEHLXpUL2Tc+dZSN8VUflxPm3JVLjAJE2u6oqAv0fxcQkWSEBmawXzAu+v2xN2sVk6p
         gRo1GG/4OPKMtFbfuf/+aweEbS0Jk1mcsPLWdDaX7egUPYTbHndMqY7/EHtCwFjM2edV
         7dnwL3x9cSRSdQf8xLTXj7qCbK/esgh+35pNF+b+FhRmYJYseVuonU84fBABf+lfsdwD
         kmE2a7ltB29ZFmBvhgJp0S7dPyEoDpC2PuOziXged1tKlWcTNmeqLRMxX6HY6NhIVV72
         wfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199135; x=1785803935;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VEY8riwUSQV88YndLMs6mCpxJ/J7nAYR1Riin/nQO3g=;
        b=mrGGQXeKNLN/25pQZH7+AE3LvHCNhQCevIAAB1M2QrpSPcuXBPQOqjCbP00tEKICVn
         oPLp46PlMzWYWHTSd8tdoGoTTywcg8/ykIHSHKr5LlGMOIem2AMDxVvDGjIcamkVlhes
         yl0dKD283N3BI2G/iPu1zL7Iw0gAnpCcnUfl9aDZu9TG7yJTy0q96ZMfW6ILHtiaix4P
         ukQBD2cAdm/Y5Q0OABPpLbZ0m+yIpAZieXSdV7GGwrx7VaMEC+3hVja1Yu1bDAs/6YEc
         TbQQeVdI2TT2OXj0BDJUGA5/yn0U9y5kwuBDL00Q3K5msMrW2YzU7QxQMdkBpDhmb4fu
         o+bQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5qSC84oJa4AM6HMYNyAXmEoajOUcQtyxliyNPCb6vPXE2p1NCibBHLkb/6BreNqIh4CZHbNOBM2Q3rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4ZtCaEIiKI6UbZI67UHjzNfooTKXH/pVj0+qGNVZStoWGel+
	MQ+npZFoYpGHi9RC/DLJE+gj850KokPifNT4gKnNtPRVoV7cXZpl6Ukre6EQHOnwHNTiIZYDndi
	OzO4oPwC+JR6HuMJNL2bi7Ui0TQ/9tQHtOCKrFtzkzA==
X-Gm-Gg: AR+sD10g9WQN5z1P+sRTq4DXfiAx5IgttJnx97EDbx7NW1jwBcG6V/T1ZCqpiHHMrUb
	y82HINrBJGzvUGV+/3b+ERQrsoO6gwR1/KH1dMrQVLKZxosIp7qnCzpMc6OQCnOsRPxQ2jtFiM4
	qaRRjSaenN7VDiAQD5QVlcIr8npGOOZF8p93l7kKAdq2HaudbkBqAfVKR5c9Y1AgmuSsox/g/Db
	8zG9bc+gdQAKALyg/LcSkaOzQEVi5nxBNn8gvCpmpwfCigRaHG3uceJ7CbdKNBZsJTsgfuFVERf
	m2knp479WGovLOxWoRdlKigxCtUIITWELN53uNwbn1070RM=
X-Received: by 2002:a17:907:c19:b0:c15:a06c:2bc6 with SMTP id
 a640c23a62f3a-c1f72155e35mr6140566b.47.1785199135006; Mon, 27 Jul 2026
 17:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
 <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com> <20260727221338.29f1da9b@jic23-huawei>
In-Reply-To: <20260727221338.29f1da9b@jic23-huawei>
From: Daniel Schaefer <dhs@frame.work>
Date: Tue, 28 Jul 2026 08:38:17 +0800
X-Gm-Features: AUfX_mwLjrpQ6VsNMrlTbcXvOK1JVgbIFD_CE7r5oTklBZYDx2WyZaNizEqtsyU
Message-ID: <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Sven_Vaink=C3=BCla?= <sven@xn--vainkla-r2a.ee>, 
	linux@frame.work
Content-Type: text/plain; charset="UTF-8"

> The channels in this driver report IIO_CHAN_INFO_SCALE as shared by type.
> That doesn't matter unless we get different scales on the two parts
> of chromaticity and I'm assuming that isn't eh issue Sven has run into?

Yes, in practice it's probably not needed and the patch works as is.
