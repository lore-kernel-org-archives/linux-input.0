Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25C1DF261;
	Sun,  5 Apr 2026 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775367135; cv=none; b=ioUdI+KUaFXzBE3JuMVHVOOk83ppx1jYAa1zKBaxp0f7GQKvfTgNv6p0PG44Rrovk0wjFVcKhUnKDCfipO+uVz1dq1CquIBYWAUXvJNkGa1aKQFcdcTgvrVFp8OMOlIFivVMj75P2ZIDPO+EaphoX694Or8CUm+QUqEEs5nwRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775367135; c=relaxed/simple;
	bh=sUcXV+c9lPHYvC8fJurLOlmJVB+tkhccLJgOuwt7JDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj84+MD8FyznJX6oYL2lfpPU3wvsScP0gVAi+pWYl+b7Gk44xmTXLbQnY10fOhTKcM/5zjYr2WIelnTb8nl4V1tRHwiPZTBxtI+RUTDzcTdshEvYh26mv2SPlOejJNX8aduYP5KIPOC1L/ul4NgPZhhTgNwzDCB2ePaCGkieQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0IayXY1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0IayXY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18683C116C6;
	Sun,  5 Apr 2026 05:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775367135;
	bh=sUcXV+c9lPHYvC8fJurLOlmJVB+tkhccLJgOuwt7JDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0IayXY1yy42N4NwPMjsdLvEbhq5fkwFaIEC2ELjNh93gBAvR24qNVlLwlE4X9DO9
	 GZ93wiiUyIEnbWxKI5Ao4RRh2VcQR2LdVqzsh9SshxYJX0rCjKlHxefFAHpkObgNpc
	 qAy4hD1c2rCmIOagKPC3Wocnu6oLBaRtMKX/LGbw=
Date: Sun, 5 Apr 2026 07:31:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zubeyr Almaho <zybo1000@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH v2 0/1] HID: add malicious HID device detection driver
Message-ID: <2026040503-secular-fiddle-96e9@gregkh>
References: <20260404133746.80914-1-zybo1000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404133746.80914-1-zybo1000@gmail.com>

On Sat, Apr 04, 2026 at 04:37:44PM +0300, Zubeyr Almaho wrote:
> Hi Jiri, Benjamin,
> 
> This series introduces hid-omg-detect, a passive HID monitor that scores
> potentially malicious keyboard-like USB devices (BadUSB / O.MG style)
> using:
> 
> - keystroke timing entropy,
> - plug-and-type latency,
> - USB descriptor fingerprinting.
> 
> When the configurable threshold is crossed, the module emits a warning
> with a userspace mitigation hint (usbguard).
> 
> The driver does not block, delay, or modify HID input events.

That's cute, but no need to get security@kernel.org involved as this is
a new feature, not a bug triage.

Also, why not just do this as an ebpf program instead as you have full
access to the hid data stream there?

thanks,

greg k-h
