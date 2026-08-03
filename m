Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2692F619D;
	Mon,  3 Aug 2026 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784611; cv=none; b=PMj/urdicEEbHr/N4D5FW9ZI5FIHUu2/lBk/zT+CvKyFS+MJMqA2RT2YVsImAENNlJUE7A6TBaoI1/KsF5SVwXUFV9/4ze/miWccMch6IQcVCtVWOGC8x4cE6L+A7goPu7oPHm1bzYtFh79otUu+Wgp1NFF/AG6TNrTfhUHF+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784611; c=relaxed/simple;
	bh=PGN6fbBo3gNctob0Vf48teGEupmUTVVVnJ6cXyLhWTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FwNlSwF/Dcu2qPh5vFkthEp9ow/ELz7Qi0Gmt2wlEmLYwSYdcjXMbzm0knh/sC4uuPznHvivWCdEu8RYvpppJrnT0Sa3visA0snm7gqJtutqjJcCLcntionEILMnEHlSN7cQcT3/WuaO4p1dBm5S5lUbHqN8Ak6hcJmTyU8ODDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idhkYGBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idhkYGBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639081F000E9;
	Mon,  3 Aug 2026 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784610;
	bh=kcNUGaIdA18hXPawdsrfDwuJcyyHM9GCR9Fmh/Bh6ZY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=idhkYGBHEAYtyF9ZB/KH8d0lW2JYAXdJznpjt6JwqC07qGNedAV9viNJcHGg6AWV9
	 MY4o7Mf8rQ62coOYfPv9xvrrdMPm/baOY7dHWMPjTYGqG/PE+hPuSQrv2txhNytSsy
	 JuwIbSX4tZg/Wx/YnD2BL6avi7Ljy79ps+hJlA4A395+/5anMm6XoB+/q2gbA/+/bI
	 grfyHnJcXF4TENnb7oohStOevNkkdgZv1+irMnjRwm2ez/7aLdEs3s1E+YF10Ea4ui
	 UGIWW50vnfEaqgzQmY3mW+F4KiibTSFK5VUSv2+84kGeNoMqjtW2nJd25jNSehvNzh
	 mSrR9XTbF/vxw==
Date: Mon, 3 Aug 2026 21:16:46 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aaron Ma <mapengyu@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Add ALWAYS_POLL quirk for Beitong BTP-KP20D
 dongle
In-Reply-To: <20260803053932.5897-1-mapengyu@gmail.com>
Message-ID: <ns599ro9-2847-q698-82n4-os14q95q37ss@xreary.bet>
References: <20260803053932.5897-1-mapengyu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Aaron Ma wrote:

> The BTP-KP20D dongle in Direct/HID mode (20dd:5159) re-enumerates every
> few seconds because usbhid never submits its interrupt-IN URB: no HID
> driver binds to the vendor-specific report descriptor, so the device is
> never opened, and the firmware treats the idle endpoint as a lost link.
> 
> Add HID_QUIRK_ALWAYS_POLL to keep the interrupt-IN URB submitted from
> probe time.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

