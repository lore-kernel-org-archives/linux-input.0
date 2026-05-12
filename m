Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136B27E1A1;
	Tue, 12 May 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602203; cv=none; b=WLVEm+9W3MEnVX+IkIjHca4BmkmfMaie/BI1fwuDzfLh6ZAm07rxkA6/M2kOKe2biMz+hWageqq768x6cdA3IaxftE12qvcen8e3g0pHhwSVdXy+Dr81KQxEdgi/0FNZmamG2Ujn0nKkCcmcaCbnqiB3GZYOU2XosgciOcl+gzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602203; c=relaxed/simple;
	bh=YluAjRFwmtGZThKS1YGUEmIUZ5eCiHWm3Y+KM5faHo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dfnW5vDeax9MYyF25O1qZjEejUR9969kFkWG0L0d9Bm9Z337srJifpYkWq7wGpPNHxqWQZU6y1LnfD0No9qsSybv0+/NA6VccT806uOfu5QfxbxhImHaKPg/Bl1gB2HHVr/UmWU0uC2YA0xXAFbqhw75HjUK4j/GdrosCwUEWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFImzR8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFImzR8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9DFC2BCB0;
	Tue, 12 May 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602202;
	bh=YluAjRFwmtGZThKS1YGUEmIUZ5eCiHWm3Y+KM5faHo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LFImzR8fRq2NU+DMjgQyzjM/Iuez2bV5TYCnI4hxNKrMzNm2gm77K7aYpJ1+JOo+D
	 gJv0SWd9wiPSQIEaxjZuHQrji0zoVvKNyphbupJWx4f+qH6jF0YHXuhU8OS+3RAayv
	 /oIbScLQ88h4tx+5x/XGT98WKxwJoMO5RhLZFLjgTKTvul8Ds1lrw1OEvi/SSDxcbb
	 Kgy2CvTfmYCfsaZFNrZDMI75qDWn+XE+mQEIIcOoQ276XOuF9DdpINZD+sp7BaOFKY
	 MnsXojiI7ICupxoPvIpCZF267Bbw4hMb10tGy6O5R3ZTaf/vVQ4LTnl+EkaEnkZ1AN
	 i0SC0AlAwisNw==
Date: Tue, 12 May 2026 18:10:00 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: marcus.folkesson@gmail.com, benjamin.tissoires@redhat.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: pxrc: fix slab-out-of-bounds read/write in
 pxrc_raw_event()
In-Reply-To: <20260508133311.3995013-1-jinmo44.yang@gmail.com>
Message-ID: <888704q0-o278-n257-2p94-04qp3sqp61s8@xreary.bet>
References: <20260508133311.3995013-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 May 2026, Jinmo Yang wrote:

> pxrc_raw_event() accesses data[7] without verifying that the buffer is
> large enough. A device that sends a report shorter than 8 bytes causes
> an out-of-bounds read (priv->dial = data[7]) and an out-of-bounds write
> (data[7] = priv->dial) on the report buffer, corrupting adjacent slab
> memory.
> 
> This can be triggered from userspace via /dev/uhid by creating a virtual
> device with VID 0x1781 / PID 0x0898 and sending a short UHID_INPUT2
> report.
> 
> Add a size check at the top of pxrc_raw_event() to bail out when the
> report buffer is shorter than 8 bytes.
> 
> Fixes: a2dccedac664 ("HID: pxrc: new driver for PhoenixRC Flight Controller Adapter")

Where is this tag coming from?

No such hash exists in Linus' tree, and the commit that actually added the 
driver has a different shortlog.
Is this some LLM halucination?

-- 
Jiri Kosina
SUSE Labs

