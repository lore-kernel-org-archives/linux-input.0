Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87886257849;
	Wed, 27 May 2026 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869404; cv=none; b=SCLF+Bm0dQv97z4I6inmTCb+vR9bJ+SYtlfxrLhhlMXw6oVog5VdOqfqm4cziIc+KiTuN19aXHmmITZtlk4cMulBHBJgceKTrtHm+jtKKcBH7YbsL68Cs4gZ1Rv6Zctec4mgnKwe0XVfQxgDv2RtvlwIIDvgkd+IzXU+i1DRyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869404; c=relaxed/simple;
	bh=mzZhlYK5V3epmeuj0qdin3X0Oss1tjKS/Doc4gRczVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y59mpCwE4z/7gLNJ5+tDE9iKyUyd96DEpnNDr1V8C/XRs4l3ABuFpbaMXczJw/Qmkf6QRsUHhwx07G/mr0rnms1GWRz8UWM2wOqBt8yF5JGIZbnvbrwTwGsD1yfk7AgxXe9Q2eEGXiTqt+wdp6KNWgQpvV5673f18FeU029kY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HFbmxezg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFbmxezg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C71F000E9;
	Wed, 27 May 2026 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869403;
	bh=gP1gZ2RX3W6OU6p1T9HreG9wGrQrfFlu/KPXRjnUMIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HFbmxezgIFD2amdXhyfBjaAADz7dJDWTcmtfudcwtseSX+n8LywWseXdDoP9tI4M5
	 UbhduRoebWCyIcw9aNXLxnLABUqCKm65Bejblj9EzSsTQFRcUzkBd+YBgdU9KNVjyy
	 jd5ZKuDx3lbySPf6vH0hOdNVj02Ii5GrxyzGbbdU=
Date: Wed, 27 May 2026 10:09:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sin99xx <sinxx198@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, jikos@kernel.org,
	bentiss@kernel.org, roderick.colenbrander@sony.com,
	tjmercier@google.com, bsevens@google.com,
	linux-input@vger.kernel.org
Subject: Re: [stable backport request] linux-6.19.y: cac61b58a3b6 ("HID:
 playstation: Clamp num_touch_reports")
Message-ID: <2026052716-proactive-copy-d9d9@gregkh>
References: <CAMX0No2KAENnb=w-0R_8vGsnW+Ux0B+LMZKHt44YPJNjxJeP7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMX0No2KAENnb=w-0R_8vGsnW+Ux0B+LMZKHt44YPJNjxJeP7w@mail.gmail.com>

On Tue, May 26, 2026 at 01:30:51PM -0400, sin99xx wrote:
> Hi stable team,
> 
> linux-6.19.y is still missing the backport of
> 
>     cac61b58a3b6 "HID: playstation: Clamp num_touch_reports"
>                   (T.J. Mercier, 2026-05-12, Cc: stable@vger.kernel.org)
> 
> and its precursor
> 
>     82a4fc463309 "HID: playstation: validate num_touch_reports in
>                   DualShock 4 reports"
>                   (Benoît Sevens, 2026-04-09)
> 
> Both are present in mainline, linux-6.6.y and linux-6.12.y. As of
> v6.19.14 (released 2026-04-22), linux-6.19.y still carries the
> unclamped loop. Function-level disassembly of hid-playstation.ko on a
> 6.19.14 build confirms neither patch is applied:

6.19.y is long end-of-life, which is perhaps why it's not in that tree :)

Always check the front page of kernel.org for the list of kernels that
are still being supported.

thanks,

greg k-h
