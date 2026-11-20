Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219043;
	b=1Phvpjiap2B2v+cy+uB2i7Cv9mqRvMwqLVYbJU/8TrpB/tW1OwBAsoKspIWR8rsV81nj
	 NFTK+kulHfUl7X4wfE9TatjPa45MhKl2mqYZojefyFEr4sJQvLD/gBr+QBAEg3MwORyb8
	 jIxKBlHy7nI607DtiFDqRD/mY1aTIZ+tcbVbXDzabWkSHr3c4k/Ch+ZIcKdfOuyIBQdf/
	 PZi/3wZGFjQ47/Q0vJj2Cwjxc4zFvYG7+8XuiEf70HAH6qw8UYGF9IOi2AjsfSCaqgwir
	 /6SuofU6r933EQPhyleRfmMUr63/bmUrxx/6sbvh+BY7RVZ9PEkB/EDnsM48kRwueDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X3mXOkI3k7kIPSGugcamISGGNj/Giv2jwZLbdDbAlpU=;
	b=kfz3CwJQ+SRbhd/d+SNp4XMXU/ls2Q9DiD4F14lP5uSMdzZLjCVtQTn36Aov32g47ShX
	 WNpkEc3LLbSEZu4Unpp+H1j0JpthZsrme0/BaPXQS2Hq4akJ8vrXxdzmvv74AG+5fcRFb
	 8adGHSfBv/bsSbZCLJiqDLfbyNp1ayBRcvZU048juJoLtnApIgeBzjIazDeh2JU366Lzm
	 87uIZYSnXbWwLK2zwfuvEOCQLHshehw0nE/Zk2yWqbgotQyegVn+HRQK82gq+S53DC3Go
	 yaCfC7AKqNnUKHAQO2skero+QeeaP6tUYQaNb7xg610CxZa5XOckbn0PZ77QnD4fOZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPXSKvd3;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D77606A6BD
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 23:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D77606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPXSKvd3
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5133831027so219995866b.2
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795219035; x=1795823835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3mXOkI3k7kIPSGugcamISGGNj/Giv2jwZLbdDbAlpU=;
        b=nPXSKvd32puPmNXHYT8aQQ7Blbg0fhFbgg5i8Ksv0Oa6bBoAjlzOB3ZlwmRyOrmLyV
         XW0x/JKX68ubIULq35M2dLL0N+hsz51DO2XBd/4SL6HEDULkDJBGQKfawDS+dZ64CDgY
         +yd36+SytCOcajVrEae35Dqrlyt2MU8RVP6YppEYrL5W81v9MxMiD79xfoSITT+J2qWJ
         LqxZlumwUp2bJEXI+OD5judK39yrQ4lChkuwY6P0R/mOwpCrhS1gLPzK91dkoWuOB4gE
         YRd/DCcU1UU33db6BVW6S4/VktrDj/cyxMa6opdUOf3POojidtgCF8JBbFRTXgjS7aB5
         h6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795219035; x=1795823835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X3mXOkI3k7kIPSGugcamISGGNj/Giv2jwZLbdDbAlpU=;
        b=LV6iZ2LG23u9jeF55pdKduG1DBLeKBSJcjY+UIowAe4RQycua8IkHGX1t7MOB9gPSs
         +bC/tVEgGN+4yi5L3H1ru5+1uq/yfugh2aNhvOWSpQtDHpkplGgi37qUtAd8WcGu3n+A
         bLmZZhlDyrivU6io+/yZ4pJdNXGJ3AZK/3d3D73iTs+5OSSGvaLUgJirgIiNvtuYMCxT
         Q4tbfnwMtovnAusNRZz31MPB8YEISMlOEPTpgmTU03y9RE3Ppxj/89RGAyTl42lEOtMC
         LoCmNkChlAdD2umqYV9I81KG5VHVZIjUlJ+1BDNTjPHISTieMnWMDFIU3gtbvkX73hOp
         E8ig==
