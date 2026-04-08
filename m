Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D424B28;
	Wed,  8 Apr 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680344; cv=none; b=qhuemTOL6fwsT7aCvFNtnc2MhQ5Lw9AX/AB0Qvnh6BcTSYOaJAYQJso9v7lM0DiQlpanhOv4HCW+rR6PKE1fKEkOOvfNBGdRBXcPQZ3BUBEak/p+jZRYxik1USGFCXkEm+A5qHm43JPKCX2yyx2IXE9/gTv2Ejk4C/Fgw3OuuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680344; c=relaxed/simple;
	bh=r3hHBCUOwGIOtEylSCHKWExcA+8nxdQ3mEa2rg/YjYw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WfQQL+toALLcbWLRzAw51oxi8r4hzUBAVIRjtQETvZu5s0Fdfg4D2SeixHdsDpp/4U7dCnr0yd7VoCeCJJuucS3G+tkjwyCWNA/E/mNDj0AZ+I+ItVlIPzM1OfK7TwCsX0TlPH2iUuSDiUtLFBDkEjc8136A/9eH1FAv1wDZHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlK8Z1/a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlK8Z1/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE4C19421;
	Wed,  8 Apr 2026 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775680344;
	bh=r3hHBCUOwGIOtEylSCHKWExcA+8nxdQ3mEa2rg/YjYw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dlK8Z1/aItEKRtLTNavFeEbyKHkIxusRNDuax6cS7ZwarArWRF8RxixmOUy18C6/W
	 tx1cmW/niagVDcr97vcVi/4QuRTrzCEM0PekZjJxStfMD9N+ooSfR6oOQfvBYPwt5O
	 i08TwRuA9yyLzOOzJLcdu+xcSyFE/apsYgqXSP03KxpP9o2ASIbFfYUqjthU5ieoRD
	 yLiI8Itn+aKD4ezR9NpEZJ9fM6ZkoD+HAp08hMV919sW/C8ocmXBLrG/Btujs6Omyl
	 TJl8eVcrIr15m3eSln5/WtanOE9/GVZOLDZngW3YfbVJoOIA0z/Gc2eogdawL7O5zV
	 LfojNvjMTYbfA==
Date: Wed, 8 Apr 2026 22:32:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: hmtheboy154 <buingoc67@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: multitouch: Add support for Dell Pro Rugged 12
 Tablet RA02260
In-Reply-To: <20260403092848.10223-1-buingoc67@gmail.com>
Message-ID: <4op5533p-s086-55sr-oso5-30qsnqpq407n@xreary.bet>
References: <20260403092848.10223-1-buingoc67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Apr 2026, buingoc67@gmail.com wrote:

> From: hmtheboy154 <buingoc67@gmail.com>
> 
> This patch series adds multitouch and stylus support for the eGalax 
> I2C touchscreen found in the Dell Pro Rugged 12 Tablet RA02260.
> 
> hmtheboy154 (2):

Thanks a lot for the patches.

I know that the kernel documentation is now a little bit more liberal 
about not having to use real names, but "well established identities" 
being fine, but stil ... would you mind submitting this under some more 
comprehensible authorship? (anonymous submissions are still not allowed, 
BTW).

hmtheboy154 / buingoc67 doesn't really sound too well established identity 
to me, unfortunately :)

Thanks,

-- 
Jiri Kosina
SUSE Labs

