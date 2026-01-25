Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C57F9E8
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769320037; cv=none; b=XNWzIkbxCI80m9ToXCTLP/fMXEKr/yb4zfG6rQm4H2HKZ7+Su+bmgkJvFyFqKdwDXZvjKZlh7Q2KEU3sLLDmHDtdkoLe1qA+/lYVWv8BCoLjtCUzp6uggCi4zCYUHL+MTbQwHG7BwNLOtrt1T+PBswQXPNTJNIiH3wtj55Vay4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769320037; c=relaxed/simple;
	bh=0wiVUgKJ3ZpTnxIJNGPp+d3uPOmuBOfChoPCQkwmsSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q34d150wEDoT8HCUBVWFOhodGmwGTjSx6OjVtw6nKUiY8OaUumTPGgkew1pnHjhEQJqx6HYXCZGaQRF3VhgSxneevwrN20pOh908huKfNw/LW25aHaINpcYd99tgbWR5/4yQacyStfEPuy5e/D0k5tq3NAKozG8/5KZTrSrwKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b70abe3417so8226905eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 21:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769320034; x=1769924834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoAawfiIr/ITCwu6u8MF3r1AnjqzuCgejwwLX66snfc=;
        b=m9S/nUQ/C66AU1QbyVk0gCSdfU4T2WX76Sv2UyL6gOTEa3cPgs+qfzwKh1KyoSrfbE
         ZQIRgQ7mRgLKIDStnAOUIoMqgrVJyQR4JuOCrqfLy7zlB5lviYJfKBhRP+NFhivt6z3i
         EZKdWtxVtHxVFcpL4d6z+FNN6dGRefZJ0+igC8OfMz8HNHpCkWhWubExpnu5np8FD4f0
         yINycQCbTWBf16nkUF47Oc1Mq1osDbDMkflepdyJv03vQsCD+yF1UoyESrIgJJBQafXH
         tTu/ZLPdK9hvxJGwQju+/UG1Y0LjwwgVLsTg6uNFch3b3UtsG55IpNdElWzDk/Aj2seG
         p3vQ==
X-Gm-Message-State: AOJu0Ywp+rhE4OEV9kJzmotr6GKkI2Tkv7+0cK9UjcXaLT81iCVUaZvj
	7W2ftkuyjRL3DLW58dmgW58K/E2PSsJww6/wRHFKhypplFRxOFdqwN/4
X-Gm-Gg: AZuq6aLutaqez+qQ3jFINhPVJbG8fcUlCn0WXsB+dB/w+vF0dExN8AAZCoI5FVXBiBH
	ZDP7Q9oKN+MkF+1cMDIKS7Q5cm2EWhjEYCrawzCHPVXL/RATT448bQKOpeIflDq/7bmZBuOenKO
	e6JymLE6yKOuK6D78BvkyQ64J7huzrYs5ARwIcm9YW7hFtqPPyVzMfOrYTasbGdTn+7mMopUMlu
	pkOCUKKPfpWDLhx0Rvtujv0HVs06V37ZZDVOgH7x92JCoZW872EcvmDlsdiEwOAt4+/yoCTsSWY
	LilXtSYPNjdHmsKB8TUGf+/cILmG0EiDU7tzmcWk/l4T/Jof+KTAJSf9FUcuCkn87LDlPYUN3do
	Rkq5PQlhpLX1+o8qaJY2u8QQxMHXrqV4RENVTkubMWn7nTHxyEN13KkIPuRr+tXzO+0j16af6T8
	JTcmGTNwPmekrtjB+LqoSk79PwNKtHzaJzl4M=
X-Received: by 2002:a05:693c:2c92:b0:2a4:3593:9697 with SMTP id 5a478bee46e88-2b7645169f4mr356662eec.20.1769320034511;
        Sat, 24 Jan 2026 21:47:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:106d:a8a0:84b7:2d62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa03ecasm8827248eec.27.2026.01.24.21.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 21:47:13 -0800 (PST)
Date: Sat, 24 Jan 2026 21:47:10 -0800
From: Dmitry Torokhov <dtor@mail.ru>
To: feng <alec.jiang@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA
Message-ID: <s4744octffdd74jelxl2524korz6fxpzizao34z2473pbl72ol@do4i52aoe2wz>
References: <20260122013957.11184-1-alec.jiang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122013957.11184-1-alec.jiang@gmail.com>

On Wed, Jan 21, 2026 at 08:39:57PM -0500, feng wrote:
> The ASUS Zenbook UX425QA_UM425QA fails to initialize the keyboard after a
> cold boot.
> 
> A quirk already exists for "ZenBook UX425", but some Zenbooks report "Zenbook" with a lowercase 'b'.
> Since DMI matching is case-sensitive, the existing quirk is not applied to these "extra special" Zenbooks.
> 
> Testing confirms that this model needs the same quirks as the ZenBook UX425 variants.
> 
> Signed-off-by: feng <alec.jiang@gmail.com>

Applied, thank you.

-- 
Dmitry
