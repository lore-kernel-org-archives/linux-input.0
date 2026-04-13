Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4AD1DED63;
	Mon, 13 Apr 2026 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086140; cv=none; b=KcLMjGDGO2130RRvbRXNUs0BRjJik93EfJSI4MfAeTQMmVaGufH5D2iUqRTTZ9LPfP2GRpv4U05nhrzPuTU57B1Xdchlx+CtW1srO5uDbiLCUqLrOL442+5QEGZyCjIxZDR2rT1/DdtwWdGiMAUJO2bgl3gkdz++4bpG9SKDtdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086140; c=relaxed/simple;
	bh=/JR21NDTH95Y3c7Ag44ZDUuNUUUFUKPQ1K19da8Xq3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFnDTbrQQjVfrbwuPBFnRmXN7I50nbW/ZBHvXYEvE7lPIdsGlJ2/6xLLiWeLLjl9EQ2so/4vz+pvv0LRgF//sjmyGSGoPvI9YfiwJvMY3DdFCNiSo0iDro4wP1j1S0Ia068oLftIQtLWkYvUYuFcpY//APZrcXKPSxN3VwCGREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3GAplui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3GAplui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C682AC2BCAF;
	Mon, 13 Apr 2026 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776086140;
	bh=/JR21NDTH95Y3c7Ag44ZDUuNUUUFUKPQ1K19da8Xq3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3GApluipnwXL3popVRbBcOVQY08pv2nflC4fMCRuD6FX827ohQTW6momdhp+WOsm
	 9E+oJJ362NRUguArFhF9LwKH2FhcWYUYqSu91t7v56DezUDE8xBtMq7yzXS+r+ljrD
	 d09fHOf22Ciw3gKxysf26E+YEd81thHSxZjQCjv0ujTLt6lSx9AZXcfukiUU3hXshz
	 fKOa5p/BKEm19bG1LLmt6KJwlYDTLhWZ6h/tXzRLcSiyxRav5Jj5nhZTKgG7a39gWy
	 hlK9eY4s48knSeXO3BupDUfx3SElcmeRsVwj5C9RaGbxuGa/krN4Sm3u9bn3PtxQ25
	 wDRg8Sy/Kf2LQ==
Date: Mon, 13 Apr 2026 14:15:35 +0100
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: fix wrong detection of bad DJ_SHORT
 output report
Message-ID: <20260413131535.GA10076@google.com>
References: <20260410-fix-logitech-dj-v1-1-5533381f8d1b@kernel.org>
 <2qo95np2-n977-9r09-p016-880q98025q44@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2qo95np2-n977-9r09-p016-880q98025q44@xreary.bet>

On Fri, 10 Apr 2026, Jiri Kosina wrote:

> On Fri, 10 Apr 2026, Benjamin Tissoires wrote:
> 
> > commit b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT
> > related user initiated OOB write") assumed that all HID devices attached
> > to the logitech-dj driver was having an output report of DJ_SHORT.
> > 
> > However, on the receiver itself, we have 2 other HID device we attach
> > here: the mouse emulation and the keyboard emulation. For those devices
> > the value of rep is NULL and we are triggered a segfault here.
> > 
> > This is doubly required because logitech-dj also handles non DJ devices
> > that might not have the DJ collection.
> > 
> > Fixes: b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write")
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> Thanks a lot Benjamin, your CI be praised!

Thanks Benjamin.  I appreciate your work.

If it's not too late:

  Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
