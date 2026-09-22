Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F528726E;
	Tue, 22 Sep 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059103; cv=none; b=UX+Y6EEzmubs59e4g+3hR+H3pETfnmB9O9Ee5vOdqMrOLJF+uc+TbumTZFYoNrPCsZ/UL0nw3qle2tDLkz+YhjzczvNmy7pTHIIfcLzMBY4jjY/2YF1CLQcVn/ZhHKc8uzO4DEffNhjHHT+NoSiH5cY3QAb4CcD4ttj2+1uJL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059103; c=relaxed/simple;
	bh=sZVF7j0fWD27O2xq5Al4ciYgjvCK7LkZU22wBm0vYhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiFqB9Cf3KsgY37yJ1Sbc8x0Ymv6E/W9mTWxpfeZ+ZJlikj/sVN/aTewnYcUcXvcz+yzWAFYNVba7/BlZ2GQW6BFy6S+CaAeKOtycyNIrvkw5Umg3g/XHFWo17ZNdvlCOir38Uhw6fU88JnuzXbXkegQGcH4l3jpI3nVTWhPT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIsmsMZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIsmsMZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09561F000FF;
	Tue, 22 Sep 2026 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059101;
	bh=Jx07mOh3/1/loGCchiFU5C7r+tS5wJT4GfywvSeAvNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jIsmsMZCnlK3ox3pmmHEAiUz7ryjXPv7r8SkLc2HC+mHSs1G6MP17hBRhprgEvfXY
	 AVrWk5VIsFKedQ9ydIPKy48jtiWXSUV1g+r+rNL7e3gDzZ8gc5YpP4a1CPESM35I9U
	 UoANshwIL7AbnrhP9HyJKnX/oGRLuzgIDy0sY2Sv9AtWh7hbV7F4DMAZgrmyiXq5u4
	 VMcdT74bRb24gPwrT3238gSoveOmTdcjEBrUKYu8hACYlVAVde3u7JQYtj71f5fLsO
	 kJ1QtDuqEtxn9UmLT8K1e2lVlcW6FTrn+4KoRcx+Hk12L1ufnoAT/xs9wjJOeHOotS
	 iP1vjAo4b/DOA==
Date: Tue, 22 Sep 2026 08:38:17 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: HID: intended semantics around report buffer length?
Message-ID: <arIhe-o0Pxcb1hXu@beelink>
References: <CAG48ez2N4jPTF7mqs28NHNNH+ev3xFqE+FJ2OgaehAw8L+w91w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2N4jPTF7mqs28NHNNH+ev3xFqE+FJ2OgaehAw8L+w91w@mail.gmail.com>


Hi Jarn,

On Sep 21 2026, Jann Horn wrote:
> Hi!
> 
> I've noticed that some HID drivers seem to assume that HID events come
> in buffers of at least HID_MIN_BUFFER_SIZE bytes for historical
> reasons. As a random example, elo_raw_event() can pass the supplied
> buffer to elo_process_data(), which can access data[1..7] without
> checking the size parameter.
> 
> However, HID-BPF exposes the kfuncs hid_bpf_input_report() and
> hid_bpf_try_input_report() which appear to allow BPF code to pass any
> buffer with size >=1 into this codepath.
> 
> What is the intended API contract for buffers passed into
> hid_driver::raw_event? Are HID drivers allowed to assume that these
> buffers are always >=HID_MIN_BUFFER_SIZE bytes (in which case I think
> HID-BPF probably has a bug), or are all HID drivers without explicit
> size checks buggy?

I think it's safer to not assume anything regarding the size.

I just double checked hid-elo.c and it does call in its probe
`hid_is_usb(hdev)` so we guarantee that the transport layer is indeed
usbhid, and so we know that .raw_event() will be called with
HID_MIN_BUFFER_SIZE at least.

The thing is uhid is not guaranteeing HID_MIN_BUFFER_SIZE, and it has
been around for a while, so no, we can't assume size is at least
HID_MIN_BUFFER_SIZE, unless in conjonctions with some conditions on the
driver.

Cheers,
Benjamin
