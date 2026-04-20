Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36727E792
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644042; cv=none; b=BKed+21kbWWdTVx8K4fW5NtSV6UE7g2ZoZU3vBWDUByYWc3Uje1TNa15/5/3RNJCiQ7FYssQbCA27IiIODPhyAyhpYbHevdRaPhc87ofPN9pAmyXeQXrykyxA42oV3MBGskffu4fIXmjsc6NnPrSOPG2V6uWGrmo7Yj/aq+WDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644042; c=relaxed/simple;
	bh=8e6o2e3S2kEpCh7AnUm8Lw8k4A5RfrAJ6mTx35sXCWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH7qMLfpm/CBqGXxjj+tY7hZY7oIYJl5xe4DCEfhtaFrkTo/QJ/9IMB/PzWZhLnqRsgcFrIlQQIl4+dL//XzeWzPE6fg0bDspfYJIXBTqYTLRyWi1P0CnoIx+JArP3eSuz1SEi7Fc6qsyX0JzO+XXEtx0pbzHOi+1VkdPN2cyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6zSy1tM; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6zSy1tM"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2de831d2b20so4984116eec.1
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776644040; x=1777248840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQb96jxVBSn1C0UL8YusHfEi4afe/T/8UPw4t0TEFHI=;
        b=o6zSy1tM1wbRw+6bcSBnRybTMGq7xiM2L1J2hlwOWlnURCk/LW3J8037WeKj3aw+vq
         1EnmlP8vgoynuessjLkCNFsve7J69YaGZhgmW2HrgRW6wSUFK/6hIQrqruumnZLPxp1x
         QzvNMm2KbqO5Pe7XjKwn+9gtXF7fP4wDbjuXFPsy4nI2uoX2K2lACziYCRNMb5vKUrBW
         afvMMDrbPcyvwpOxcUF8OoOGaPXgIKpMFV9bAEF3HhPPLqvlqRjXB4qwJtNiEtlJm5EE
         95uxaFvw0rFjI+I/1A8gQaKruleXqQv6njGs8vxcFRHsjK5wszENXQ6NTA3RbQwJwH3c
         9flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776644040; x=1777248840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQb96jxVBSn1C0UL8YusHfEi4afe/T/8UPw4t0TEFHI=;
        b=R1YNMkLCBZkMlAS28Y901Sx9WMMhCh8SbMh43qKYuoIPWEPhHK8EOb83OVqH9Slckg
         N1cso133y106U6MCmkHIT7x56lO5pDZvCGT69en91t+RwDYcLnq81C7MdSHmBK997Fra
         NqqUB+n+MwNYfVGWUbKznUvL+A7BliY+AsyQt+VcCIl7rDvQ4Mo7BdH2rlyGkYbbsRgM
         DejmIq/LFZkof1iroK26uZVkSQnldjcymex1silx+HUKw0faVXjKyd5vB5NxkszQ+58B
         LSWnPqOlmueT3wHDRYkdiBcX0/rfmHyQk19eqT5HfFEUXQdWApjZUQKeWiKV/Iv1cxMJ
         oYVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Pk1/2Wpftr6kpKnbR5CoxSVfsRzL4S2kWYea0TNw08RZORp91xyOrtizeQU4IwJTjyNQ1KLAbVtdmsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTvO8pE/0W67j4L0f0oQu2pi04wF3CQ5gNKjHCBakAOYG83c8
	7BKnOkmgxUQMfW30+K3UPZiL1XzPvDwgqySEvzW94IuM45bNjPb2Pygm
X-Gm-Gg: AeBDieuLBJ1WaCBq2SXvnF8pLn9vZNl+iocy6KGKVnlLuVIl2j8iNEncCXzPOyfjTUA
	BMxZciMyNkB3ysvkO+Nod0Wuc3T+YmQWpgyiyjqVWG8It3gz5qyFeoTx9DkLy22TIfnS97FNtFF
	IiFV9eeOiHFwqiS8dGxKfqqdNl6cd0XfF8Q8ciC0kjRQAbKzx3eaFxEB9gE2E4IYoBXfYW+9gle
	sts3+1Vqzh8l0wo00wX1YM569daglkxtI1djMf1MZgkxcgd9EfRf2obAxvfY7v/FWL2T88TqNfi
	f8LTzJEcdUK+rVNydn2HkU1egYBtXgtmdYa8PWuYngxG0WvartQGmn2lPOZXHZ5FYVNmEALEYsK
	3lxPdXDv1yZQuIucFGchco/UQQ9evIOiZiFEBYhd7C8J3S7/cFlN5P71oAJKIs+JfAdLMU8DZ6N
	73SW1y3rVoKK90I3kJKkomtJjPzwnuLqss9Hdg7JEqxlbKf+d6j9IM8EVA9iSvOEVHGDVhQxU2d
	w4=
X-Received: by 2002:a05:7301:4586:b0:2c8:7172:3b7b with SMTP id 5a478bee46e88-2e478646190mr6601303eec.18.1776644039839;
        Sun, 19 Apr 2026 17:13:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1a4e:4965:5dff:cdee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm11587954eec.14.2026.04.19.17.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 17:13:59 -0700 (PDT)
Date: Sun, 19 Apr 2026 17:13:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: ads7846 - restore half-duplex support
Message-ID: <aeVu2-zlzl-fn1dN@google.com>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-2-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419161848.825831-2-aaro.koskinen@iki.fi>

Hi Aaro,

On Sun, Apr 19, 2026 at 07:18:47PM +0300, Aaro Koskinen wrote:
 
> +static void ads7846_halfd_read_state(struct ads7846 *ts)
> +{
> +	struct ads7846_packet *packet = ts->packet;
> +	int msg_idx = 0;
> +
> +	packet->ignore = false;
> +
> +	while (msg_idx < ts->msg_count) {
> +		int error;
> +
> +		ads7846_wait_for_hsync(ts);
> +
> +		error = spi_sync(ts->spi, &ts->msg[msg_idx]);
> +		if (error) {
> +			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n",
> +					    error);
> +			packet->ignore = true;
> +			return;

Sashiko recommends trying to power down ADC on errors, what do you
think?


Thanks.

-- 
Dmitry
