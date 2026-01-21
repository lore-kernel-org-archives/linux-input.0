Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0F3B8D4D
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029517; cv=none; b=G8iR5mLw5esR6mKK4IW+Q4HmrvdQyrn5wmK6aMESJxGtywxK2MaySg61sWOPA6DSyYbv9Yy2bPqqrYQsBzrNLJF2MNJTt3Ki6PKOLTfn1zlVpu6xNvDR/VtF0Jw+1Ex2QzvYDPiU1ym3VurPFRoKydYalPpfKS8BajGmaNBOXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029517; c=relaxed/simple;
	bh=dUsfK+3qglFYu6KKKL8ciiDfazYqnRWmnY//ZVRKfFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Rg7KFyT6poELsfdRguSO1NGupRZlezbQxRDeSE+lJFJqdZcdclvzASzPiGpDNJfR57MjLeaUs/NJle8ACFIYmCyICvIYsIwlBD0CCZqiKtC8SF54sDjBploCV3F/cd5mdIr7V5LGAjGUbiIL0OiOa6PIZvHQcRdgPOoeGt2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+CtwHB7; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+CtwHB7"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12332910300so768799c88.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769029513; x=1769634313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEdY5+llf1a4Uw9aw/Oasu6RVTBbudeOETC7Lzwk8J8=;
        b=G+CtwHB7I+owk53UcviOWILSwgvEK/jX0t4Yvx4ROxnmeZsw2S9eQqUzn7CJk1tTQE
         xMABQf1qdEst9hlhxuTdt5el5dGTjDxodkgvx9D7C1ylwgD4aZLrvjTAzE4XckplK3Wm
         7F1yRA3Wvkp4A7I/o4dZSVDhUxC4gr0uz/pl5jjudXJ2Wt0ns4YBVwCZ84yRFU1lbqgb
         oZOtwqzBTK5NGuhfepc2LX5t3LfQ/rz5uiAbN8TlpcjeSWgzLS2Qxw2WYJeU2wjCvne6
         YzMkSUi1XxhtKkaU4CmieqkiGUh2udJyQ9EG8hEANfjbb9CvNPicWgsvZ6PahX6qn/zE
         LpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029513; x=1769634313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEdY5+llf1a4Uw9aw/Oasu6RVTBbudeOETC7Lzwk8J8=;
        b=RhL/8whlpYVDVR8LSNVhZIqg1NGt5voHILRP1Z3A5bSjk5a/TZw0X6roxoWrC3tglV
         CPyUPIBF4Ft1XRFEVq6dYhLF2tDBlEOm+nt8es7iHjiDyrqAmVlq06A4Lmknzv+GMz2d
         r3IZCxUr2MMlHW4sk8CGZ3/MJpYwMBkOuhq/CqfkJogGJZFWL9H3vNzGwFlrPQhXQLBn
         nNh7V2DlWhwGCyXZzpWcHC9cnBV2YU2UrMPgi1FUc4wk2KtzvPNHSGVoEXVXtc2Q4wtM
         B7GGmR8BAkx4jf6yrIqEK2PoL6XWZRVopWZtojTa1mnwrdXE2/zcVbSiQFkWnG/433Wc
         Bikg==
X-Gm-Message-State: AOJu0YyPmLfK6k4YTq9ZHWGe8eawkazj8QEBlG6ylpQwrwl1WTmjV5dK
	30JuimQDkuhM09nNabpdbuxwIsv/keaurEBFdo6kGVR4ukrEc5W/uwdb
X-Gm-Gg: AZuq6aLspm67D8roGUTwZ+qmUa+HAAGSTtNUvCatZ9d+bjYkdxCPfFDVSHjUxdBDbj7
	jIXtzIavwK1wB16urtvdW52rS2nie3G5TTjS68YxM2yYnY2rh6ScVeWdYjpGUzOMLted9rPczDl
	8PBUrMLpZUPsP21+ECS7Xfpa3lT1epTxYxB4RMrZJFsJ1dSMDQtfiUJgyLGnugV7JghKNpN/3LC
	yz0/XGjHrE5K1SOdjfJ56G9cVQD1ml7lHMRMI4liiwR5XluroP3h32i1nx+ka0+FCGUyI9kgXpb
	Z5OeCnzBy/gPznkFrZeu7eUG4mOTkVF3BK69j7gPUAx/3L9jiOGW8k0rkP50CpRSmwmAGxFqrkh
	JcbqZHvr4LLca/JXEd5aLpAkz/3xBZ4Avhug5OeK9h3k430MNE5CEbKhb+2dzOTWmEpYxYh91zB
	XKoLu8+gCaZmT+AvrQBns7X3UjKuvmOOG2R/TLUwsuEMHcV+abrAgp
X-Received: by 2002:a05:7301:2289:b0:2ae:6f72:f3dd with SMTP id 5a478bee46e88-2b6b4116fa4mr9687082eec.30.1769029512856;
        Wed, 21 Jan 2026 13:05:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361f5d4sm22926190eec.17.2026.01.21.13.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:05:12 -0800 (PST)
Date: Wed, 21 Jan 2026 13:05:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Input: gpio_decoder - update driver to use modern
 APIs
Message-ID: <2ugvppgzt263pomqojjiee3ymw5ttjgixf5jnfn2t632dlpmgv@mj66vi4ujxrl>
References: <20251113154616.3107676-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113154616.3107676-1-andriy.shevchenko@linux.intel.com>

On Thu, Nov 13, 2025 at 04:44:41PM +0100, Andy Shevchenko wrote:
> Update gpio_decoder driver to use modern in-kernel APIs.
> 
> Changelog v2:

Applied the lot, thank you.

-- 
Dmitry
