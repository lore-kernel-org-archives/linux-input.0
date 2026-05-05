Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A535A3AE
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956329; cv=none; b=ASInHf/kX72FzExcMh8N48F1q+KaPTNvVlQ/SpjFTsw+d6dfxGUR/D7M8Sr236Ibq4eKQsCBi3Zqoni4x407Ee/3B7h9MZ7/Kw/FRM4AKg061iN3KuJC1+dVUkXQlUddg8T++/XREwLjhYLGSZwSn/D2PEm+PwHQo8aTQxPtx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956329; c=relaxed/simple;
	bh=QlNQ1CHW07FnLlbPXvDmNwAFbmH5P+YPv/EZqeHbcAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWqULsaGbLKVDzNP4w28tAKc6/WxFG7zeCEpqTdBU2ww3T68/wSJPnZVMJ7t2Sqo4odotI7JATqw5L2rJZLv/cRndS0i+dIGuXdv3b3HLuJmMibWSuneqUPe7v8yXPtTY75S+Fu2cqX2JqWAv9WUF5zJof7Wb9HELgF1xdnEE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+bAjIEh; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+bAjIEh"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0ad52830cso3284385eec.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777956327; x=1778561127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc0Sy8vq6FNzAEiI6/Rmeu/zFs4QicwXo3tqvVWtkD8=;
        b=g+bAjIEhB1SaZf26lNKgGUzuHjpN5QKWnsNc+o+o61AHhQTaUm7dfpypcGplgRZGuo
         +/cVvSK4YzlrIZrTLnhg5vKPJPgC5uJzyzI8QUD3FJTzqWfcaUEXBLOe2FEMWROVSkGL
         ms6D5timZBcSAezIC9j9otElTJ7pMqTfkS9yjQQIxCAZQ7yjIvoIi2E8Osi5tFcJdZAx
         gSfYER3d7mrixvGSmLFchmmM1bAOQLJfrgJe77enSuycVmkodt/vT+tc/UtL6AnlGVoM
         Kw7ZVCWNI37ZQCzaG+9PwDDu7MZjWto2AdBMV09fwPuY1jrwLF9B7QQP+op0RGnqt1LN
         DmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956327; x=1778561127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc0Sy8vq6FNzAEiI6/Rmeu/zFs4QicwXo3tqvVWtkD8=;
        b=eJBQ3px1x4EkrqJdOg0DRt827y2/HeuRFN6ONmMNIPN611stxJff44mP2Wlc+XlSLU
         AWd973+vj7IuBaieqsk7nC+QexFHg6j+rDgmnD74SUjv9CSNhw3o3KTIobZFfBXC0JeT
         mSZRwfwWmN5Hlu+SJLtcQfD+bPcvwbXpCd+2d497PfNKjst1XuUV7SXwiM69GQ4C67GZ
         9GKcT9JsZ38DqinGa3Hgc6auJUGaGjrV1OI0Gv3HQ8kKZYJGez19r0De2dwbCZkvzYe0
         74YppFT7BdKx7ZCG+B9N8oXF6NcxY9F1DiuLyB64uSvJGLJc7NNhxH0ZXcvyAc9U2A8T
         L0vA==
X-Forwarded-Encrypted: i=1; AFNElJ+useMqm9tH+6I0eJjYiRYXT0sNXOHKj+n3WkDO/PxVaZ1VXKBIDRnIyFtUu1djFFszSmDqABhf/5qttw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BXANPkeDOCvb+hqfwf6IRxNV0mTUsCQj/LRr3q2lj5mA4X44
	Yhb3duuYZhKMg1VcHiFoT7H0Lk454YT4/va+a84ktcOuOaykpt7dI1Y2B/chaw==
X-Gm-Gg: AeBDievd+0MtZKOuipG2Mn+faLpGkbjBIn3tYr/p59qmE1Njlg8Mr3uI1S+ox/9UhsY
	cd4HpU+B2J7TX3eZhKPRVP1yo3P05k5n9okRDhMcjubM7R4jkX/a8OYn22VWYI8Rgt280yKQ1fK
	GbFKU+487k6L89RlD+f0nio1WILnfuuE9NuJev6xVE4PrAPC/r8JvwRgOyi5JngtkesOvGL8Obc
	sZFNBJL1G+bzs4h3nou0rKOwueML6fKHwkDD3LGv/QbZbKUlKezrO/xwvS1++jMnbTdx/VwHNCd
	EIGuRGfjJGppLdZItOY4RRX4Ocitq3E8k3GJjlt8OweQES8MXzD5jL/jxVGCU8OTVc6HKfvP6R5
	SSFfuj7iw8Zajg2hcrHIKpoJms2Vul+y7w7e+5bfa8rpyVExn2hg+9os3IEEZndDqWnyduSEJoA
	MUULLv3jrjJExoWiU2TQl79jTePW3iDMAZWepUGBkDWtvXloNZHnyLhtKbtz0L+DHRYfOgknY4A
	qE=
X-Received: by 2002:a05:7300:5b9e:b0:2cf:28e8:d784 with SMTP id 5a478bee46e88-2efb9c84f2emr4962937eec.19.1777956327189;
        Mon, 04 May 2026 21:45:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f3bf67cf8dsm3627254eec.6.2026.05.04.21.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:45:26 -0700 (PDT)
Date: Mon, 4 May 2026 21:45:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: ads7846 - restore half-duplex support
Message-ID: <afl1zxCOyzd-al-N@google.com>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-2-aaro.koskinen@iki.fi>
 <aeVu2-zlzl-fn1dN@google.com>
 <aeZ_M7jjisCExva8@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZ_M7jjisCExva8@darkstar.musicnaut.iki.fi>

On Mon, Apr 20, 2026 at 10:32:03PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Apr 19, 2026 at 05:13:56PM -0700, Dmitry Torokhov wrote:
> > > +static void ads7846_halfd_read_state(struct ads7846 *ts)
> > > +{
> > > +	struct ads7846_packet *packet = ts->packet;
> > > +	int msg_idx = 0;
> > > +
> > > +	packet->ignore = false;
> > > +
> > > +	while (msg_idx < ts->msg_count) {
> > > +		int error;
> > > +
> > > +		ads7846_wait_for_hsync(ts);
> > > +
> > > +		error = spi_sync(ts->spi, &ts->msg[msg_idx]);
> > > +		if (error) {
> > > +			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n",
> > > +					    error);
> > > +			packet->ignore = true;
> > > +			return;
> > 
> > Sashiko recommends trying to power down ADC on errors, what do you
> > think?
> 
> If we want to re-work error handling, then I guess it should be done the
> same way for both full and half-duplex modes, and belongs to a separate
> change set. This code has been in use quite a while, maybe 20 years,
> and I haven't seen those errors in real use anyway, and AFAIK there
> hasn't been any bug/problem reports by others either.
> 
> Maybe it wasn't so clearly stated in the commit message, but the patch
> just restores the old code verbatim that was working fine for half-duplex
> mode.

Fair enough, applied.

Thanks.

-- 
Dmitry
