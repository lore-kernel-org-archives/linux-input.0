Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29234EF07
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269441; cv=none; b=dQwy1W3OP0cbWpvNLkq5TJcdzmHr3FdWMLjs6LZqYPDAh6vWR0AdHQ3OxA32Ggy1MP7DJ34Wx6oN2GazF1BQW2j1DiZKkgSpzgHwfF3gccuVj0DNwdRCfTlezGHTv7+BnqvzmiEAd3+JkzjsDyITED9kzsOYlHuEpeI8+kIcH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269441; c=relaxed/simple;
	bh=k+sFTi3ZhgfW4nApYetJ4lkoXUIXd5mBZUzjEevdCnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atic8duTkm0Z7zZGm3Ft0Wgb2Ytdd+a0IAXiF+AyLEx65nrODxskonIbHF9j9pRBN2RiUOBkdCoC/rpZtF4I9WA8x1ZNO0p17bmoNc6pDgkk8p6GqTnl4jFl1f5HS6IcIUtXfR41WSNjFk8FXdu3ZHNShpRL26f3D302MlTEx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K5b2jGNs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K5b2jGNs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ac10e337so6250325e9.3
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781269436; x=1781874236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf7j+ifXP1lxuhE6FFlnHvjVP9/k9ur1vllpVoVtwAs=;
        b=K5b2jGNs/84o9wYeZ8dcDLfOZon+oILCookbgGaw+tfmpx8HVSZlc5jDwXau3sAN32
         fWeJrSp5c0piUA3z/y7co4i3WmkcqeRZja5wqVXsqziCf4roaDgKDJTWcj0NohdaD5BU
         uwM/SprEBsYXQ1lpE84RTHPCtDOQLDa91CREfgXiYiw+x28mSKNBVeBaWw/r2a2EpHXq
         615j1HJcjMkqaQmK9j2VBy60xWD4frYUarAUae5OeGeXhfT+7AE4NoAVMigQl5gPNFel
         AGDrfwTSd2Xz02gepjU/9OHrv3HvXanRYNyMezoaDPfLDvyoe96clktxc+KzxUMOHt/b
         RY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269436; x=1781874236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf7j+ifXP1lxuhE6FFlnHvjVP9/k9ur1vllpVoVtwAs=;
        b=dnl1e79YJ2Yied6BlvCVHRxnKu0MuGoIYZjetuJerB8jyYenWG8F+wcLtMVigr6Eks
         2gQwojEyLT4MHVpROOr0Ss0w4gQdtNo2yBF7s6DiOm4yqANM49aWARnMQkDsVEL8UXNf
         LBRkYpao3H/p4q9kYpt8RmBZa9bVIeVkKCB1ezkXGvz/szX+M4pnxgtP8YHfWxna85SW
         DKcqsOSXHcjTEGOoyrQVAwy/ll2lBp1sz4S3jVX0qZz0iVAIYFY13fJZz7Oo+JZui6gS
         p41sX9UKEfvUPgTVvKKvc3vG1OoaYB6+GUDAf7KXdaWBe+WDyn9P23MOw3ukB2kPenwm
         jj9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9KMM3+UnakPI3/okPlmfLQ1lfsl2fFvD2yoCKkkULhdG5PaMMMdEs46HXfC/Hc9gbrJeSIPeokH0DENw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tc+n7Zm7GNCpgPMF/hNDZlBLqhWFey1Ggm+m8cXo5LFrOc2Z
	Z7InABinIVdaYzYbwWXpGuHA1XhLCrTG/gM5F8ltUMl1ZxyN23663vHKfGYJ/qVcX9o=
X-Gm-Gg: Acq92OH9UVEobZJPRxrDmx/iJxk3daCuCVLjoRPGFn8lG7KB+SWOv302QBoXfLDT1c7
	VuHd9CwOiZcWecadmFpJz5fFW1KNVlO/f4h8NUl8w10y9cX4MikOqWMLzxFb4jBxViqHMr34O/4
	s4pb6RJVVqT7b3PHn4ygLxi4UBQKmCQEKZqbwtzsvWOBFpxah0n7+6YNQNpO4R3zW/HVNIUYeXO
	jWyGLqIk8cdXjXUO+v5TJaH4HjXQQz5A6RLy6lDGWM0ZmV5dDhAHZDrLmVxICUuX8V9rjB63FJa
	Om0MpRdUfaxUia9xaXOFGocfTdWpLVvyDnQ2LxDsaPNxxoUgvzMZnvibNSOMeBDRt6m8NXXmsKz
	fdkIaeMubkRt6ibBCSQea5zMYc9OerFrZ0Z/09M/lle1he+CLMWZLbHAo7W0TgvY+Gh4asrU5/b
	3szVcdfwoty+ZdaXGp7vpYvqbyVw==
X-Received: by 2002:a05:600c:83ca:b0:490:aef9:aa3b with SMTP id 5b1f17b1804b1-490ec523ef7mr34427875e9.32.1781269435437;
        Fri, 12 Jun 2026 06:03:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea84cc32sm61170145e9.15.2026.06.12.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:03:55 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:03:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	"Daniel J. Ogorchock" <djogorchock@gmail.com>,
	Tamir Duberstein <tamird@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] vsprintf: add upper case to %p[mM] et alia
Message-ID: <aiwDuXJSFtt9jlyf@pathway.suse.cz>
References: <20260603104351.152085-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603104351.152085-1-andriy.shevchenko@linux.intel.com>

On Wed 2026-06-03 12:34:01, Andy Shevchenko wrote:
> The first patch induced by Sashiko rightfully rises a concern on
> potential ABI breakage. To avoid that and allow the user (patch 2)
> to be converted to use unified output introduce %p[mM][...]U for
> printing in upper case. Tests are included and passed.
> 
> Changelog v2:
> - added first patch (Sashiko)
> 
> Andy Shevchenko (2):
>   vsprintf: Add upper case flavour to %p[mM]
>   HID: nintendo: Use %pM format specifier for MAC addresses

JFYI, the patchset has been committed into printk/linux.git,
branch for-7.2-vsprintf-pmM-uppercase.

Best Regards,
Petr
