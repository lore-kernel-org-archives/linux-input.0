Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952B364E8B;
	Thu,  9 Apr 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750429; cv=none; b=pVzAG0PIKBOf8O91eEebZLre8aYMoGnLHNaeCUc/JNr/+6y20IVmEKXqn45pb/wIxoc3pGgaEV7/O27OzntEXthUxBQLnVDWgqnLysEZXLBWw/up3/jqunrGg9Wb0yJHWL78a2fWrHc/KnQ9TXAZ1kacB7GD11yjPH0e0lZLJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750429; c=relaxed/simple;
	bh=XClp+LjL8QErC1rBNtYTq2teTqspWq+kIHsvqvRndWE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SVgUhUpoeXyC3oKaIb3wCw6s0LFGb0j8HreFdfH02jgPLNYj9lF8AXzTVFlH0Sjji1TGnyiyohELaZANbHhW4UWm4lebfyPt34JGZDAa2eLYu/bANL6ejt+DYtrnPzMyr4mqAGWTkt2RXyTVgWUlHvaeop0wmNWxvgZLf+hd8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEMyOnac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEMyOnac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877FCC4CEF7;
	Thu,  9 Apr 2026 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750428;
	bh=XClp+LjL8QErC1rBNtYTq2teTqspWq+kIHsvqvRndWE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iEMyOnacDKdT7fDpcYe9HOEo9rGq9prZBvHDtIOJtgXTr5ajoawMJ3djDxYYEdBoH
	 NQqv+VUJ86dWS3hFi/2zsXHl3faXafS9hwM7au8GA/nEj5Q1CcNFCBCKZiGj/nb05m
	 d+jdAqIxIg8+r20+jFuEh4hLGMisBrYpcVJDUXN4VmzyGIS1oEePA/QA96OLOxcvYn
	 R/1jTBmGJSFjeUwTjd+gwhGPbkCSbu8p8ftexPAJI/0Lk6ToVjoP8PyxsP3vlB/Kxk
	 KUyaUVOgyhIF+n7m5GNSNofaye4W8AaF/JDfVkB6K3voGLuwbDvFuGtLJLAOlRY+A2
	 ob9Gkzxl6pq8Q==
Date: Thu, 9 Apr 2026 18:00:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Peter Hutterer <peter.hutterer@who-t.net>, Kees Cook <kees@kernel.org>, 
    Alan Stern <stern@rowland.harvard.edu>, 
    Charles Keepax <ckeepax@opensource.cirrus.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: core: do not allow parsing 0-sized reports
In-Reply-To: <acy1QWcu-yfd_kAu@google.com>
Message-ID: <3r0pp7nq-rqo1-p07p-4166-2o2qo1717n30@xreary.bet>
References: <acy1QWcu-yfd_kAu@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 31 Mar 2026, Dmitry Torokhov wrote:

> Commit d7db259bd6df ("HID: core: factor out hid_parse_collections()")
> reworked collection parsing code and inadvertently allowed returning
> "success" when parsing 0-sized reports where old code returned -EINVAL.

Ah, good catch, I've missed that.

Applied on top, thanks.

-- 
Jiri Kosina
SUSE Labs

