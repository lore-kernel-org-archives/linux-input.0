Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281803;
	b=O3EQ3kuXHVfdxrrPSYvQmFF+9ztKwoo+0gd6MIkCEEGmY0eJBv3OCGMdiBk7aWs3Vgbm
	 oleGkoiagj9wcDFc6KY7xhUbAOWs5dn2rRUjleM4ea0bsu4F25Sa1rcjUq2uEPMOZEvEh
	 8SPTTCxfm58UJjUuu4i6LgN5u4+gtwCBwoJM5Id8GXN3r9vYI71ZGea4S4xV85if43bHW
	 OyAy/KGq2cv8ywXgdu6WLmBkMmGtCikdicRwAX895/aNqxLiTEDx4IzZs6L7gWzRw6pEC
	 f7we01xCAvStttzCZNcsR5V6H+VaqOgQto7YCrlJQolu2/q1PVCIusukpjrYxtENcEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rf6nX6z9gFornN9cf7tozfwyaeDZkmjs0vcNKXrirVc=;
	b=348rnDb/g1tS9zJcxnjK3ni5qKVV/LYdyUMRXAWdA0rVvH577hH1fapXvGHCMw1uuiBT
	 QOPBJ6nHggo3riUdbA/7+q33/tpa8UaDrPLmad87tY4XCiuHeT629OwdngU/1rUE/VHhd
	 x2ybnCO8XCH1D+1lN3CuFG5jTNvY6gH3odriwu9kAov82r6/cTS6Vk7TfY/wUInLHP6ii
	 VxEtOIl9ndw9Zj2VlQpKLBZqcDwkJacQ0FpBGq8KNDPJr7KeIiyhPjYwEStyJN5ssIxVI
	 SwgJKHNyMFIjpm7uSpLF7dM71aIXxKA84JfNhc00ZEZvIZPzR5VPIzq6G+YjmJ73tzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W6Jv14/o";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D955606A330
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 17:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D955606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6Jv14/o
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3869b68caecso1551224eec.0
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 09:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281802; x=1795886602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rf6nX6z9gFornN9cf7tozfwyaeDZkmjs0vcNKXrirVc=;
        b=W6Jv14/oX0BcPQYRsaHnsjvBVFH/SSg7Gw+531o+1xtwGe18j35J/O6ym3b9t3qaEg
         R5vxdpl9ZdOIH/GNu411QtlFPkqwmkdIaG1bJSH6AKVJGZbjD7gOP2akjNuKQzMP0MIE
         58YIMpkv0VpPCGJ/yPUN19tRQD/+Mrk5o++6cuTYB5u/WB2wHiOrTj4M9F06SToA+ZYz
         nJ4fRL31Mz82ERRYvkszKqr5lUnEGKE41S2pQLr+iw8eiQdbHKk3JvK1WfKrg1ITOmxk
         N1EyniCz1Tkxve1sSB1eZzAgU9OYi+hvfcxSlrK9Hu6UIQhlFZytJTVP6PyK+i3GlYG3
         s3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281802; x=1795886602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rf6nX6z9gFornN9cf7tozfwyaeDZkmjs0vcNKXrirVc=;
        b=SR7o+ANgFYPUsN6uLaTd9V5lK8VOqXxPYHF4gyxuFsShljmnqUddH5Mnu5+A8S/zw9
         TOLFDKBWdRFmFYUkq9Bt70WJa/AmnTZ8Yxr5zvTB+AjfsNDbuqsFSGD7CnZB37/OfbOv
         IjF/iZOLUO48YgrkXqBPPLN3wPgij0e1n1AWdaEs5bqX0ECq2fRmJvYSpV0+ECseV980
         0y53LI4d/2Zl7kxuqPZCmk7+pNFl0TkJLS+aCubgM3NG+VaTeJwS/10Z/FTSOm9zD155
         G0VNGA8lWcfNUSP4+pkAm7X95tKIKarmVxG0Bbow7+zJhTM9PhE6zjwTO6w+BteQZ5/h
         gOBg==
X-Forwarded-Encrypted: i=1; AL+hErFRBLWWlEDRzLO3p3ydKPXnRrW7OWB5pTeqs3RvkDy9k+V6zm6eG8iBBESI2nocunQlyUypxgFfSnUl1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9fp3f0HIX+Q2Dk6jLmvMyxE07RimDpH/Cw2R/RRLIkatYTz/ya
	awhFoP4Cjs7tNN5Jr1QAJYPq+WSeXOYLnnsePsSfM69ZLSbG3gLEmJHg
X-Gm-Gg: AZFdTZf2U3V2x9vaeYyTMRprn84FBkDFxgn6Kc6rUUTKg04ZVT2BZHtayGsQJl1MJg+
	M6PAHCmQb1Y8y9coivbbtJHT7lFTKR3TCmc17qT1QvDT5VkqE41Gti3d33z5su0sMYI3TUb1KMh
	8Aq3pPGbUe3meeRn0uzSZYOWb9MuWWGgWMtH/OAfsSuuKjyG3suZMLVXIFyfy57zu2cfQ04P581
	5grbVYleC0M9TXcY0g/s7YkvyQ0yM/mv3LXrQlwKtLyC4XSsJliIzpDVzvHlcpspQ4anzuFzGMp
	rShVYPuaXsoVy2Sz76wYl0HUETutGuDirmkXO2VkJnOwkX1z4ExN3xpnhSoCNHXLt4h7R3ZFK/L
	x5O+xbOcY+T8vWBsi6czvchURb2WbJzjq2LaSVV80LeL3tMrS+HviuIepQJXRm5zOhkYG7jDI/1
	EtbdZJEn6WCKvHYwoQMDrLYJrxtPIxAchVHoSyVFW13huJmmxTzYEX9gR7eqVcsifTHStNBtcTy
	7CKL4vzHWaI/JQCTJCFEOiY79WIz6FS+QA9v6RaWqRf7qjshN3rMpTPBlMDwCVQPklU/DHGMmJa
	HIO5ny+8p7uUtnkKjQWjEHgoWInxwi3pBlee
X-Received: by 2002:a05:7300:bf10:b0:376:b957:bfb with SMTP id 5a478bee46e88-3856f7563b1mr8528080eec.17.1795281802311;
        Sat, 21 Nov 2026 09:23:22 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([2001:e60:8509:ba6c:4c23:efbc:89e:50d9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm21227439eec.27.2026.11.21.09.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:23:21 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] Input: aw86927 - add support for Awinic AW86937
Date: Sun, 22 Nov 2026 02:23:20 +0900
Message-ID: <20261121172320.829-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261117052112.32527-5-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn> <20261117052112.32527-5-xiaqinghuan@mail.ustc.edu.cn>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 13:21:10 +0800, Qianhui Xu wrote:
> The AW86937 reports CHIPID 0x9370 and is register compatible with the
> AW86938 as far as the boost setup is concerned, so it joins that branch of
> the haptic initialisation.

Tested on a Lenovo Y700 Gen 5 (TB323FU, Kaanapali) with two AW86937
(chip ID 0x9370), compatible "awinic,aw86937", "awinic,aw86927".
Both probe and a force-feedback rumble on each drives the matching motor,
before and after s2idle.

Tested-by: Joonhoe Kim <26rote@gmail.com> # Lenovo Y700 Gen 5 (TB323FU)
