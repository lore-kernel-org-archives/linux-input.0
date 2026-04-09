Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4307363C57;
	Thu,  9 Apr 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749073; cv=none; b=snNtO5XNSeuGZ4JdMhE+cN4bBgj9yHryG6mii+dXpVZWRp20PVVQ6gfwu4U4kl2Nbr8fSfCQQTKg5U5/DC1Q/oU7vhh9WPpMcUc1iuTwRlA+nGcnsmd2vNkOfVFzYD3Qh1pZpNWTg2zfROdWXXo3sIB0KC1NSpZGyw3lLPAMeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749073; c=relaxed/simple;
	bh=GwJLfya6YyydHUXQLitjkkc5F+r3bKlg0aeyyIpRDbc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BXA2RFftyetjTnWjVH3OrcgI6N5Xf3h94oOGh8ltpP6cb34mHu44TO44H9348rygra3j2RSTF8ASUerYONRswx9htP5cxFHD8sGidQ1C8kZp/gFC9iUCl8LU1ydf+JM3Dul5Dx+nscktpKQ8UWnYesrUc421r8j367BfwtMTIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZkSB82b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZkSB82b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75EC4CEF7;
	Thu,  9 Apr 2026 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749073;
	bh=GwJLfya6YyydHUXQLitjkkc5F+r3bKlg0aeyyIpRDbc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OZkSB82bzhUyUgkG6CAgyN2nYxRHSBh2LP6xmL/wZRXvdQ4r2e3ZkMFg3FBzXForq
	 ZHmoI+lahxZehBxxn76cr/M8cH87urGCn/qW5JLuARNu7Jknelh6xzetjs4L3YgaPb
	 IE7zNeNEeDYdJAlMdd/klDW2fseT6DIMlK/F+J4eeB6/YBuN7oHHjwnB3HL2P0vvLa
	 2Z/PN3crhchTPJxvYOmdXH0mqXLVqx5XD6C2sht3qKqoYQPlIrJPaU7OfKxiy7A+Ll
	 /07bWI0r3yDk/8K5Q4a2ecpa/ZSZg49hckdSaATv6I8iuf8UslZLfD+TH8MDUjBxA7
	 vViJbTB8Ed6gQ==
Date: Thu, 9 Apr 2026 17:37:50 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable <stable@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    Masaki Ota <masaki.ota@jp.alps.com>
Subject: Re: [PATCH] HID: alps: fix NULL pointer dereference in
 alps_raw_event()
In-Reply-To: <2026040624-overjoyed-impart-6fa4@gregkh>
Message-ID: <s244nnns-p3p4-6q1o-or9r-poqpr203023n@xreary.bet>
References: <2026040624-overjoyed-impart-6fa4@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Apr 2026, Greg Kroah-Hartman wrote:

> Commit ecfa6f34492c ("HID: Add HID_CLAIMED_INPUT guards in raw_event
> callbacks missing them") attempted to fix up the HID drivers that had
> missed the previous fix that was done in 2ff5baa9b527 ("HID: appleir:
> Fix potential NULL dereference at raw event handle"), but the alps
> driver was missed.
> 
> Fix this up by properly checking in the hid-alps driver that it had been
> claimed correctly before attempting to process the raw event.
> 
> Fixes: 73196ebe134d ("HID: alps: add support for Alps T4 Touchpad device")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Masaki Ota <masaki.ota@jp.alps.com>
> Cc: linux-input@vger.kernel.org
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

