Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FC46EF6A
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711497; cv=none; b=ZCvmYvTiKmCHmLRzgd8eNAqzTgds7FtVXmtfm+aZvoFSXgiKLuXWZYSbieN1Jx2lLy3AxvNgQjTjaLEY1wCLAbPQHD51w5vfUaszNiAFbijyqbzviCmA1iON+V8Y8RtQ0kKz37gUpr7cFfh32Vxb6ra96Xm8VI25zJyJSEH0pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711497; c=relaxed/simple;
	bh=exidD6dXMr08i2XuB4kGjdi05RAt5bD21P/ESu++o1I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MY/iXWb2q1fHyCvOmTv2J6yzl6dNmCs/6WHSG/GxRl6zgKvhwLb4TjKpQLxH//5l/Ae1rObPeIYOrbXNMNh46k43O2d+9V7svGewsDBjsott4uJdX1M5zoTGZ4ZQHhBqTG1s3sUYXOMQfQNIaQZbvZB5PPKpfo+k1nvvQI+cYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/wNXTSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/wNXTSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC20E1F00A3A;
	Fri, 14 Aug 2026 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711492;
	bh=VPh1GKv3KnKTRPCD3hMwrZCzzFWvo+hDSokU6v5kV8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=P/wNXTSegK5RjaO+PwKYNld1+KH8b5cDBp5B9GSTVajGheB/ZIVS1d+YlEdp+L9dW
	 r4tfpWHLMfdGVVKveIPfn43iulkoSZH3X+nIbSx4bsDIbidmadqq68tnk/yApT5C1W
	 WMKNSvqkS8kx59p4zYEw7tmrQiy7A8jNhZRJAvHbDPROxBYPBJGR0AtKuKbMaVN0nO
	 X9yV+PQNOaCUGQAlS2NFaVT5v7MqCFIp+RAQs3JZsWDO9VL7G5fQoD5/k+Wt8lLMhj
	 Je9Q3waGCerw8rBsh55TAcc7/Wrm2YQVkNYk3zK9th8RKBAF8+S8X4m0riJ5uuF11R
	 CvtdJYVIKZc1w==
Date: Fri, 14 Aug 2026 14:44:49 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc: bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add SW_TABLET_MODE support for AMD SFH
 convertibles
In-Reply-To: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
Message-ID: <502r8949-7o51-n405-s500-p0n6226r37nr@xreary.bet>
References: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Basavaraj Natikar wrote:

> Add SW_TABLET_MODE support for AMD convertibles whose operating mode
> (laptop or tablet) is reported by the Sensor Fusion Hub.
> 
> Patches 1 and 2 are preparation: the first tracks the MP2 version
> explicitly and the second serializes access to the shared emp2 pointer.
> The third adds a way to read the operating mode. The fourth registers an
> auxiliary device when the sensor is present, and the fifth is a small
> input driver that binds to it and reports the posture to userspace.
> Keeping the input handling in its own driver avoids pulling input/evdev
> into the sensor transport driver.
> 
> Changes in v3:
> - Destroy the tablet-mode auxiliary device before the hardware teardown
>   in .remove(), instead of from a devres action that runs afterwards,
>   closing a use-after-teardown window (Sashiko review).
> - Move the Makefile entry to its correct alphabetical position
>   (Dmitry Torokhov).
> 
> Changes in v2 (address the Sashiko review of v1):
> - Read the operating-mode register only on confirmed MP2 v2, by tracking
>   the MP2 version explicitly. On v1.0 that register overlaps the 64-bit
>   DMA address programmed through C2P, so the earlier unconditional read
>   could return DMA bits instead of the operating mode.
> - Serialize the shared emp2 pointer and all exported readers under a
>   mutex, so a concurrent unbind can no longer free the device while a
>   reader is still dereferencing it.
> - Publish emp2 only after initialization has populated the client data,
>   and clear it early on the MP2 v2 remove path instead of from a
>   prematurely registered devres action; this removes both the
>   publish-before-init data race and the unconditional global clear on a
>   probe failure.
> - Destroy the tablet-mode auxiliary device and release its id on removal,
>   and allocate the id dynamically so multiple instances cannot collide.
> - Report the initial tablet-mode state before registering the input
>   device, so userspace never observes a stale default posture.
> - Rename the error variable from 'rc' to 'error' to follow the
>   input-subsystem convention.
> 
> v2: https://lore.kernel.org/all/20260803145801.3801862-1-Basavaraj.Natikar@amd.com/
> v1: https://lore.kernel.org/all/20260721174422.3109166-1-Basavaraj.Natikar@amd.com/

Now queued in hid.git#for-7.3/amd-sfh, sorry for the delay. Myself and 
Benjamin have been on a few weeks on leave in parallel, and then didn't 
really help with the throughput ... still recovering :)

-- 
Jiri Kosina
SUSE Labs

