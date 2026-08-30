Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A812750E6
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102367; cv=none; b=DlYJjB/VOtzeuVAhxmyGSpLHngQpZgtHw+t6Dy1CJ1ZZkISDC9RSlAmgYhBhfB/WYhV9I7SCb7PzkS/Lw8NoKM3ZFJmEEf4ihhFfvHxG7q5F9xrF/6JguvLjJmu8/4616iVix6w6v9Ct6bIDb0EGhTJVz9XgEURaV5S1psaZHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102367; c=relaxed/simple;
	bh=Whl5AWtLQfu0CVlY/27d81zPn+/1xmWN9O128g0xJhU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=kifRE5gmT9aOM1YliR7HSdvG1sLSzxEefj13y4bt8+JAX5b3Ox4VNI8Zfo5ksrg4WQZnAU8ZhumNcc7FFfdIA+ulp8QzfjHGFUH2zMdZ6QEZbQGbHY0vnDfaC/+ttqNG3ZdFbuHcnpk1Go6ClNdDI2GKfzanVqUZRi6uZuXiyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/LFkwkh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/LFkwkh"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1898778a12.3
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788102366; x=1788707166; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Whl5AWtLQfu0CVlY/27d81zPn+/1xmWN9O128g0xJhU=;
        b=U/LFkwkhsZNm2GMGzbKw4Pc0O8nbvdyJMiqviJBbGbdJpB2n0bApJK6F8EQGzCyVNC
         cPKmJcIJ/efgNjKXNpRRde7Nh7ja47JzbjXGE0ZHCZy3JyVgMQvNohzL+W47bUgmdXtS
         HYR2tXvCVv82KYT5AmFAQl8chR0Jn5PS4INGgyf5pDPieXsvtv+mX4HFGHzdZLTBbn54
         LGfhw/bQCvL/fxTSn6i0YyAjKCaGCAseeS0TC4+rcbLtdtC1SmqHeoZy/gFWtYxuqLLN
         oFtdihCy15HalMGZpwENWCSjQorJEKJLH01DTqntMkm2dhjWiYtVwndUi8XxI2Y/nT1j
         Fhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788102366; x=1788707166;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Whl5AWtLQfu0CVlY/27d81zPn+/1xmWN9O128g0xJhU=;
        b=OFPKilCr+MNMLtsRCdSf5qL7L5S45v1XcgWkRlG83eHfeThLTXmYdfXSMagxAM55bH
         JrB1coLNYh3tG7yv1HxomzETgdgUePNWEKGo2ZDoJvOL9TE91S9JWdCnyrvgSs6etkL6
         NgR/VzKhbFTvHi6w84FsHl9mx6UWrQSHHSV0ITDtc9lyjTgO1v9k9U36Kl5scexeeSQC
         Q8T2srJEsXn4i1BI9dvARJmrMbfMSFIYsYKjfPl7MLFCsKsxaKmHHnYqg1XkM4WnI4aO
         7wXTlEWGQ63hGgiO2CTIcIzj6BNtNCrogaPd9wJTCAfzCM8lWzSvo100LEDkwwzVrdqy
         UZcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMmvHutl23xjDV74j95RfDWscEDgiFsUzObAHLaD6CtUAxHsMKth8TwoYzTDD0UzXDYzXVrxWNac2wGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lQ43f5X6/YCzwR/X/6+RksjKGpmGwvyIdE4eIT3C/e4H8eITGY
	bbzg294hUk6p7Tvl1OcX8ZwWCMDn3VEsQHAUUF5F1LlHYd6cHYiIL4bT
X-Gm-Gg: AYBFou0TrgUBBHCvFUKWqWllVkavsKEDnf274DBML7hZNxiRU/bm+7SpqfEDYBiDEzR
	f4CwZ9pfRgw8QezCz/pRCuPKW64nIzRz4CJVmfwb8F61C4mKBrPXyLQt2TwMPiUEUNAnS5AauOj
	qm24KFGJC2JFW6zHgB65yRiYa3NfO38cYblR5FGyk3fkLgTPIVypyDzJEOTnXyDxt1au6Z/gadn
	JU2iH2VIAI222nft8WMoxfHxfticfES24nTrBPFN/AKf3oCIvsstLMN3gHW4et3z3s8s9Ct4PPT
	MTQjXXmx4vIGK7qvVESZzCV0VcwNgDRCdchJTD9xMl06qwyFQUiYRnuuXH5N5f8FpLpM6kJWEbw
	QjfDkbwnIkElGaTcFQHrRkqDfMJhQ4+30hocwJdiuGrLTeRuymj2DwqadjWqPnvqWIFni/cTWw8
	MONljoT7oMjfsDxZx30uoIw45GbAvMTu9TCEgVDKZoyA3Ke6+WFnZbbO6ZdPBu9jI9aFTZfHEW+
	bem6ynnPadBUshKgVm8ERQhe5pEJiXV7XA=
X-Received: by 2002:a17:90b:538e:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-396d0e20f00mr33757597a91.5.1788102365812;
        Sun, 30 Aug 2026 08:06:05 -0700 (PDT)
Received: from smtpclient.apple ([2409:40f2:2043:7abe:e5a9:be2e:54d5:bcfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea80edsm16746905a91.1.2026.08.30.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 08:06:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/5] HID: hid-lenovo-go: fix the FPS mode DPI request
From: Aditya <mradityadash@gmail.com>
In-Reply-To: <CAFqHKT=jEGuDrR0Ci-ybJ-QZrr=0oejr-2hLjEKyvPnxUCvS=w@mail.gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 30 Aug 2026 20:35:52 +0530
Message-Id: <D8651095-5ED2-4749-9E50-D61966AE2CC0@gmail.com>
References: <CAFqHKT=jEGuDrR0Ci-ybJ-QZrr=0oejr-2hLjEKyvPnxUCvS=w@mail.gmail.com>
To: Derek John Clark <derekjohn.clark@gmail.com>
X-Mailer: iPhone Mail (24A5390f)

Hi Derek,

Thanks for the review.

Upon further testing this seems to be an unneeded (and wrong) patch and has b=
een dropped in v2.

Thanks,
Aditya=
