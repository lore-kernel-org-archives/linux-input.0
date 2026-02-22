Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F86214204;
	Sun, 22 Feb 2026 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757250; cv=none; b=ar1CUGaaMYz4S6SW8yfo/kSLsyljDZdLjZ/8OHDYsp1KRpB1zfnfFUpj+g9dBGQEp5DDRgoJtxTiS1k0lBK9LsutcKS28gP+LH/MI77f3J69lrCwhWMmCouf6gDN6WiklRSzzIGfGdZzW+8zAK+iAfgSiaFYKp3ZAxp/2AiZ7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757250; c=relaxed/simple;
	bh=nv3FdSJDSvKylE7BUWXYdKc25UJ3VcQjv9EbnAICdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdzImf798Gjz3mqbjBdfcBnHvV0E5A5/nwdGJFYqK3/WRo6tTkDkRMSpuo+A8PUPPMZ47oGIahb0aEbreU2ba2uiV/7iylROlzvDqDwm4eR/zLq8iwfgIoKj2p3w6jHVTi5NaQyO7ohHHTDMy+qYi7z2AEXYR81EQBSPh0VMDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru0vAOjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru0vAOjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5530CC116D0;
	Sun, 22 Feb 2026 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757249;
	bh=nv3FdSJDSvKylE7BUWXYdKc25UJ3VcQjv9EbnAICdAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ru0vAOjSXfGEDLYDz/nRQTuycmR/ja8JJ49FmmIr2K5qnJqU8xHqhaTBpy56BkyzB
	 nRuJ3INYXuhPWiJOD0BTX0CiMzrRlIw1x4byUI9T0vnqHGdBNozxaCUvrZvg9L9nba
	 drQNhW9lEPU1UJN9Fb2opnK1q5PBfmQnIdEYzBAItJBkKQ3uK9nNOAtJSjevIY5zdI
	 xOJLRZ8T3oS0WxSswc4hv/4od2wHgd47riDjxy77ATVRKV9/vEmzCH3c3p5RoGsCAl
	 Wz8C5Urd31lt8hhPjUfaT0KdJy81E1ceNhdlqkVkKhdWiEpNFtY/6+MRFtyDRo0rtD
	 Or01omqhzR6Ew==
Date: Sun, 22 Feb 2026 18:47:26 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] Input: cros_ec_keyb - use BIT() macro instead of
 open-coding shifts
Message-ID: <aZrevmRl0NcPmcCm@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-4-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-4-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:12PM -0800, Dmitry Torokhov wrote:
> Using the macro clarifies the code.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> @@ -780,8 +780,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
>  	idev->dev.parent = dev;
>  	idev->setkeycode = cros_ec_keyb_setkeycode;
>  
> -	ckdev->ghost_filter = device_property_read_bool(dev,
> -					"google,needs-ghost-filter");
> +	ckdev->ghost_filter = device_property_read_bool(dev, "google,needs-ghost-filter");

This change seems unrelated to the patch, but it's fine as-is.  I don't think
it requires a separate commit.
