Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176879;
	b=U+InQlfWuljJCFuS1uMmrIiNH1y0qagAINVkOrf/GjoPEacbZN5xWsHzXVl5yaw7LWx2
	 A2NyR7tEYdhf0W04brHQVSZpn24nU0GbYwSP2wogs8LTU+Ha/QljUGypzjdwDN2nvCGiI
	 MwX9sPU+jSS+GnfKgUtYPAUQOlvaeE5ARj5TSu0ZK2lgQ9CYtYsqQuRNtSrlSyFnUrvcK
	 k0C/5C/zG+oNiU5UXDLwyJ3N9tuilG7w+W0DgTmmuCVpI7kuvfqBDs6/Dp8w/i/qF6sUR
	 QperBQUtQ+PBO0vYlcEUyP2sYe3NzDEzE73a9xfioAVwWnwGblkli5ZBOc430474L6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176879;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=Ha8zkTWC2HAZsZH1ysWg6RQBM+8k4G0SyVqAcNU/Xl4=;
	b=rEsodgBqvuhelOE96NcxCSZr8fEkV6wgvNX93JbhxhtR7z6o7pqCOpzO+Qt1JJxbiFMo
	 RzuWfr+l6PcWGu1U5HJLdUk6wK7LFc7KrdVjwmbt6hyWoPQnNIWjzp1FazBaMfjsqrSo7
	 7F3E8Sc+dB4jFVy46NUJdiEa8Yds0hYFr7X0hosK7r+YnE/Wwb0QPUk3frMoiGv14Cy6f
	 231HWsziKGccVWwuO0L4C22Ot6o2C9EOKI3hvztQuR4yEuPuVuCZciWxWNBxBiMd5I0jR
	 ZPLZa6+sirMiIM0bCb/bKs8xKL7IbMiWIV+yxjbKJfBqbcsmyyvOjGeseuwNvOy+kag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JD+Ukgig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D3606A320;
	Fri, 20 Nov 2026 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JD+Ukgig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBEE1F000CA;
	Fri, 20 Nov 2026 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176879;
	bh=Ha8zkTWC2HAZsZH1ysWg6RQBM+8k4G0SyVqAcNU/Xl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=JD+Ukgig+peffsDwZRufMTiOxT8Pyuw1j/eYoX44Niwwwd1dptOqK6EHeozzaCNop
	 Y+qIcDp7iG0WqMtWdDaOxzyFLlYl4aaaf1H9TZERh29UjNRxiUO/PBVSzwxOfSuIy6
	 T+8lDuJ00W/VdYQKXaQV4PigLrD4CDrYUfW6TqSwnLLk2GW1lsj9K2szzu4SJMyRNn
	 BerF342oi2WRzwAx1KWASQ67Ukw6ee8Q45ynfxMJe1T/u83RpyZy8n0BpDFsz9+ST7
	 ISLBROzwDmhXumTFCboz29gfO2lhacX9cqAzV0t2LcM+x4QyEekEle0mtCFF5InA2O
	 K3Lza26VVdCEg==
Date: Fri, 20 Nov 2026 13:14:36 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/18] HID: logitech-hidpp: G920 force-feedback rework
 and driver cleanups
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
Message-ID: <n0029p80-479p-ssrr-rp33-ooo5r674n92o@xreary.bet>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 20 Nov 2026, Dmitry Torokhov wrote:

> Per Jiri Kosina's request, this 18-patch series for v7.5 is split out
> from v2 and applies on top of:
> [PATCH v3 00/14] HID: logitech-hidpp: G920 force-feedback and battery fixes
> 
> Note that v2 patch 22/33 ("HID: logitech-hidpp: shut down G920 force
> feedback on input unregister") has been dropped in favor of "Input:
> destroy force-feedback device on input unregistration" in input core.
> 
> The first group of patches improves transport handling and error
> propagation: keeping connect work disabled during probe until
> hid_connect() completes, preserving transport error codes in
> __hidpp_send_report(), and translating HID++ protocol errors into
> standard negative Linux error codes in hidpp_send_message_sync().
> 
> The G920 force-feedback rework moves capability discovery back into
> hidpp_probe() while device I/O is active (excluding generic USB PID
> force feedback for validated HID++ devices), separates device-level
> wheel settings from the input FF queue lifetime, moves the G920 range
> sysfs attribute to driver dev_groups using sysfs_emit(), executes range
> stores, effect uploads, and effect erases synchronously, indexes FF
> slot arrays directly by effect ID, and cleans up FF helpers.
> 
> The final patches modernize the driver by switching multi-byte protocol
> fields to unaligned accessors, storing device serials as byte arrays,
> using guard(mutex), __free(kfree), alloc_ordered_workqueue(),
> devm_mutex_init(), and devm_device_add_group(), and removing unused
> kfifo and wtp_data fields and redundant helpers.
> 
> Thanks.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Changes in v3:
> - Split out from v2 as a separate 18-patch series for v7.5 per Jiri
>   Kosina, applying on top of the v7.4 fixes series.
> - Dropped "HID: logitech-hidpp: shut down G920 force feedback on input
>   unregister" (v2 patch 22/33) in favor of "Input: destroy
>   force-feedback device on input unregistration" in input core.
> - Collected Tested-by tags from Gideon Heinz across all patches in this
>   series.
> - Link to v2: https://patch.msgid.link/20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com

Applied to hid.git#for-7.5/logitech.

Thanks,

-- 
Jiri Kosina
SUSE Labs

