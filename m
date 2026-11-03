Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691925;
	b=fk5Sqq5zmXen3xHLgHgf5z9Anqh6/TzC1YREN3lZiQUYaHTSezFSIf6AsCr2D3VdzcCj
	 J1ZA5lpAL5FHcktdvDJ275yKQNAmkYySgC8zydf6BPA1zm2Bs5Ar00iPVvRIDETLrj0D0
	 48rXViNw9vdwHKZxpSQZW5zoQBBTZtc8PMqfOlTVPUGS9z2ePlUCkabs62VeZgk4prkjI
	 fQu8cqNbiUvet2Pfctx9chBoXXAEPtQCXIoBSe5FjEcHjfQU2Ms1/LApaST59PgV65MxM
	 OnF0zCOsvKBFp69ac8kj5W2Pr8P8J2bWNqde8cYOcsELvvT8GQgfro4thXAqm2sTviw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691925;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=R3lCFY/iPDgq9qRZrX8FpWfJn4XT1JIuiVLYHFf8MCU=;
	b=AwB4dK5olMHUXkW0s8UJhsya2kClpaYH508cIwM/nNpJTCVhtC8V1/n0UukHD2hpEL0P
	 z0u/A0WeBhM+tYM2RUatekz3zDYLXYGWXn+yppH138PEzvCKeDldtawpcCccdKh1NVypk
	 Ci2/FQ39ILI4idvfZSQpdvGRSx1lcIuyH77C3rhVipnVGJP8LkH0GUsYYvLdQkKyKGv5A
	 1OzWBTqvWPtJNh6xs8e/2lj4p4oqt9qEZeXBVPINXa4HdIIHrjfOd0p/CacJtowwv4Q5K
	 zWmmfZ9N5rz4TKSumnXFPKi8vXOkrCIgzSDXAAhUIQyMNyXP+o4ydO3uUnsz7+L4DFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EK6wzxH8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074E606A329;
	Tue,  3 Nov 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EK6wzxH8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB71F000C1;
	Tue,  3 Nov 2026 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793691924;
	bh=R3lCFY/iPDgq9qRZrX8FpWfJn4XT1JIuiVLYHFf8MCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EK6wzxH8W0nn9XhVdMzuFfCLYlNzRXNl0sF6/lLjjvFku1wYeRCWHH13soaKxpoBv
	 QQ6dsEv1Gvi4nKyGYQGTncreWEYDaTRPg1uMStLGhTpVfCUdcfj2C9toqmj1dMh5Z3
	 h5zsOmKdOMD+eHxl/TR5s+lNgRyqVDX3Go6c934tcHq3QaxV7FqgsePvF2w0w28u3R
	 HdokyHeDHZkbXk0PvZ+ZYF9i5esRSzCYVn6MNF82Zqj8xuvIYuoL0riAVIacBUMrG4
	 PHZkPKlvPQabbs9xWbJoH4toRR4E9ahm/lEyqBXfs+k8oZBKRcyH+PndG1q/Hu9CP0
	 KOw9Vn98KR8nQ==
Date: Tue, 3 Nov 2026 08:45:19 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	simeon@maryasin.name
Subject: Re: [PATCH] HID: sensor-custom: Synchronize misc-device teardown
 with file lifetime
Message-ID: <e3qod6tmwqgabf7wixmwtmcz36fgk22zxstdwjzeimngz36hrk@7ma27oycfeur>
References: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>

On 2026-11-02 17:57, Srinivas Pandruvada wrote:
> The HID sensor custom misc device frees its per-sensor state in
> remove() while userspace may still hold an open file descriptor. A
> reader blocked in read() can remain queued on sensor_inst->wait after the
> object has been freed, and a later wakeup races with teardown and
> touches stale memory.
> 
> Synchronize the misc-device teardown with file lifetime before freeing
> the per-sensor state. Set a removal flag, reject new opens, wake
> blocked waiters, and wait for the last open file to close before
> deregistering the misc device and freeing the FIFO. Fail in-flight read()
> and poll() operations cleanly once removal is in progress so userspace
> cannot access freed memory after the device disappears.
> 
> This avoids use-after-free on read(), poll(), release(), and open()
> after the HID sensor custom character device has been removed
> 
> Reported-by: Семён Марьясин <simeon@maryasin.name>

Closes tag?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

-- 
Kind regards,
Joshua Crofts