X-Forwarded-Encrypted: i=1; AL+hErG6w6DqnZDa/33Qnxeszju25nXqu3QEZ6xo87T+k087p7iD0r7JS8WQ3qSIYDh88zdI8MsKkrlyC3FUSg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8o3AJ4CwpZ96d3NxA03pr+PNnhllOjnkO0HJltljAAODz2aA/q
	wGYt9i9+VCNMmX1Rl87AvRFOxnoaPok9cWzdV+ePsxWZLg+5K1svkanPpLGHJV4=
X-Gm-Gg: AZFdTZd8EgyrzgAvNf+r2jfZDoH3eZYQpfeGa0oGro/QFheZxQetdszPYsel4btBb2i
	gGDrHIzeahgMUjp4li1wNWERgW+tYIYsx47P1Mkikf/h1wd1ivo7xmej7o3CwF9A7XjdwfyhOG4
	Zbhxi8Ev0rFdXaaNnEFAWHeqmYOwKvKDeXmQNtoCXZxLturkb+1KSH8KYE5Ma67dCOetS+3vpU9
	EoDcKUQMz53ppH+pc/I6iba87eSDkiuPYM4xliUqZEq6Z+cFkh+Ud6Lp4qb9WvDaSJydgKs9NRr
	JwMoqytS9Wx1sw7AQrJC6aug2uiQHJBU9CZ3f7CyLHV8tBTsboSEYaUtfrLVMqmgyf1+ReiVoCm
	LPXanNtREF6AtAWeGT2j20jRmjt0xd0S2s0IkBLs10jprXoTzXyAQXJyWXhJoXBUC879ocq7aW2
	F2qOUSBeZV5w+aWFaavr1tdAwFh7zdsEmXCtvpEXxXfROJiPe1Ty/mzgC3vVa2aM8UEqwVYUzhv
	TMGNvaKRlr3Hkxi5IsYZGSbHD4KSsNwMJQlCWY566Cn4mrqGkpgpMz+hjavUyDX+Rl0lVEiiY+Q
	KjFas0jtq3n+KQxEzSwPjarkYUdFULpES8zoJYmS3LQ9iaNkuCD+WS1/4mOZz0rqw4wp0z2t0ao
	zwDDsIsMyl8ejfnaykv1h/iMq
X-Received: by 2002:a05:6402:1d4b:b0:6b5:646b:2c39 with SMTP id 4fb4d7f45d1cf-6ba37e8e238mr3343517a12.30.1795219035131;
        Fri, 20 Nov 2026 15:57:15 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e78a7sm1665428a12.16.2026.11.20.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:57:14 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Frieder Hannenheim <git@fhannenheim.net>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: synaptics_tcm_i2c - add Synaptics TouchComm I2C touchscreen driver
Date: Sat, 21 Nov 2026 00:57:12 +0100
Message-ID: <20261120235713.4038162-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260910091405.354058-3-sevanevorotov29@gmail.com>
References: <20260910091405.354058-3-sevanevorotov29@gmail.com>
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

Hi Vsevolod,

On Thu, 10 Sep 2026 16:14:05 +0700, Vsevolod Nevorotov wrote:
> Add input touchscreen driver for Synaptics TouchComm (TCM) generation-1
> controllers connected over I2C that boot into application mode out of
> their own flash (such as the Synaptics S3908 fitted to the OnePlus 9RT).

I tested v2 on a OnePlus 11 (SM8550), which has the same S3908, on top of
next-20261120 with an out-of-tree device tree.

  synaptics-tcm-i2c 1-004b: TouchComm v1, mode 0x01, part s3908-15.0.0
  synaptics-tcm-i2c 1-004b: 5760x12864, 10 touch objects

Touch works under Phosh, including multi-touch. With wakeup-source set,
the double-tap gesture is reported (KEY_WAKEUP) while the device is
suspended, and touch works again after resume. I could only exercise this
with /sys/power/pm_test = devices, because a full system suspend does not
work on this platform yet.

One question on patch 1/2: the binding describes vdd as the core/digital
supply and avdd as the analog one, but its example connects vdd to a 3.0 V
and avdd to a 1.8 V regulator. Which is intended?

Tested-by: Majid Hajiheidari <majidhhdri@gmail.com> # OnePlus 11

Thanks,
Majid
