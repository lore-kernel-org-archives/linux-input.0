Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969F428830;
	Tue, 16 Jun 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611671; cv=none; b=bSVJATbNQmlQBp2wYMgs4onPHddn2CZYWEvFN+pXYzIUkUp0T58Z54ditlX7rcHYzwYwBggXdpf/GqGfk2sy+u4r1YhK6zVs9TjMgWg/6lHdol9kgjaY8N4RMMBh+1oZ5X6++AO6ACsGI2TTQDp7JS2zoURMDtRZPGPnBBJysb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611671; c=relaxed/simple;
	bh=UgkZD5kS1JqoMgqIvsh7TflNMDKQ4d5XW74PGLNJhXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J84ZgMYuPaHcqnNxIp7DTUcmg5uY73xVKBGeze8GCdqrD+8cuAWMLSN/9tMTnlDn5jA1m2CQX8a6SMi4pXh9+KGJz6tIZ8UXA7TYOwr6NuDVRyixEskRnymtOP+8ppzOG5GIRUVL9IHtiUjSM8IZftU7EMa4E2Rvta9kOVl5rPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yULijEF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yULijEF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D14F1F000E9;
	Tue, 16 Jun 2026 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781611670;
	bh=ezCjXejK23S98EipR6sgVLpuTSe6tDQzoKB4iW9eung=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yULijEF8td2pb+6YWcftoQBG5EdmmUPWywwEowss+x+LrvmcmlE40SUI0YKr3A4I7
	 mbMQJLNTPy188wwuyxR7LHT1iSDJ94oNI34za25UQCnyX1BRYYZ/sQ2IfuGwll0snI
	 gaE0gyjeO8CnEzJrQHxGfrIt9tM+D3fFZrWdaa6U=
Date: Tue, 16 Jun 2026 17:20:00 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: core: Fix OOB read in hid_get_report for
 numbered reports
Message-ID: <2026061649-sphinx-ancient-e3c0@gregkh>
References: <20260616112700.1990813-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616112700.1990813-1-lee@kernel.org>

On Tue, Jun 16, 2026 at 11:26:56AM +0000, Lee Jones wrote:
> When a caller passes a size of 0 to hid_report_raw_event() for a
> numbered report, the function originally called hid_get_report() before
> performing any size validation.
> 
> Inside hid_get_report(), if the report is numbered (report_enum->numbered
> is true), it unconditionally dereferences data[0] to extract the report ID.
> With a size of 0, this results in an out-of-bounds read or kernel panic.
> 
> Fix this by moving the numbered report size validation check before the
> call to hid_get_report(), ensuring that size is at least 1 before
> dereferencing the data pointer.
> 
> Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
