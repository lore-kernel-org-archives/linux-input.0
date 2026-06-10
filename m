Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA583FA5E7
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106877; cv=none; b=DNB/cWCRfF6hzLzBx1Lna6R1DO9/F2dSLRaVF9cs3krdBGIkHjYXIJ+IOdsXqiby2tsWRb/JpNmCIcYJdB65IKzjiw6jhB1MOcNosXKHZwX5q0h4v8RRYaiJ886XykPL0FABntsbA9GTR9jvjtYYIjyCJuyqwHWCwf+QU+2dqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106877; c=relaxed/simple;
	bh=Szzdt0V6tYBdssraGngx5cY+CT97bry7m7yuM5cWdg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IXps/kf5kyKLlqE/tOl1l71Na7j7pXPRaDc0Vm+XS6rUtuAF2/dhz/vZmaN0J63wtLXTV7DjKvsKLuYMQ0QD7FTXNeQ48kuhiO2J07OvleaYX7rvGOOwXvJNPWuhwWc+ZoKK6lZUIBUqlgBUGzTmENCSG0B0zcpfhMxNa+R2nDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbiVTEDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbiVTEDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF3D1F00893;
	Wed, 10 Jun 2026 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106876;
	bh=mjTPMs+2ceuAuvrglao0rH9J0BoShH6GTu7vq3hPjwo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YbiVTEDLDv8RNaezn3QlNenLpvJsiBHPkWHd/kyJy0ci0upt60Pn2fDMnhEflz0bA
	 gVXVudglgJY6pQNOg1rH6bmXcUWAn/6FCb56FXebHJz86ayg8fTEx+l/GbzcUeTCrI
	 dtKoh0cbqOybvLBag1/V39aofxbjw3a6V4vLAC4XdvjNnPQ3dbLNwOSJjnFXAgvgW/
	 BgH7Jb642XJc+w4HKRfytPVw25SKdjD6h/J8ccycTUfRQa1CZjHVv56gUcb3nI/AeC
	 OWqT5QBY9uitPjDLwEGGcphUjYyOSbWjZltllPZAyLZr4Mwqy7QmBcHf76c64r9PuY
	 mezL218X3EjJQ==
Date: Wed, 10 Jun 2026 17:54:30 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Paolo Pisati <p.pisati@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/7] ASUS Zenbook Duo keyboard support
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
Message-ID: <5sn10614-2s0s-7r22-s9p9-5np4921p047n@xreary.bet>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 May 2026, Paolo Pisati wrote:

> Add support for the ASUS Zenbook Duo line of usb/BT wireless convertible keyboards.
> 
> This patchset is a collective effort, gathered here:
> 
> https://github.com/NeroReflex/asusctl/issues/25

Applied to hid.git#for-7.2/asus, thanks.

-- 
Jiri Kosina
SUSE Labs

