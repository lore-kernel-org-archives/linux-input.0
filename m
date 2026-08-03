Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D733FE33;
	Mon,  3 Aug 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779543; cv=none; b=t4ETb4Oh6nh7dNnxkTSFhJWkSUf7D9e/YEtg6cTRFmvWzjWPnT9ilPX1Y289KLQIXwdMw9lvbOwmQ2J+JzhMvzA/4g1OhRd6ywxvF4scKVsprPzPuw3nGC3JjAeNyAtmWy7N7a1DUNxUoYBdhRfVYeUAqWOAxQn83S8IL1hSGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779543; c=relaxed/simple;
	bh=IhcRV3I4vc6RujPp/HpqFCpolIAcbaZJ47t8qTte0fA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hs8t1vxceDvQlLcvA6s8gOBdqR0zSMacC6nja4WPa3xr8/kAxKlhJ97r3gUUD0KOBrIElpsZ0pD3NjByiw46h5j/poNgt8wYHnaJBUTLi92W/kvPbPSwyVj2gmb804w0XNfm8/uTk2r4VRRPWwzWvsuTs8b35wK0UC3/IhZrfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZWaxZ6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZWaxZ6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03671F000E9;
	Mon,  3 Aug 2026 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779541;
	bh=Pgy0BJL09XR08RqFsuBtd4EX57TcuIZMksSgeuPRGfM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PZWaxZ6bUFTnIVbIqvpfDPg4Pe0m7FhYoMq17MYPXEBhtv4gXNYE/5w+y1JxvJxZv
	 MfCMqI60nu6q2+ML6RekNy2tljy8vduiBGeIVoVnXz7keJ1K4GAoMAH/ippWW9rNOA
	 YlzHt2TasyZfN9W2EfURK8Fh8xPLfd0TXTijGxlapsMXQBWBCCvWEdJZMkDNncrd1J
	 /XnilDoW6E1oGTWDU28AiRlJR+otYSzIZ4bE2GMpNABcybo6VWHx3Ve4+Kx7R4rmbO
	 imv1ANmUgqj4AKdBtIAuB8FCfQHkrExIQX9WjUcIJBQlmvWCX6JSe9PiAE3Uf9yNZy
	 6WGcu1dEI2JLA==
Date: Mon, 3 Aug 2026 19:52:18 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
cc: basavaraj.natikar@amd.com, bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: amd_sfh: clear hid_sensor_hubs entry on probe
 failure
In-Reply-To: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
Message-ID: <527no024-6364-ssqp-nqr0-806r624onr44@xreary.bet>
References: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Jul 2026, Chen Changcheng wrote:

> In amdtp_hid_probe(), the newly allocated HID device is stored in
> cli_data->hid_sensor_hubs[cur_hid_dev] before calling hid_add_device().
> If hid_add_device() fails, the error path frees the HID device and its
> driver_data but does not clear the array entry, leaving a dangling
> pointer.
> 
> When the caller (amd_sfh_hid_client_init or
> amd_sfh1_1_hid_client_init) detects the probe failure, it jumps to its
> cleanup label, which unconditionally calls amd_sfh_hid_client_deinit()
> and subsequently amdtp_hid_remove(). The latter iterates over all
> hid_sensor_hubs[] entries and, upon encountering the non-NULL but freed
> pointer, performs a use-after-free read followed by double-free of both
> the HID device and its driver_data.
> 
> Clear the array entry in the error path of amdtp_hid_probe() so that
> amdtp_hid_remove() skips the failed entry.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

