Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5923D7D69;
	Wed,  8 Apr 2026 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680504; cv=none; b=qp9Fh3gLFPnms9rJ7v5xSxjJne+7MVtaalx0aqE8qol3vEX8ZlDMRFsuXZ4WlbCFUhg128OBntfa965gg6Pzpuh8PaxyKSdavQ/CA5UYt1MY/gpDah0XiP4sBxOR+65Il7yBluMJaaoXYf1LxzaTYoaKfEcVMAyRPTcJPncD4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680504; c=relaxed/simple;
	bh=tZmoWFvEG21eqvPBhtrYFXmLmS6tUcQDcwUYSJjTpVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=orddz6gct+amyC09eTtgwRvSxeizZllkm3+ndzSMuxzTYpO+gwHeUpqWcvUILYcr4C/NXDEHdUDOZld9qfApUrJi+4wbOiC6L9Uyz6nvWeHnbJ3ZSTQG5zdaMXGKgIAEOQU0oB5tErR9cDoiC9t+JO1URjL2fPPGIkSyYBZEY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwLi7ey6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwLi7ey6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE94C19421;
	Wed,  8 Apr 2026 20:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775680504;
	bh=tZmoWFvEG21eqvPBhtrYFXmLmS6tUcQDcwUYSJjTpVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DwLi7ey6GTEj0w1snVnKTOHCVY/1pK4subVmZ6GwSE+HaZPCxs8LZiayHj/VPdYPd
	 PYke8pNN2z8ddenzoKAu00KcvEbb1LIzQqMOhC7SoP5JvfKVWmABuqxFH4caqsaN+e
	 5AhHeAmYANhLtBi46jK0RpghriT52yNneQcHfBivox22YTUtrSW9qNyHVgnJuXEEmp
	 gTNUI1oCAML3JSGmZr+9Tjw9HKPzX7N4VqZatuC2W5Mpqrw+3TLYNYf15Xv2KjiFQm
	 hbY1D5VPZvcMgfy+pGw34XIppfdtB951aVv4RbGx8Ebls0nNa0KhFyjv85xweWv/Hc
	 Dbkw4aAjjHqOA==
Date: Wed, 8 Apr 2026 22:35:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sony: add battery status support for Rock Band
 4 PS5 guitars
In-Reply-To: <20260307094824.50332-2-rosalie@mailbox.org>
Message-ID: <o830so4o-q3np-9639-so2p-649rss80p728@xreary.bet>
References: <20260307094824.50332-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 7 Mar 2026, Rosalie Wanders wrote:

> This commit adds battery status support for Rock Band 4 PS5 guitars.
> 
> The data is reported in the same way as the dualsense in hid-playstation
> except it's located at byte 30.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Applied to hid.git#for-7.1/sony, thanks.

-- 
Jiri Kosina
SUSE Labs

