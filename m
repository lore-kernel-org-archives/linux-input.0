Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281814;
	b=i27QWskTLYmi2dQ9LixZ+BbQrPvOmHWO3/5MI1hEhNA7b+puEJSggVLNk9s0t8XeNQtv
	 iPyt6HPrhPyfz0mYnMDfo7nQUcHidf7dYdSYfWo5WAUcAl0LpEntntcWYXKfmqLnjwrZv
	 odmfnoZ2FuI89VlBRiAe9WX07yUV1Y7aqNwMLVAmHRgSYt7n1iIUMrk2VdpoRN0K7sWc9
	 70ea4KVGSUeR4N1J8s0LCNMEsa1uK4rKgCTbR59VEWWw/+rTw5tcd17sWk1plAUP46t2R
	 2TVkLo3UgfwGaa+ozZg5pzC0oGGOoEod2G2uRX/PrGU07u0sdM9uuXQfktJOh8i8HSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qNh4Be9XbgejPuvlvikrrq9VO3koxch/dMJ6rmrGJx0=;
	b=4o9CwloYmGe3Q+KF3m+i6rFMZe2mbkIAH3JfNi6ouQNZgmPs8xoMCMckJLfSykKFk487
	 fBUdvDQCBirJPqE7x4Omh3vA1+YKNz45C6AcMNfH2TnEEKv7l/RkwzzJfoRnzIZNuc96m
	 cIHH2gXWM6ZHjh4m8EBxrqtuMMTvBbxG3JKQPyJbxu2r8/886L+Ovx6x0n+kjpSG03col
	 hottySeYOnNMQ5biFJaMb2O0S9MUgAjYtc+HqXa4Ekw03ewhLi8nOvHMeEf4LVY3kJZZa
	 AKKbclGqq50sV7N1SdUgbr9WYoZPJ4GR+eMRk1eY3mgumGMjUIEtOMJeqHX5IPUvs7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R11vgZXD;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AC606A32A
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 17:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67AC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R11vgZXD
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so2355550eec.0
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281813; x=1795886613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNh4Be9XbgejPuvlvikrrq9VO3koxch/dMJ6rmrGJx0=;
        b=R11vgZXDtT0N1QS40z2jBWPHC2Kg9bm2pjRcg3i9B3OU76zGxhVGRQipuB0fwvJHly
         w4JVWdT+vNjXzrfyALBi7YH+eCmry2WyWitMBFUxOdxTSU3vCv0oWbrp1ALvIr3+u0oC
         Jm7eNHgERnJ4ppODCcwQlrA6xeCUO/5e9Sb78/HU5PFfdwwFOEbnPWR42LfEYRd0cZm8
         PDKLsp7J+Q1ODvaWNdvLo7K2k7bxl9ovhMlOhnSO0nzrcZQSOJV47AgVhZuNSKv7hPwP
         GUEfzGZwqwWL66JKNrXRvqNReWkvoPH9jQNJKbui6z7L2SmZzrTkYT2jQl7su5UxWjcy
         mn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281813; x=1795886613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNh4Be9XbgejPuvlvikrrq9VO3koxch/dMJ6rmrGJx0=;
        b=ytzxRSF/TDDSr4IlS0LlmaJWed334nZ5eMZHclSxepvL8wShedr8QB7kEWYG6+k/y8
         huIYt0WjzdXNwQIYWHewLtlpEvqAonz9844VojEMoajakm0PHpO7Wd8YTXiULiW3eto7
         7uPQ6b3+f4XNqAR3+bB9qKPEB2eqFhsVWQI8wbSeCavHRpQURNqh4tbvpYocq/4X8yVZ
         c2cuWkuMQsLMS13qoe9gP0QqpfXSHWd6xXwKqeG630xUlRV/Cs/KTssE+xsr9CFylNKU
         FEJB/EwGipAF4c+h+K9RiY0Vp4LKycJrAZJvWnyk1AGTu/bDEqymxUTjsaDcu9ietDcq
         TIXA==
X-Forwarded-Encrypted: i=1; AL+hErHqK6UD/7dSqRijxPUZKQ9otB5eJqmTWGDCo7ZNFZnBfXuEpe5w3gk3jTvhEfnP+W/CFNDZTE5vxV1G3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QUpCWolIXUncgTjbSMgtfJPbM0a4zuPTmvEOxpgdzPEv0pvey
	01Ir2EhC46DFawziQIsY2VuLq7PbZNDge3UmsUCTHZ9cAryZD9CsuoHA
X-Gm-Gg: AZFdTZduLcA/e2DGddGdijhF4Y0leMIlpqAOzlci+83Cjch+oNocZacIiNCoJ+LiWrg
	kiSIr+k5htS4P+qaNTIic0KsgzSEvagG/L6lM1PedcLoh2AvynLgu6xgoF6WmxPnnrGQjkhB+zr
	/3v6mNwUdb8jejEQ5yrfv9LLw0w2rz8FDlPvGYtNFzNZj9WT3iVC4yn/jBxVSJSqScr7SMBL27K
	UzQTtSi9KDCvJ0pwGisA7nU6klEzC1EjeW8+6ajzfHsDGVt6ua74DhzHwlQUE14ZReBILt7BZ3P
	Dz6M6+/HgC8DIlUllmiVspF5ogZPpLRwuwwL1AuvWUBh8rCriE3o35diuSnu+8UVV78W12pNMJf
	isAhswZb96H4cosgG+PaCnsQubgzdYYx92igyInef3YtcJDIcxQov1UbmHQWL4ExeB2LusiseYP
	uJh0BZyXtTwE3tzis4nGGNxBeq5z5PhGANrGVxclkCiCJ0HrGXGesmtMq58ATA0fGcCN5Z1FVeP
	swAG0JJ4IAQsS+i5PTeBXLvm7gqFdl/nvEPX5FCn+H3mIifqkaIXMcrnUB24Ni+3O3nBjRIk7T9
	3AsuohfnjacSazEMAKS2kBIS5lXt1UHWRY3Z
X-Received: by 2002:a05:693c:20ce:20b0:381:761b:f335 with SMTP id 5a478bee46e88-3856f94eda0mr6911423eec.6.1795281812915;
        Sat, 21 Nov 2026 09:23:32 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([2001:e60:8509:ba6c:4c23:efbc:89e:50d9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm16633136eec.13.2026.11.21.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:23:32 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 6/6] Input: aw86927 - stop playback over suspend and on shutdown
Date: Sun, 22 Nov 2026 02:23:31 +0900
Message-ID: <20261121172331.863-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261117052112.32527-7-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn> <20261117052112.32527-7-xiaqinghuan@mail.ustc.edu.cn>
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

On Tue, 17 Nov 2026 13:21:12 +0800, Qianhui Xu wrote:
> The chip keeps playing whatever was programmed into it when the system
> suspends or reboots, so the actuator can still be buzzing after the screen
> is off.

Tested on a Lenovo Y700 Gen 5 (TB323FU, Kaanapali) with two AW86937
(chip ID 0x9370), compatible "awinic,aw86937", "awinic,aw86927".
Rumble works before and after s2idle.

Tested-by: Joonhoe Kim <26rote@gmail.com> # Lenovo Y700 Gen 5 (TB323FU)
