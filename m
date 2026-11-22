Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387515;
	b=oWKu7cvHKMEhPTUgNDzMds5vrEg/gWgt0eRYZU2MK4/mAiDyYHDy9WqQ4cVddWHmcHh1
	 ekBCtvMnhJjySizfPvlVKEgwAo1Bv75MplfCoO07bFHJT82uH5Q1TFkQYwJ9GacCZYFCy
	 A1U1jQgH3WigEwdZiuO9LpQNMATbhr87uqQX6XNa/3oRrTzy33FkajslsgALKeJfpTJ08
	 7hX/eHNAcX0eYIjGcIW1ChdlLWNSa5refEjk03oz6g5N9ByWXz7b47O0xqEVZA5YVcvnf
	 Q0Kx/Ct9iaADcMgMX0tq3/wLMTGv0EBlqkpYJ8FQLnUIOewUwPuViz5E0ZxyUoAm8hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=HHNnwunxwLQLJ/oTo4GJ8Drx0pX6nCVu1uIdTwZx1a4=;
	b=EAleJbMFittswSx8W1NYmDGk38rKK8oQw7LBH+z1YDbBp8iW7TF02t97e1qGI9wjFJYv
	 SXRHhFB8DiO26AoY0dbIXRX9ypOjRzG42chjt2ntfwFyKTjXm04RIvjk4IHfReZfog1PZ
	 ZebgjUN8aL9WKYvPYnB3ElkK/hklaTk2UU92GZA+jmVZGY3d9/F6AUWK4Y3yYGJjpkxjR
	 FfbXbWIk5Vj4pGC8hS1KKoadavTlNW5N6HSsktERh8X0kkeppbW5ESur30JAS2GziuaNU
	 VXI5ZAtiyOTw327nrG6XVA72rsYheUtcCMYWJcROpdHw74TvuCZ4JYL7NVWrXXVCIUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gl9aV3Xj;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB80606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB80606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gl9aV3Xj
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38692f62b22so820538eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 14:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795387514; x=1795992314; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHNnwunxwLQLJ/oTo4GJ8Drx0pX6nCVu1uIdTwZx1a4=;
        b=gl9aV3Xjon1BGtoe8I65cMfOZVI6EvuOYdz+307IX2z9+tJBjxG6QfvYQtkhl0OWaL
         H0aQ6QXhPDu8kXW4pJCk33we8xr68CW7ADY0xcovbf6K6jcER0gu+xeuc6IZXAczQoqQ
         ItXiIpnSWCp19A1mpBlZ9nzzc9IHyHDUlDUOw96FWPonce68h4mJu2O7TIMqWjVlAhxE
         mu+gwOTbgbdGm/OSHENS3klVr41M1T5I+sPvJqo9+byBchFXoGWqvSu3Hw4CbqvdIgwE
         1tHEA4wZqWPQeRyvVsGwsm31mNz/hZVZYxiionflAFgnler14bTCe7aQ0r9mzwbHzg8l
         vCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795387514; x=1795992314;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HHNnwunxwLQLJ/oTo4GJ8Drx0pX6nCVu1uIdTwZx1a4=;
        b=dUNobzPW23+PpWNFB7jDdLSZyf3hrTLVOuBNgDCzvzDwyguGPMmpeQrsolRJEdeZYJ
         VHfTzFm3KFDv+q6XGx8GJ30Guknw2dNKHfQnFetR1VnIFJN4bLf/8e8JX+bpXSc7JK5N
         UYLSxlF+j7El00MSBwyBDMXLtvsPE3E20k7FJjajDLx2w43AnsM9/mA57TH9rD0GaOr/
         4eQgTOjG/nrtMN98XS1MzdVbz7Wqg/5EarkgFJaivo0ivbtL1WUt4OUaNU7LR6naLZ6p
         CX7Ba3F/EHYzyrYN8VvRu8D4wR0zuoj3Lu0/msFA4lxtV7EFuxeuEgdIarvuvV8V0uwn
         z9Dg==
X-Forwarded-Encrypted: i=1; AL+hErEp2jF9fuQXFeSHrNuzEywONGSQNtuyXmTgWcJMSAdFO6yEU5aHVqOpupyS/s78DM6AyCuppmrcqjdEkw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZO5yDFsMfd5QI9Pxt7etNw8RVvIXbs9zAH+QbANzN4qn6em6+
	Vl+x0j2DQGFigvqh8pQjHQum7bt0pqj0ykuvBMyfu+W1kITraFH6+CxO
X-Gm-Gg: AZFdTZfWwl0bv1x+VFPOl7LHw2TmHdulVHA5FUYCjYo3uP52EFZH6UfQYbW5uX2kfrA
	DqBpMG+/KDmoXEtEPl4rkJy3uF9n8RAeJWPKgFk3Xtu4xvGzklsPcmjc0/2fmdKZEIW/ItEV83m
	jaPhEgrwTzVgvhx7vAG5dy62A7MAIjK2v+y4hfDLStJYUawHPvN0yaCecv0oUnAcncnS/NZZ0cL
	0mpUrDDsEHX8hBHVFl6aSUt1Txy6JdILTT0eeiE8PKejwGpQkmldPrRdQGBzBTyHjnM2WJFrQ9c
	VuOG4v4ITtfDKYb2btap6F0NBViyiVtImrBF+P3kYouqux8zAhp8U1qHnxWqjvOZ6J0P60C2z29
	Oko8R+sZHjqhF7YTRDyFrBqMJXRvq2AOxlr6mcUJgyWXac30YMh7HRzbpiDsXTsfgbmoLa7JCo9
	3SyLKKd0Xc+aFXEcs7y2Hjmd94cVgaCCmZIDa/38BnLfwUO6swgRp9YdGfP0v+994X4WAfyl8af
	0p7zw14enGvbdQx0me3teHGLUpQON5kqGkt3s1J9Fkt892xjVnMtMMSxoLTur5I+TgQ4S3dQLsC
	CeeIhHCDulGmstNcFOvwv0WK6zxVibFJnAAn11XUzdsv/oochyyHp6FaWr3mqA84QezTvw==
X-Received: by 2002:a05:7301:dd94:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-3856f559cfemr9838744eec.30.1795387514423;
        Sun, 22 Nov 2026 14:45:14 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm27669066eec.16.2026.11.22.14.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:45:13 -0800 (PST)
Date: Sun, 22 Nov 2026 14:45:12 -0800
Message-ID: <aa59c5114350a037e57af5cf2f0b0559@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>,
	linux-input@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: wacom_w8001 - assign distinct phys paths to pen and touch devices
In-Reply-To: <CAF8JNhJjjCqxiZDH4mDEuTL+FP+Ugw6aM8RfhM_p9+zfNuphiA@mail.gmail.com>
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com> <20261009190746.803607-2-dmitry.torokhov@gmail.com> <CANRwn3RUdGyEOJEdN1xUjEHwnBX5-UnpZZ+ZBBwY9RBB04FtUQ@mail.gmail.com> <as7D7idd-843CJkn@google.com> <CAF8JNhJjjCqxiZDH4mDEuTL+FP+Ugw6aM8RfhM_p9+zfNuphiA@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ping,

On Thu, Nov 19, 2026 at 01:59:50PM -0700, Ping Cheng wrote:
...
> Did you merge this set? I don't see it in the upstream repo.

Yes, I applied the series to my "next" branch (and it is in linux-next),
queued for v7.5.

Thanks.

-- 
Dmitry
