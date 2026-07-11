Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B13314C2
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755270; cv=none; b=IRsg/nVgyI3FVf2MgxP3c+L4GaGq2jS7Cf7IrduWvYvEp2lOnrlnihZ5xc+S78kA66ESO1KeThYgwveCtJw0HasOwPbgFl+i+Zx2LmUibZ/+jQXJDo0BHx/WL0FSmo5M6jUSziodoEEylHKyGNbGToNvzOynW8y0vFU2TScFoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755270; c=relaxed/simple;
	bh=gUnPJvqa+6hCH/9HCtTO8STc6X6BWHZ70c5H6AKWsOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GalytsIwOyOy5xR/1nmyeTV74il1oe6TCS/FilFvegCRjlBLt8tPxVXsHdDnQko7mew8mgqGJG6dyMvGZM96SmPVW6MSglfaRrhmBxWihNbm3UzIWU2aF7kV/X2gHkzsIae2LtrPaEhoOGsFCtA5EfH0Du9Kk7PKNPBqz7uywcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVUYdWB3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVUYdWB3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb6d00883so1567783e87.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783755265; x=1784360065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBafLctpeA1AoyzErbEa9EGgxzwRbfKFWoPKc6c7bv4=;
        b=AVUYdWB3WfvWD9/jCidP0U7zRkAI7QnX4kmNcHjB6Nosq4CWaZlW0hNhy2LM6kgpWe
         TWeOEWd21tnxJAl6DPVycHqgm9166I3BafNhzXVO9hS6LEulcv+AlPncKAl7GvVrR03Q
         iCvt2f7qMPGyswDv6RE6LdZAC8T7nBCACNeECjWvasy2/IQ6mcUH99GfG+odlxT5vxDc
         faI4NAbgRuPvGxueHmF2X4sAqU7TBPz2sj2hy41Y3HsZaAYU2w0jJYHYvY8gACqUio0A
         PKN2hjadzNTtEb4X+/A4fXYRXB4crD0SpHGqL5UMuZ2Is9WMaTouNVWbOrjTDz6nyty1
         dqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783755265; x=1784360065;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBafLctpeA1AoyzErbEa9EGgxzwRbfKFWoPKc6c7bv4=;
        b=pp142E/83EAgwbLb4Skn7vnjptYLjUZ1CZ4HFVoFHWtJ5pzM3mfD67d6oUlTNWfeaa
         IPO/XPaH7neikoLoGEFdpHyYY10wccxXqu5l2DY6Syt3fX0vEHOi2t9xzUh7UOXXomQc
         bNL6OO04Nm1w8KU2jwOBtqAAjSk2aU2uViFWczdduKpc7n2Np0VEduiKFWVBUJPeWrS+
         qRgS2iaND5q8phvJODDYDKR9zkSd2QyhaWgRGhNb62S25B36+zefoSv4ZLZu/keWibKd
         zRFpNturX6895wTtuffAngiB1Hs5azT4OFlgR7CbVKfl9/TocdbSi201/vEOTe91QXL3
         3NMg==
X-Forwarded-Encrypted: i=1; AHgh+RodOmFsBXQh6qjdcFZaSTtQd46yiuJtBKBd8CvQp18zX6odG0wRA0PJ7370WRhMDWix8yVQk4es2KnPwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Zo+V3Yz9W+hKbK6MzTN17xNC2JSScMiveFuDvmxdMCW7x6BP
	4ixMq4IekTDj7tRCuS8yGdCFS/9aKGgt3AI8c5Fn6elyTncM8CNM1bn5
X-Gm-Gg: AfdE7ck6BTbeh7BwLyz6FCck56vzr6+ityBfsbq47Rwvraesh6SiqYd498B2ozqc92X
	SZdd1/aeUxu1RTuje/PYF19MxCcVJgP3/Y4yiYpmJLhcqDXVc8IMmcJT+QKT9bAWhcxB6Jl+3J2
	egGjheckT2lDe1cTCxHl2qjYNL57oTusWd+WOPN3xMXMQ0hX165QEAneSFCAHZ3WYYi349mpiNg
	Sme1Jp57WpVRLibe1AqAThNjo82iIAPTAy4+gAnX4uyMSfR7LrJNDxylEuXDF81dcoVvx1SLSG+
	OW5jXZ+uPqpXMmu21NPbqk5NRMyxNZzLw5lxr+Itm9tpGVvrklUhPBubHSJJseTNab42zHXlnac
	6j1KBKYR5wnIO9TxJHo4z85+6pHSF7lxepjE2OHFOnBprN7DqwpCGqZWW+tjFHuCD8FysZdfrGj
	UPMxe5MIs594gCDQFFxwR/3BojocBTPS4uNDGV6QI0eQ2QqH26kvYtQMJojYyVUeFgSndKsQ==
X-Received: by 2002:a05:6512:3f8:b0:5ae:bf45:e3be with SMTP id 2adb3069b0e04-5b0236689cdmr321070e87.21.1783755264967;
        Sat, 11 Jul 2026 00:34:24 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:4322:18e2:4e2b:60a6:4ce2:33fb? ([2a00:1fa0:4322:18e2:4e2b:60a6:4ce2:33fb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9dd41sm1117527e87.48.2026.07.11.00.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 00:34:23 -0700 (PDT)
Message-ID: <de1d491e-159e-41c2-b145-4d09db091031@gmail.com>
Date: Sat, 11 Jul 2026 10:34:19 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] ASoC: replace linux/gpio.h inclusions
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Krzysztof Kozlowski <krzk@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260710211954.1373336-1-arnd@kernel.org>
 <20260710211954.1373336-7-arnd@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260710211954.1373336-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 12:19 AM, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h is going away,s o use linux/gpio/consumer.h instead.

   s/s o/ so/?

> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>[...]

MBR, Sergey

