Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502430D3F8;
	Mon,  3 Aug 2026 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784878; cv=none; b=lW2r7DhI7l303v0uL48TpOGXB7gfG8LiLXZREhQ6nCc2zyBJ4+iKXogPPL3PtIeKUe8gvXj2Lh2jD82q0BpqDqS4OMh5b23lG9Ahw5/2b11rlC3rvkIQgcCMJtqhsvECzz/Gx7dfXZgia68hyvglDyaOdQSDiBWYFo6yj1E6WGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784878; c=relaxed/simple;
	bh=lOj92zjaT7p139pw0y8u1nmZfLbr6UphYocCuvHnbjU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gRPhmrUc1nnGWD4ut5lkzL5+yNff8BkGfN4kgFeSYy/wH3liGjjObK2cgaYVgDDMzcxos458lk3hhuniNee2q39dQhEoaanO31QUeNInRoN/A1axCvL9vgofjpQgWc6HlGAz3lwVr0n61zZWntimIudx2YwuvV++PlC94FQp5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8M7Zr0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8M7Zr0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B99D1F000E9;
	Mon,  3 Aug 2026 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784876;
	bh=SMCbLNqgqTREL67SR3/tZwKOtQ4V+RBAi0wvZMwcZsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Y8M7Zr0oT8tyFVB6nUQ5Rs5Gf1F2ydyhDTN8l6QVMN6Ez4T/s7f6rLoBsIrxREjSn
	 hjgBTfkezI7M+apJ4A7RwiR6FiKNxiefJ6rfTRHvkfjcVnHdYLUV4iURao59a55ixQ
	 seCUV2PSn28Ix9gIajvf0mpYaLkWM7pMk+40jF1aeaKQHVV1SnF4uNtkovzL1PaMWS
	 hNEP0zHHllfcGuZlKAYcvvj4jE5HN0R+nlVLHhuCcprO75D87yzXPYNxsgyxkOm/SM
	 hIjeHsj6qTucafz/hl83mfyQCDKPAIIn4bRmZm2uTQh0H0qjK0puV5g0xBOX/pUlqZ
	 h6kYT9mr+3dJw==
Date: Mon, 3 Aug 2026 21:21:14 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Yuxiang Lin <mclyxfdw@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: add ALWAYS_POLL quirk for AULA Mini 60 HE
 Pro Dongle
In-Reply-To: <20260722175602.22773-1-mclyxfdw@gmail.com>
Message-ID: <r4r3rs22-3qr9-4022-6r3p-90r5r32pq8qq@xreary.bet>
References: <20260722175602.22773-1-mclyxfdw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Jul 2026, Yuxiang Lin wrote:

> The AULA Mini 60 HE Pro wireless keyboard dongle (USB ID
> 0c45:fefe) becomes unresponsive after roughly one minute of idle.
> No error appears in dmesg; the only recovery is physically
> replugging the dongle.
> 
> This has been reproduced across kernels 6.8, 6.14 and 7.1.3.
> 
> Testing shows HID_QUIRK_ALWAYS_POLL alone resolves the issue,
> verified via usbhid.quirks=0x0c45:0xfefe:0x400.
> 
> Signed-off-by: Yuxiang Lin <mclyxfdw@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

