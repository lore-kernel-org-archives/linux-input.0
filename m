Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375E28C5B1
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349044; cv=none; b=tppxilGUQvepX4PI//Kh7Jn7cGEiW05yVEGgvithnuR7DGY6ftam2fWQ09q0l/AReAtVASNcmB+UabTxGsssd88+BjCaWXRC5Y6IN/DZhdnpJTzIBnshBeA7at5FJpy4rkalXjMqYcBtiMP41iAopWVcZDR2abbB4wUhSEs5N3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349044; c=relaxed/simple;
	bh=jFM/DwXHjkKXAHQoUXYqUXKTlLXJhLvu/J7v6hlyZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0tTjFhZ57+QJOaIgDMd6y/Dzv2qzomHHInk7HUTh4uMqHAnRcso7y1UhxUOCit1ztScAkbpEZuk1NpoGnHtUIiLy4wtl/Rp8//XilkNXJuVgAPQy1LwEPLjefhteJnfJNm3RAtKmLmUUcQzKsDeAq5AfKSNuh0u1tTp5mPeqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0BWg6mJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0BWg6mJ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso1509266a91.3
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789349041; x=1789953841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hnFkbktqoVqh7KvfNL372TtJBe46jI4r1nKfWafzrAI=;
        b=I0BWg6mJKTHFG3nGKLsrqQ8/73BBIFltQA8KnZ2K1B8YSyy5hpzd8CA0pb5kiL5gyD
         fRSLfKuJfTGIu/Eb5OPAqFMaAYPQ5nryUdskcZTfMyn/0/2so48vXFc8+0czd2gfyTRm
         FA9IFsOL5C11iBIpxxvAA9DWv0Dw+uv75OyGXHaVTPA9BJxiIebM3rswBXFB5V7O+TkP
         m6d3cTX+chg2io9KG3kkGe70QW2iRCmwe/0kWObYe29sRK6aoxn6d6DdHxjgzlxICGYi
         YU6N/AE2H9e5S10Asypw/9SZ0ZfGJmQhN9AXwyUXRnFJ8sD45cGvktgnI7kz2Lx07zab
         QJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789349041; x=1789953841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnFkbktqoVqh7KvfNL372TtJBe46jI4r1nKfWafzrAI=;
        b=Fuaw6sOS7RImYv1u5fzDMuOOLfuGH97XJL2AzgwztEgi5jHhH6cJkh19FdSZ9/HNxM
         bpUNyI8KiZtKa+DMPchmC8tfrMfoReB4kLmh+YJkBtV/Mw9Pte69qQm1MqOsvDWVxFnI
         ApZhkNcz6xGPJfWuXbfdiKnMNbpsfXHB/r/I5l9RY0ctpjuoKWmqKmQkok8OllxySBvv
         m6qsT4UyyauyXx7vb5YD/gUcJ+Lun/e+rQmdXfJdlLih3HLXjcC4wRSahGXG26mu6pO6
         zVE+4dOOKRIYeSiRCMU+w/1MtbMGsEozDoMrCnMbQ3e2L8JEC5sOUKzuIPrTCTM3uNKO
         u1Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxsR+V7Cw7SAC/GzGrRcHD6rKJ77w+WFA4oFOQsxtUutBTMbrxG6v21CisIewbzBsUY40mVK23QzthuyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lWIatgd0ju4NWV7NH5Fpwqrzqk9gX2ScdyKmAS1X5f6zU07Bj/
	0gQdgPVqJrS/zEL2zRH1Dz96WDqOO6AM3/OjKQNCe0sw0zelmnqdTIzu
X-Gm-Gg: AYBFou1NnGxe8MySjWqQsV2P49Zb8gn4Vhy/c69l5UB9fY59CTh7ynhF8wN7HaVu4JO
	+LCA7BMJv0leTWUzwXSa2sCMq4XOTfqhcn9wc09ht3zGoBMZ3/24r1/o93dXcjs7ioK4qLJTEZW
	Qtx1N9TGW/0i6oRnuhP4/uOjCP8UPE3yx/q7SodeGyUI2nIv8ddF0Bb0yGLPljGRuusW+qXG9jt
	eVGSKJ+bbh+8DEeO0KTNsSZEYSRaD+U0fi0g+COioYSNjQwj/xF9ix8tPabHDvvXGp9DoWzoQP+
	1PppfCI7+322dNBvqwcptnoe94rVtgIH9zTO/M6XLWG/jnVDlNUXeB7wZOxeffkKUWy6S1T4pQn
	vt9g4N6lfXzmKH2Z6ibjpJbJTJbSmvkAsXuNj4kZNUqTt58YudwXPtQAGNheqvBSucATnmP4KGP
	RVfbFU5raePdL3nmSzUhCVmpXUqsIb8ctwdLIseAWQzVpFzElJ5uRlynr5i5BeYNThq6dIa3J4G
	3Dmbyr1C/pWqlM5o094DqkV/a3XbOKwS7/84HgvFsdA10+hZDM=
X-Received: by 2002:a17:90b:39cc:b0:39d:e54c:8658 with SMTP id 98e67ed59e1d1-39debf547abmr1067411a91.5.1789349040552;
        Sun, 13 Sep 2026 18:24:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fb3ddasm20363582eec.30.2026.09.13.18.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:23:59 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:23:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] Input: hp_sdc: shut down kicker timer on module exit
Message-ID: <aqdMplrLuOrSU08z@google.com>
References: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>

On Wed, Sep 02, 2026 at 11:40:04PM +0800, Runyu Xiao wrote:
> hp_sdc_kicker() rearms hp_sdc.kicker with mod_timer() after scheduling the
> tasklet.  The module exit path uses timer_delete_sync().  That waits for a
> callback already running but can still leave the timer rearmed.
> 
> A callback can therefore leave the timer pending while hp_sdc_exit() tears
> down the driver, allowing timer activity to access dismantled driver state.
> 
> Use timer_shutdown_sync() for final teardown.  It waits for a running
> callback and prevents rearming after module exit begins.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied, thank you.

-- 
Dmitry
