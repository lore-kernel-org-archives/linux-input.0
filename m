Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F6265629
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048287; cv=none; b=dok5JCmMAJiVqj5Htvvkl590m/cpdQ2Paz1MThYMrg0fj6Bvzp8EAoC+NvjwTUlswGt6bse6qejKvLnlvmVKobUTgC2aAE89qm19Y18F+M+JvgQim28bT83a4AcdeFFbHk9zVg9qqX3KyVKZxLVto152EraoxvCUuMrNJma7i7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048287; c=relaxed/simple;
	bh=2Sit3yjN/GWAbdTHlI2AQIlIrquV4mQqFiv0Dgnepec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1JjSDwPTcbRDf9RU38sKO/2R3+BQvcwjSQmHUBWVBFS1SmJACzxJi7sjErjIEjkcinyCcrhbLs8+kIn1x3iQWdVEnP2MSZmTt+mQkfu9l/0oIM8lIH4O4suaWIMieZ4JG8LdxM0gFw9NxPazFubEKS8+mUQRxOfpF7Y4aACCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLUtl4yB; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLUtl4yB"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso3012851a12.3
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790048285; x=1790653085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIMk5ipKoZWRD7DzzBr8ps4MQh4Scmpp0BDfJZnXK0g=;
        b=tLUtl4yBjDCGsz2KVyIkqDaNh8qO5flVWZFGbU9N0NQz2n4eZstwY41dNsoOr2w81m
         rpp2o0kGwNz7A34eBvYTMgSUouwWOXEh8q4A0a27bzGDh2ZWrRpSLAOQfwfhAMTl+R4o
         B+v74w0R+FhDhOxBMBtd1qMJURyzogZkkCK+1bQRiBFqTMLO7XTITFIaEU/khYEiJvCC
         XuplogjZfiezrtp6WatDE3rUAiwMhI1qR/kFV1xrNJMv6eSSt+F7IhvevMUMdu9d5lR0
         6SDhcwZMn5DSXmuGcCm9ebRgnxXKIGztUTSR0TNuRBlLw++QxV/zxbCnlBPjZDL3/HBW
         ssNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048285; x=1790653085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BIMk5ipKoZWRD7DzzBr8ps4MQh4Scmpp0BDfJZnXK0g=;
        b=kZZ70TjCP+plDGxDtkf5jvc/9MWehb5Ch1LVtTcJyHip/cIwF/ZFo6wLUqbMplImX1
         DT8K5g21ixa6GXiy/3pLZ3NXw05rF7mevixJEskVLqaV1aBpMUE+Wl9+vdmoHBtIvmK8
         c3QTONN8np4yS/J3Y0/bZjGON5kmXGuHiKJnjNq4ksxTfuaz6KmTalbc9cPlyB538LZU
         2xi/hm1+Z+bXrH+sRSpmNaa5dhcyNzL+71Za+Gu4NUwjOQoaEXdbNq7Dh2cauWCIaV/F
         /EV7rApoMu9Yl8LGQ+uY+Ux2nX6yZQro+TdAhZKe5Q4hUJtEO0m4OUX2uSY0DQBJXO0o
         6B7w==
X-Forwarded-Encrypted: i=1; AKwUvBwCckc/0M8diDMHo/gXHAuKW/tKORNykGWwu4hEYczQ2GHez3lFFCxaLpzkkTZksg9HCJMz/OoUweitUA==@vger.kernel.org
X-Gm-Message-State: AFuF++ktRJKwz4T0HPxV53UyrGIxIJ5AKNPAnyFbBHBcqRG24GkHntKZ
	bGNGosxeo+N+upBwuvJ6+TB3qb9YrMiITdJs9rRUi1AqfiTci0XIIXCp
X-Gm-Gg: AYBFou1CFIlrrMLgSbrr52YVs49HpHMMKcolLGJ5qomM5ppKmpfhlOLYaRtwABr1Toy
	58sW/wuOspCeMugG8fyY2VynZ6EXDQF6kbL3qSdjguva3t0xNx6Qw91rDoVM016o8O4MbGC6mQu
	GX7NJjkm/eQnQwYokIJOdkgMJtdToRz3nlP9hisg6P2zeMDuf672A24SzyfOyh6QwV2n8IUD647
	IhyurBOX7YWS96ebEA4dWD3+PuzKXFxTdotHG/o1F2AOaliLDltRvMXxsSsWYo5owA2B7+eusOB
	XfJoRJAtRS6lxZqEEL02NdDtCavW6Wb6OWF1z3VAamFpnfd/C9aOL8Sl4bezxqctTXHTwhIPx95
	tCoNBOlicuK06sNZ+/nM3AzToLJYxdthOnnPQzl+xJUrGVtJxv+slqCYfReiAj8EzJGBi9nQfZQ
	ptlH4A+qn+eLK9pa6aaiCbJG3yYYzsBgUnLLuayml4yhKcxrVSny/8IdjYLs/a8G1ORNYTkkFrj
	UN4uUkwBVBiDxOjB7bF7vX4NzDoyr/4ghFboeuD
X-Received: by 2002:a05:6300:8811:b0:3dd:a007:cb2c with SMTP id adf61e73a8af0-3dda007d26emr13269696637.40.1790048285330;
        Mon, 21 Sep 2026 20:38:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e1a7:4f7b:11d4:34fa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e613154bdsm1298997eec.24.2026.09.21.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:38:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:38:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: cryolitia.pukngae@linux.dev, kees+treewide@kernel.org, 
	DongLin_Lyu@outlook.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - rate-limit unknown key warnings
Message-ID: <arH309acsp-cMzIW@google.com>
References: <20260921131934.677541-1-zhangheng@kylinos.cn>
 <arFZdtgmZXcK9k1V@google.com>
 <3aa95d2e-9398-482a-8bd5-876ef1e2ce89@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aa95d2e-9398-482a-8bd5-876ef1e2ce89@kylinos.cn>

On Tue, Sep 22, 2026 at 10:12:15AM +0800, Zhang Heng wrote:
> Thanks for your reply. This fix should be handled in userspace. It’s just
> that for ordinary users, they see a lot of warning messages after pressing
> keys, so perhaps it would be better to limit the output. I also agree with
> you that this patch is not necessary—after all, the benefit of this patch is
> indeed limited. If the patch is not merged, I’m fine with that.

If you submit a patch to systemd's 60-keyboard.hwdb introducing the
mapping you will solve this issue for users.

Thanks.

-- 
Dmitry
