Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3B3E8C59;
	Thu, 26 Feb 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117937; cv=none; b=OOOIGaNJ5qfhPpFHvbF2v5ISlUA7wS6NUgRyrqLskjBP72e7UWRRKRVWHrIwooWOxs1hcwrZWgMt2GAk6k4deGo0xP3oO4Q64Sjcz3lmSHP/IxHzhX6QqOGeh8M8YyVPbniYvkNpyG0itdllsJ/kSWP4CW0F7r5eCgUxGXHfcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117937; c=relaxed/simple;
	bh=9Krbi28LMCFf6Mv9ssqil53z02XaA2xacWBX9y7hPDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iqDyXZCfKQ2FsAlEgQhE9+pIshgCxtyX7N3r8wR0n8BQ3sYrJCaXlJzXz26442H2oylK9CAbsKYTmhcBVCXYrHcotD1Fk1cVf+i78TTUO8+bdLGpOQf52FGwLt0fNNm0iD8GhD21S8UxcAB0vydy+Fx0ZcdK/KL2Y4T7zLzGy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzFADaJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzFADaJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818EFC116C6;
	Thu, 26 Feb 2026 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117936;
	bh=9Krbi28LMCFf6Mv9ssqil53z02XaA2xacWBX9y7hPDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BzFADaJFp7+livVoi8bL8shpWi7ra6fT6CDDHXVuVQWa9Bu2msMtIJmNQhYkBzurx
	 J7tIk9h7zMhq6REfdYoKf4+JRMqZ4AggG2Iv9P4RdG85svbHfx+HpyuNo9lKT4qlP5
	 C7Bk+n56Y2sNuBE0+OWCl/Kt6GvUhZjcehxnzD+kUO0kqbusGRED3yOGOa6J/1WO1X
	 Ri6h4YlaYKuWMcXaMmXtq6PAom1mpY6tRncre1hQJ5mGKc5lLVIl9EtAHgjpV4XICv
	 nOke/wYwIP36A+LqqC1JcgWAtLknD1kkWbFwX7yYFUzh+rCdFtWV6qzx3kQ1SIHqIu
	 2OgqOuUEpKBXQ==
Date: Thu, 26 Feb 2026 15:58:54 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Ivan Gorinov <linux-kernel@altimeter.info>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] HID: winwing: Enable rumble effects
In-Reply-To: <20260226054913.GA8668@altimeter-info>
Message-ID: <s44p8pqp-6934-0r6q-n712-o5p5n2qs0429@xreary.bet>
References: <20260226054913.GA8668@altimeter-info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 26 Feb 2026, Ivan Gorinov wrote:

> Enable rumble motor control on TGRIP-15E and TGRIP-15EX throttle grips
> by sending haptic feedback commands (EV_FF events) to the input device.
> 
> Signed-off-by: Ivan Gorinov <linux-kernel@altimeter.info>
[ ... snip ... ]
> +static int winwing_haptic_rumble(struct winwing_drv_data *data)
> +{
> +	__u8 *buf;
> +	__u8 m;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (!data->hdev)
> +		return -EINVAL;
> +
> +	buf = data->report_rumble;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	m = convert_magnitude(data->rumble.strong_magnitude);
> +	if (m != data->rumble_left) {
> +		int ret;
> +
> +		buf[0] = 0x02;
> +		buf[1] = 0x01;
> +		buf[2] = 0xbf;
> +		buf[3] = 0x00;
> +		buf[4] = 0x00;
> +		buf[5] = 0x03;
> +		buf[6] = 0x49;
> +		buf[7] = 0x00;
> +		buf[8] = m;
> +		buf[9] = 0x00;
> +		buf[10] = 0;
> +		buf[11] = 0;
> +		buf[12] = 0;
> +		buf[13] = 0;
> +
> +		ret = hid_hw_output_report(data->hdev, buf, 14);
> +		if (ret < 0) {
> +			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
> +			return ret;
> +		}
> +		data->rumble_left = m;
> +	}
> +
> +	m = convert_magnitude(data->rumble.weak_magnitude);
> +	if (m != data->rumble_right) {
> +		int ret;
> +
> +		buf[0] = 0x02;
> +		buf[1] = 0x03;
> +		buf[2] = 0xbf;
> +		buf[3] = 0x00;
> +		buf[4] = 0x00;
> +		buf[5] = 0x03;
> +		buf[6] = 0x49;
> +		buf[7] = 0x00;
> +		buf[8] = m;
> +		buf[9] = 0x00;
> +		buf[10] = 0;
> +		buf[11] = 0;
> +		buf[12] = 0;
> +		buf[13] = 0;

Do these magic numbers have any real meaning, or is it just mimicking 
observed binary stream?
It'd be nice to have at least short comment explaining it.

Thanks!

-- 
Jiri Kosina
SUSE Labs

