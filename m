Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415639;
	b=DAk962d+z4et77X1iSsfzcKukfCdDF0JNIPWV38M0Qzb3aepVTfFFd6yGnm4sLKGcnwh
	 E79AR5ruGbgffm20/9eAvcmIiVSvtbdn14HpAIbbL7W72MNTPLZXoS5ctu85uMDtXWw6K
	 7XOH/OPRkM1nwb/JTaXtCKYBAnIcOZxsYWLW3zUcx+GLoPmKYFQnAtYMFdOx7kSfSEPHf
	 2VHwszOWwDbm8ADSbPDMz/FXL4316oZL/YQShgMaQii1fHtpO3zK0Q5SBfdePKx/7K3gU
	 /nqLUAmIMg75Rm9dddL4FRSl02LbBHKLNMio60/BM5dW5h0ZbtguCZx3EVcw2cAqo1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=R33dPDMuza4ECLYFcFANy1WXUDU0B8B9euDHWq09YZA=;
	b=SnMNmDNUn0eb+9F3eefXopOv5Hd5C8wEggFmqqjZ1qreoXQ47friikZv6GBnn0sgCrwR
	 0kQeJkEvx00dp50Tiw9M4azwYqwO91do6uaIgMEu/sQBg07b4T+SChlw4UKQAXqJTHZ0P
	 /uCw8QoeW8JZgEM2OF/Oe2Z4Sty8RG6q/lCuBRQJ2qzRouiD6K3fpaKYDMyD42nMHmi21
	 VacyDZWwOIG2JmWHeIgKCSZonH+T8ZZ28WuOWbgSbk21wz8WKxOOGBDfgGPeS6dl6cmVf
	 H5opdGO8j/+4IqEqGhkvonhbha9slN+01Y5WxGvgzB11ReFwaNB6thCJgHMxoDvnj6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEqiWOsX;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD4606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEFD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEqiWOsX
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f0918f9e6cso2146505ad.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415638; x=1796020438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R33dPDMuza4ECLYFcFANy1WXUDU0B8B9euDHWq09YZA=;
        b=uEqiWOsXnHL+ewbkdo7xIx5r1ZiDVhi8BkQXY7iR+QXmWEwfgpRUYFpXHagHVYx9ur
         AUCMJv3qG+dGBHgtE9VZTNQ9pTI64ButO0XmSq3/yTH4zc5P5PFyPVGxOJVXyLpsVgYo
         tm+RlvnKVTW7BJOz1jx4YyWKEB+tCZB0gK2QccBZmJHnrzRFNsj/m1Rp+wfRe1fqPYFR
         wNAQRa8aUmzo5I/RLA7+gTw2vXyhias/qpas18aYv4SbQZF0qCNgV3hW4+5YOISF+B0j
         LF9qo2qs7+DTSKamehb1dKg5/DD9tCNmqy9q6VJE/O0zDRUmlmdkPLWaMZP0blZI+AFp
         FN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415638; x=1796020438;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R33dPDMuza4ECLYFcFANy1WXUDU0B8B9euDHWq09YZA=;
        b=QQ+XZKoUubeoMKiuS/3oIN3Wh1OUy5sld/+1xaeTIPY5Umf5zAlMCwGoLKvEDpGSdK
         nV1NoYcEbfEq3ETZahf9iEJWfqsL/YsY0MLsUhpbsna7Qsb10AlD1ru0j7/ssqWhHU6r
         3A/Cm2MNuvfESs5YW0gr3s4jc1CGCj6Go9jD/25D0Jq+M/uMvP+r+hGh4xH1HqSU0pDY
         Y2nS7GYKPf5NypKxIOO0z+KkpP83Qbr8AquLMwLWJYV2hyL5hJMIGh9iEdo2tL5B4CjG
         qdxNMpeFWu/G+ZZq6eMBGySdpjJRUP/xN6K8+BFU81FRw1hz1/wpHMLpi7rMihdA4p7i
         b9gA==
X-Forwarded-Encrypted: i=1; AL+hErG+naDBytOqfHTBq4xPLQpUJlg3gQ24MoloRK4mMXJ7gB93/NS46obj3qaR3jwXd/MxjvJTCDG8dKTWtg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9xUoPBzIVxUeR91mN1OWUX1gSktacduHLYmFtb4yHZDhYExVB+
	sOa3jYD4Jfvi4nEa5TO7liD2iWbkCXPk+KFLve4WTtsJh5T54U4zQRPN
X-Gm-Gg: AZFdTZf55428pepOV8F+QQaFe57w3ereCUlQLGqtaI2xT3txgmONUW36ORBVBdZOR04
	BvmIdAkheblbtAxieSOC/aip258rNH3N3EZQKskE/KvGzsQ1vlHFgS003tyZa54g1zDNkBDGT16
	3SmKm4Xkac+KdPujbpPcABN+KNveOL4P3D7U2p4iCvfaUppdxQ2kHHGDjCddn74Lddf4Woc7gEw
	zzw8vbUuPN8L/uXMzbdIorcE9wrJmPQXU4u4K9ewEaMku3j3P1zHLtXU//BGYJQUdIioD8HgKnh
	DrHApqLSRIT1VbinK4BVkxfEyQbajPrXIxvgcEZx/doQN01sWmaUbMBLJnfvmkvCmx18R25U3GV
	SxB45hhfF0+DHmPa5rClV6lgWpz/yF+0NMl4m6yhT/OQ3xzGqyGMK3yZf61TJ5BWNHr1yaki97N
	ARtBPAyMB/bEI2RvaeXsTz2MxfmsYWICBdkHi0DJe4n2o4gXzdZaM+b48S8L+Do7Y5Fln1pz9CN
	eZGWjCR3BIUzYygfhHBE9LzDPQlSFVE+8jZyITdPWSrWALOPucHPGpGk1cLN9EDGJNnnP9oXIb1
	qZxfB7oqI5f5jLqH96QEQ0W0MZ6xbzmTU/Dq/393Y/k2bh6ay/xTUl1xyU0wdtEqDY3iuO4=
X-Received: by 2002:a17:903:19cb:b0:2e9:821a:5527 with SMTP id d9443c01a7336-2f03f1d85bemr94913765ad.12.1795415638290;
        Sun, 22 Nov 2026 22:33:58 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f122548sm47173495ad.66.2026.11.22.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:33:57 -0800 (PST)
Date: Sun, 22 Nov 2026 22:33:54 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jaewon Kim <jaewon02.kim@samsung.com>, 
	Hyunhee Kim <hyunhee.kim@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Pankaj Dubey <pankaj.dubey@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: regulator-haptic - drop platform data support
 and style fixes
Message-ID: <awPeS7mL5KM2swfP@google.com>
References: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>

On Wed, Nov 11, 2026 at 10:51:13PM -0800, Dmitry Torokhov wrote:
> This short series removes unused legacy platform data support and its
> header file from the regulator-haptic driver (as all users configure the
> device via Device Tree) and fixes minor coding style issues.
> 
> Thanks.
> 
> Dmitry Torokhov (2):
>   Input: regulator-haptic - drop platform data support
>   Input: regulator-haptic - fix coding style issues

Applied the lot.

-- 
Dmitry
