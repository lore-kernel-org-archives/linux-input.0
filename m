Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB45242D7B
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944001; cv=none; b=bxLnm1Vzew29q2MJQRg90+5tx7pMTdhTc2WNv13czVzZsOgOPwU8A9PX1I5FfwUCBVbUfH/4c6IzEy4exO+fHrjRqb5J59mGDe/E+kFpGxCCKtc/0DfI1h8zIM17F2pd+u2h3u4JgdP8aaq7oM69CLue+XBc1UZcODeO93WmyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944001; c=relaxed/simple;
	bh=ToVhc3AhBahetbU3qnqMMwbQ2+rzSYcR6RO/UlkrYnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFMXVOPpDQrRQCZLQGErGoY6Q2JFGKCLrqNeowbM4FocW+iCS/f+prEelVkREua4CJBQdkGEXLz4BPTBSXN8J07doieRI0xZgul9lo8LBhDJch6O5Xz2oiFqtH4iXQD+jGGVhFGs0J6QbCmuaii5r/RgYHJOVHVLNOZENMiqpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evetzjdL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evetzjdL"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1111188a91.2
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784943999; x=1785548799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eV48ZQHtSwmQ+39i7v6iCNrnUnn9zhxOQgslZYAxE2c=;
        b=evetzjdLLFT6PmhCTwkph0bX/kgsxSIURBk6XIh3EKuv8dtCAybtdGxmaYWz3Cv7UO
         fi/49nLPWPM0peEyKHtTeJncwc28GjMapzgXAO3Ira9yFxPiwXxt303xXC+9p+GFQX/c
         JTUog4ZavQaY1NCHpmIrjYQURXjCxCMniFDYbY+6R4pl5w7A65q3gZzTG+lLVehTrmEx
         G/65opCJ5qCWP7g0HXhhWfswkHbz61N2bzYWh/Lod02yaq6JKt8VjttLuiPzbaNNGzLF
         IWFtw1NDqKVc4gV5P3WSK/QBcFnzsNxtDwtDeoZs/CIIKz3ni2UQ+0LleFFfB7ZJq/Ew
         zOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784943999; x=1785548799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eV48ZQHtSwmQ+39i7v6iCNrnUnn9zhxOQgslZYAxE2c=;
        b=rWdrpGTTZoLTlDBuplywIIW0qT8DMyEarQI7CWUG00QSv/tO4l9EwjQ0ZNUwdM/G3s
         kHasSoL02okjYC2D1M3MUvzc2fZommqccqia95tTW/BsqOLwsrjDsBMERmxFbxzkQVuE
         22RkRkF3dvzpE5u6QJa1y0cDrsQ0XD1F6GqOd3Ll1vjRX/ujMMt9rxkBTaA1m89ZvWd8
         5r+3dhFcne74WV5YIcH8II1VYt7E/1fYzB49p1awqTAVKDJPyf1CwQaAgqReILJymUKy
         uH7CVaO+d1TkD1XAU6ZjMe6LDG8V6Vzlvxr71FkUfekcCIakzT2PoJa1XCAxlzgkFT0S
         gN/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6+ye2+sDT4jk91HTdTZFJtSXm4vUQIcDPg7DDkgMZ302FuvC3AZdbS8CclTCFTMERqOzHCUOiNzVYTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0PWWpmKVvb0iE38VErIRn1BDkHJ/SDSJzrwN/lnzi4ltUDKm
	7+L35UwtEtTyv65/h9pdsuJrsh2JVE9yvrgufE9FjC5ic0pNlGDlUCcy
X-Gm-Gg: AR+sD13MSJ3fukfjgribCCIhKHFcBnx3jEI9y0aazLXhrLmxKfoziiDGBAOZb4H7KN/
	Zg44Lm3kseBoOgZMWJYsY2mvjQeNKhz7kARtfS8owLkaeZGgzFFFx/Bc44t7Gg7uOMQg/gN+Dy5
	rtbZTfnbvxNmS+Wg7h2gLNY/ExF7y7cMzFT8Oe2OXcEgyedZhr+XqFHKFnf14nIod+bIcirkh3z
	Y4ai1/H23le/BD3jAZpzZkaxYeGt4bcEd59zGcG9eHlUnNf+RvYBVd+5bBhLLuIxt/92jr3sAl2
	+5XjnOw2RA7vizAgVfoJ8JQR1fpez7AQDfBUiMsZCCFNXaXlxrj00IGHOU+mkLwn53fdpAjyvrv
	cHU25Q2rzWuVCNsORCZdvoieFzi33GJMzxFm03TnDor/BgPjckeEKsAAUMaDZ8kqxzA3x3nGNL7
	jkcOLJ4/tpXMa6E/uNGO+kjjB7dINtMnojmMOTPXRNgcjXphCZ5KhUrg==
X-Received: by 2002:a17:90b:5443:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38f2961e0e6mr756142a91.26.1784943999088;
        Fri, 24 Jul 2026 18:46:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm4637809eec.17.2026.07.24.18.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:46:38 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:46:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, 
	Tomohiro Yoshidomi <sylph23k@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: psxpad-spi - set driver data before use
Message-ID: <amQVSXuehlUKEeCy@google.com>
References: <20260721055551.1714965-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721055551.1714965-1-lilinmao@kylinos.cn>

Hi Linmao,

On Tue, Jul 21, 2026 at 01:55:51PM +0800, Linmao Li wrote:
> psxpad_spi_suspend() retrieves the controller state with
> spi_get_drvdata(), but probe never stores it, so suspend dereferences a
> NULL pointer. Store it during probe.
> 
> Fixes: 8be193c7b1f4 ("Input: add support for PlayStation 1/2 joypads connected via SPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/input/joystick/psxpad-spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
> index f902a56d011f..b1ab2486bb0d 100644
> --- a/drivers/input/joystick/psxpad-spi.c
> +++ b/drivers/input/joystick/psxpad-spi.c
> @@ -301,6 +301,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
>  	/* input poll device settings */
>  	pad->idev = idev;
>  	pad->spi = spi;
> +	spi_set_drvdata(spi, pad);

I moved the assignment to the end of probe and applied, thank you.

-- 
Dmitry
