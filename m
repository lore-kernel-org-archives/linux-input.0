Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE13E3151;
	Fri, 16 Oct 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144035; cv=none; b=nSjQCfuAh2srVkM7+K1TTEzOopSB3GlxJEOVJszAmQj38hV/zLi+0uB7zexfPhNGdO6N6daGnTzi38jcASN6enn1nFqWnzlph4UIAl0drJaP9MMhtizor9pUH97UBUqPhwOyBCphpS5mpWN14eTPJb7XN/a7cEqnEGxcw1nBeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144035; c=relaxed/simple;
	bh=ZOYydDlmEgzriDQWPacHOTU/xDuRElhEUVV23N2F6eA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tNWd1+EyIpxI5sldLgqpm70LFahzN+SjmbcUoh1SH8FtABu2zdqP8Bw8gbKEhqFaZ1ndDtLtFgWvT6yDuh0/v/p3E/w/XqAfELJgW33uHONM6gcQgBNCIyoTZbk7hqhIGfoajvH2lBs+hrY/Z94na4m0ye9NMZWPMRhRrUnMnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6sAAOFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6sAAOFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A01F000C5;
	Fri, 16 Oct 2026 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144034;
	bh=NPbmmExBaAac8C63fvfQqxtmvebEOFFyFE4QwQXHOog=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=J6sAAOFirKTiuXvu2u+yEwIPTA6HI4OzYmwg6p3vJsph3T8n8LVqnG8TtrPZeCCfh
	 frDp4ZPZYoAd2Idncla7BPuXicOSJfdVj3n397mJ8bubV6znhtFeUHqMi6Hb84/a62
	 KYO0GfpfZoCwdSRxl3wEV8X2kebaqklWSffQdlNLyD8YTXaKRkJrMRkyu+HFH30MJ0
	 /S9pRMmMP0RsksJfghxEEH7nkhhVPzC77lG0+q6SUJ0GezBwOp8r+9F400DnbzDclK
	 Wgu/3InZSeo0bZILZPgDil06BNFgjIgSc3wiMBQ5xQJ4A1GX8lCPV7nbXzPvf099MB
	 +nmXgcrdYlaNQ==
Date: Fri, 16 Oct 2026 11:47:11 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Aditya Garg <aditya.garg@linux.dev>, linux-kernel@vger.kernel.org, 
    syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: magicmouse: fix null pointer dereference in
 magicmouse_event()
In-Reply-To: <20261003072959.388811-1-nehuenlian.kernel@gmail.com>
Message-ID: <q564sq6p-r544-96n2-4q8p-n11p35p30959@xreary.bet>
References: <20261003011820.1295672-1-nehuenlian.kernel@gmail.com> <20261003072959.388811-1-nehuenlian.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Oct 2026, Nehuen Lian Bova wrote:

> Add a guard clause to check if 'msc' and 'msc->input' is NULL
> before attempting to access its fields, preventing a general
> protection fault.
> 
> Fixes: b8d56ef91cc3 ("HID: magicmouse: Apple Magic Mouse 2 USB-C support")
> Reported-by: syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5ad4fc9c8360b68e353f
> Signed-off-by: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

