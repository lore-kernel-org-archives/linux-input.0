Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795408852;
	b=b2TJjnGg9yQ/40+bjEFryMMcdHPlcGackt7KtSIuSf7JhTjeAMvSmuqVj45U3HAqrIkl
	 ya17HNIjLWhkhKBdpld2IieIcR4tjdxX0vjfEB0cKhTzH3nCI9/kwXBfpxi/1CehTxGCG
	 puANDAxKwK8Nf3frqorW8WijxqcDdvfNBfy3fmtFJl2O506xSUa9UL6LlVDsgXKt2bf06
	 TU61Az9V1gTzaw5BP5C/l2zUy6UhQA0J+jza+r5T5hxKTX7zZl/o7xCEGRyCcV+veYXgu
	 ydGYyv/CeSHHvUqJ+SJdHi97RT8HOdQS6wjg4K7eR+LPuB0A8BAEE5irfxpqVBstpSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=j7W3aHbg+YDWSVhA+lB+EOok8sM/T43n4lzMzoxoN/U=;
	b=vXIjhyuzNJlsd5x23RHoDcIp3B6BE8ANhjFCZwmKY3nEZ2OER7xyPMHzQbA3vT3YVat2
	 nPSb1d1fPgCjzE6PFVnGc52DD05+7IANOoeaPnls9MQdAnAiagFZzN+7WbgOxrCWXesQO
	 6RX5cYBoO9TVdv2PF6XDBlptqc2d/Cw8yK+jIGGuwmPZEaYUO8dhGR9ulgP5e/talENps
	 wqX5pddItclSuEncwInSQtM8XGVtiGd8iaLKsP1rbLwBcbOtNR9aHoQDtslxc+bLtNsp9
	 POMwnOD+FEDlI9yipIFSG9UHKu/uQPlTFJM6+uWhIjRKzpRanzBHVfEW8z+vJFG+vaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="czNHu9l/";
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C3606A320
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48C3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=czNHu9l/
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8c6c06b3321so2285305b3a.3
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795408851; x=1796013651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7W3aHbg+YDWSVhA+lB+EOok8sM/T43n4lzMzoxoN/U=;
        b=czNHu9l//TCt+8AntGLGUIU89eLLcaRS4jLAJk1Nzs1lPL+Jb2qdFpRqEQc+IdDqtC
         4ztDSThFOOBaU9PeOwLQ9Pa4m2PtE7YPS/OCCpUt2qjuL7z1GW5VHEFnyiPk0TzJIorR
         otn+Rz/5fUVxV2EhRUjaeGHdJ80WamvL5D7Os362o4B/v+Ggn7jT/JYWzc5N8EKg7Y1z
         tNry4iTSE82k9RHBHFED4a2rr9CvDGlx8rR0SwOmR5utNr2IEP5/1NWfwKK8WR+oNQ1K
         rqaIGmaxNy8KPLS+NwhSMGKYiE9AJrRMoNv6fvnl6lCoXLmmCK9wc+Nc+rNvwJRjdw6t
         w7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795408851; x=1796013651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7W3aHbg+YDWSVhA+lB+EOok8sM/T43n4lzMzoxoN/U=;
        b=R9/rjU3rOVwtmNcKEDHyaPGqMNa7lxf6pJArY69HdGLySRZtWb7AnhjgQtXzo8XObx
         XSUCNwJVmIxKIAiLjj3AAt2SQXA+5zL4X4iqJPumnwrPaRI6EfbOlUPnm0nn4Nom/VR/
         NZ9z7rgu2LZ3IaLKcXeyhUYVUFuvo3SicbE6TJO8EbthwFXCJvKPA5c2Z3veqkG+BJiL
         rw0eVNTlS4GtZ2slO3GegSxE0nTz7Si+iXfOpRDhQmLRzbVVTOQqVT11WF0Rz0s3Afqc
         BXcP4iQclaao5JkUiBti1JJio6302R6G5xeb24rxj7a3h9MR1Ke/XSKCS+Bhf0a8OAvM
         vIOQ==
X-Forwarded-Encrypted: i=1; AL+hErEt7TRwlgxVkXaiT6ze8DgVwewtCwZaK18GexAFmssJpS0DBqeskROLET916mlACjBI2ql8m2RGPgIrRA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9mtJ+LmkJ0XXUcc0eDmAs3IqX5zlTrBf2W58iNd/yrdwvVM7++
	lP7uC4HaDMTtqg1CL+2GGJprRvrISHzNNlFD5qxfwKdi3b874wz56R5j
X-Gm-Gg: AZFdTZcG3SMU4Bh4G8nFvTYQCSvY6C1vXXw8LgEzONavEc1fd49GIWByjsLm7eyQ17G
	rpPvH1xJlUIlhczHKAaM9jDsN73Z+UOajmYs3RhNm/gObb8VbaX9PhkZb3ctMvbc/a4uoocvrQP
	8Poslb4RI0PMAcSEo4C9Caacxx9dM4sR7OhOOw6Xol+A1nnBlJX5GthIsCZLV81zIe4c08ZYslz
	FZZW6SAh/PQqhmBe3PxF2GTthZ1RUVwEXPhoixN77CyqIox14scxvfvaCzq0mrFRkk4eNWtgq6W
	8fvuFtcQE6HmVpymGM84DrFCq6tCxTh8OPVhxvE2eRjTtjNWge9vPNkC9AzJ8XsoDq+faw39gDw
	62cmB1rNnMBn5p3EUBwQKO5WfpHPT46bRSOwUaTEiW2YXOL+1CKQNIIlZkfqOhR6gl60S+cMiRa
	2qBSNYV1dljJAVlClISvMeukBatVC9KenjveoORi4jwykceR1EHqX0WcAxfFV6OtcsSRepMKOn2
	ioZV/KbfRbyvDB0w3sVUnvSY9JuXaGYEegSIsvkXYYISP/IQIo2kb28WuQgwtKLXBbUNtA1JbXU
	/rlzE4KWtfPyvEBYszN4UC9Bm0MiHWCjUnVQ0pg8QsqwG04urzArvJFJen5rbtlzCMFdRt4=
X-Received: by 2002:a05:6a20:430d:b0:3fb:1640:c525 with SMTP id adf61e73a8af0-4014dd5bab0mr10831025637.67.1795408851193;
        Sun, 22 Nov 2026 20:40:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c29sm4324017a12.1.2026.11.22.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:40:50 -0800 (PST)
Date: Sun, 22 Nov 2026 20:40:47 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Mark Featherston <mark@embeddedts.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	linux-input@vger.kernel.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Input: ads7846 - drop platform data support and
 cleanups
Message-ID: <awPDq900dc82rWOz@google.com>
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>

On Wed, Nov 11, 2026 at 10:49:52PM -0800, Dmitry Torokhov wrote:
> Now that all in-tree boards using ads7846 have been converted to Device
> Tree or software nodes, this series drops legacy platform data support
> and its header file, simplifies sample filtering by calling
> ads7846_debounce_filter() directly instead of through function pointers,
> removes redundant memory barriers, deletes dead code, and cleans up
> minor coding style issues.
> 
> Thanks.
> 
> Dmitry Torokhov (5):
>   Input: ads7846 - drop platform data support
>   Input: ads7846 - simplify sample filtering
>   Input: ads7846 - remove unneeded memory barriers
>   Input: ads7846 - remove unused code
>   Input: ads7846 - fix minor coding style issues

Applied the lot.

-- 
Dmitry
