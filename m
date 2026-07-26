Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE67625
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785028589; cv=none; b=A2yhFFHNhQWXhliOP864NF4l8xar9tNZf/XHi+JT57eoaLhu4THa7gIm6wUyZuzPFj0E7t2S27b6ACDv7UwDCtaGi9kZOgPhcXW2oUlxaXi3Y6wzNVK8mthSwyN9GJSdFlaLb/7OyKeNxBzPlZRUm7VRFwyMiCxLCZNDkXrwPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785028589; c=relaxed/simple;
	bh=6xlOsdNtFQvupO/aiA606oH7//wRPSjZxvpMwnP1tXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8ddZdWI0ovmknzr4XOJKkb5fKyi+EJof8WCrMHEbjvltzUKLdtfqeERgUVtwHPy82dv3tTQPASItCIQ4wf8613igbavfdIvrXpl5UGX429kGwF2/pEKvQXjOS+7rLEKF7WRKEDv98lVQCM319nrru9867yx/Jc3EPsSybClIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHBjOZWk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHBjOZWk"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1395422a91.0
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785028587; x=1785633387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yjDkkekElp86d18MmpcwW2brPs8rQu9sKZ06QMKrP1M=;
        b=tHBjOZWkoDSfpgg8FhPjHS4psmMeOnPnEHT2PBLHXQwTM9OxYulQJlsg/HpI6MDg6E
         Az3hgntBVFwES4nknPa/GIEIVjN041Ji0XQwKwPQoa3E9e9lsq7kacwreFvMw2EYL19U
         AbbDGV5Axc3AsD7SxaBdhkmDjs6n9zFXaCC00ZBENXSlzCZSco7aeCswpMY24A0xYQY7
         OdL2H1gHq9S+JBBGsMvOQlJ9NbeZK5kkqjUTMOjFuxxn5v66PcX2LNj5XyKV+Pamm1Zi
         1w6U43PtBrPzO0CRwQ96C3+2XZdDUjQGCrM7v3xy6Z818CUo8rc0nJMtfwwFFL48jK9/
         cJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785028587; x=1785633387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjDkkekElp86d18MmpcwW2brPs8rQu9sKZ06QMKrP1M=;
        b=QZpzYMXyFCcM1td94KNaOLX++M8xMKgJPCIH0Gfy6bskzG89wBHwdf6y0vEc8UuUxX
         1wiP9iHxLVHdHWbJgqJOEVVPoogv1y7gNdqkJrWEqQGkU07O3I5UeCqgjSG0v/iF0CcV
         WqtPlHfQqumF4e4gTr4JqZ9BO4LIo4Zqsu5oukCiz81eZRGT1USKpbESzw56jd3eX+Bf
         Vhdd2hd+96Qmhs1zXJS6WGItQ61C/Lr040H+viFK8bLWWkwoKFGr2vj62mWJ12gKtjUx
         K5OwLew18SS9oVBU25QToWmdk0ED9SAEx5CX8YtjIGL2F6ZrhDOcFyEFFUrNqfM1dSLK
         vu3A==
X-Gm-Message-State: AOJu0YykfDUxmrxXddKLX1vvwREGYIOczhb2XyXC5J2BYxPYRvviECUQ
	HxBkwlFPqpyeStKXuifHQQTgkHnKuZlpCrlf2cUp22E6ZOGkhHby8qXX
X-Gm-Gg: AR+sD120whC16CaQuHc7nJdi5YrJYBgFBKh6GQn3Cl0eSFRIwzFeNlXfLQcIW5Qw7Pg
	cVawUea4kasD3LKmsQ8kdsNwbuo3UsbFgYuno4Snye+eMcnuc8UtaRpunX5yCl7ethfO965Xw/e
	lrshRivha9HB/UvPXiJsdr0PDY7o94kumhD7LbSmYjni3WJ1Yy8kNw68QooIfhJnW9GG8UmZ/m6
	JUzJgeTiFATp3N2zZuGAqwOQeox4l+B3N1qfyy+EGNL1MtSfNfTWRfgDYrIFa/Oue3pByWPJhoQ
	iEaL4BttlSDLrWwph7HxHrKXLDMyjA6q/KxxjVGBn6kPOggT+NvA66VlehID68JkEYSu5P8bLZR
	qrfH0+uXbApsGFmXDglebbzdEhQ7PTxPziM5qPXcOmMIMlRAO5qJb83NOHiggZN13WDsejFJtP2
	yEQSnzgxViY+/Jk0RKpiCLbIu3bfOrdR6WsbdwWjXqOL8oAbDCIyzNzg==
X-Received: by 2002:a17:90b:4a08:b0:38e:5dc:af03 with SMTP id 98e67ed59e1d1-38f29658c06mr3747648a91.40.1785028587079;
        Sat, 25 Jul 2026 18:16:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e2c2:1f24:32d5:9d51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm64700911c88.15.2026.07.25.18.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:16:25 -0700 (PDT)
Date: Sat, 25 Jul 2026 18:16:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bivash Kumar Singh <bivashraj750@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: elo: fix coding style issues in elo_setup_10()
Message-ID: <amVf4p8ZP_IDhcSl@google.com>
References: <20260725113638.5147-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725113638.5147-1-bivashraj750@gmail.com>

On Sat, Jul 25, 2026 at 05:06:38PM +0530, Bivash Kumar Singh wrote:
> Fix two checkpatch warnings in elo_setup_10():
> - Add missing space around '-' operator in array index expression
> - Add missing 'const' qualifier to elo_types pointer array, since
>   the array is never modified after initialization
> 
> Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>

Applied, thank you.

-- 
Dmitry
