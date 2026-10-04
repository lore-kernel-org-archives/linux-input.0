Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0337412276;
	Sun,  4 Oct 2026 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100339; cv=none; b=FKCDd8LSM3UUZE7W6MJAS3MjCdB0v74SUvp6qBZqb9w1NyLWqiWHbBzaEjLFW9TU92ELpMmh/4ZK4+KWWoe5eFPpIfCt07MQsBiSIIaMQFqC+IUk7wPBL7LtwQqhXZ0a9UPzZ2NFk1spHYLY1Z+cXzgqCpkuK9OvUuDairxT5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100339; c=relaxed/simple;
	bh=WXmH2dYXDFZZ2ee/o0Y1LUnNSiAW59zVSwnusNzFKQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDAF8b6qHxtNU9c8AIA0M9+PiGkqcpJKvseh0/veB0qEPy/B2ZotYVZkXhYCq+03sm1ltPVvtXGIwJuvHNgjvRZiJ1HtVEK70e+1+s7dxxu2mf5+JWmWIqOyMIpPxZsd6+kGNV4XjB6X3voFuQQDExyXGbxhe8uHcwTPoLgaPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6LwYv+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6LwYv+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56541F000FF;
	Sun,  4 Oct 2026 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791100338;
	bh=HPhnCbH5nfK+KOXs9ChJxFjkxzJXKQLtLRJEkaP4nBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l6LwYv+EDwQI+sAFvT/invRE8QA+hGh7IMbXyDd8hw2rQgbgu2UrKb4X4YbP+HHW8
	 fbNguDncoz3kP7B+cD7+GE8T49++d80Q4Qff0Dkd7RfghulrYer12hDyEas8Rg/VdH
	 FNhaIB995odCh0F2EKowN718JQjj/L6FesfyDg/PbKFQPapeZHV5Lwi6ORwBh6N3x/
	 iJmg3H4ltUSNdT+anEsp4p1JW6dZkyl2YoNsYgD/T9b6bEUci0Hyb1PV4HMmQ2LXx1
	 WemuxvwVKjx0S9300PG6Ukodhrm1bM0gdzlJh1T57FNf/v5lAdx9QFCC8BZsAqm1B3
	 Xkk3FC2KtbfNA==
Date: Sun, 4 Oct 2026 09:52:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Lin <allencl_lin@hotmail.com>, 
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>, Felix Kaechele <felix@kaechele.ca>, 
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 3/6] HID: himax: Add DRM panel follower support
Message-ID: <20261004-walrus-of-angelic-performance-5f09d0@quoll>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-4-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261003142741.48634-4-michal@nozomi.space>

On Sat, Oct 03, 2026 at 04:27:38PM +0200, Micha=C5=82 Kope=C4=87 wrote:
> +/**
> + * himax_resume_proc() - Chip resume procedure of touch screen
> + * @ts: Himax touch screen data
> + *
> + * This function is used to resume the touch screen. It will call the
> + * himax_ap_notify_fw_suspend() to notify the FW of AP resume status.
> + *
> + * Return: None
> + */
> +static void himax_resume_proc(struct himax_ts_data *ts)
> +{
> +	himax_ap_notify_fw_suspend(ts, false);
> +}
> +
> +/**
> + * himax_chip_suspend() - Suspend the touch screen

Why are you explaining standard PM functions? Not only with comments,
but with kerneldoc?

> + * @ts: Himax touch screen data
> + *
> + * This function is used to suspend the touch screen. It will disable the
> + * interrupt and set the reset pin to activate state. Remove the HID at
> + * the end, to prevent stuck finger when resume.

Only the last sentence is relevant, all others just repeat the code. We
can read the code, no need to say what the code is doing. You should
explain WHY, not WHAT.

> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int himax_chip_suspend(struct himax_ts_data *ts)
> +{
> +	himax_int_enable(ts, false);
> +	gpiod_set_value(ts->pdata.gpiod_rst, 1);
> +	himax_power_set(ts, false);
> +	himax_hid_remove(ts);
> +
> +	return 0;
> +}

Please take over the series and clean it up from all these vendor kernel
monstrosities.

Best regards,
Krzysztof

