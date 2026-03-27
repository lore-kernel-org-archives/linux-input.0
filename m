Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B83F8805;
	Fri, 27 Mar 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623118; cv=none; b=G0Q2BEBpFK+ubkbfoVgpw2OJE42upvC7RyIQRNOzLa73j9xxCUoRArfEoBGr5qpei+4SiBcbnIXeFGtq2PEvI5ITa1OoXjmcevd0K/TjC176gFydgdKd3FDEUSyxM8/LfWuCcskIrl0UIadKVXmxEr3wLY3pVXWnf5LGJG3AIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623118; c=relaxed/simple;
	bh=XFzY/xO9T8daCV2KtgPbzyO+PQ8RRwWl/SXy033c8pY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OzwFhZNTstdW3u52TxWaiThEEaoxuJkCnGoj9SflBwPignMSb5IdlCy2zukNnkg+9G3HeSdb8ST8WBDIUGZxXEVbBHo5o0rJiSEKP3wCX0n2pLYV0icPy/IsnnQptiIBa9ZqXLh9M7nB5ijCG7F/UK96JA38tfca+E1HWMMcuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM28jeXH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM28jeXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC98C19423;
	Fri, 27 Mar 2026 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774623117;
	bh=XFzY/xO9T8daCV2KtgPbzyO+PQ8RRwWl/SXy033c8pY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=aM28jeXHPYGDpQL0xy93QFL4aFLC5mHhPWIAQzj9J7pzQAEQYsDtsFxHD1b5cQDSG
	 jlhVyIX7ZV1H9RcfhAbnzR/66PDw9QNWORDkZwKZRR3pZ6N9ddvGN7m9LvgIKZoylX
	 WbYd1CWtAfSik3Rd5eyZz1vVq4kqdiiD4lkHW25Fg4j/2hzbFK9gx0boUhrwp0H7vp
	 2UXYFMkojjMOZ9Eze7s6uX6qlu0tYPyvc1CeoVt1FmQdW+JF1Ewu/EZCTvfvhixBr1
	 UVQZjFG05IXoYN18odCmPcignbhehMo93K3hixjLphroRY1N34MuTr5/tGGxdfENM5
	 awnD/nTO8Qp4A==
Date: Fri, 27 Mar 2026 15:51:54 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lode Willems <me@lodewillems.com>
cc: linux-input@vger.kernel.org, bentiss@kernel.org, 
    linux-kernel@vger.kernel.org, Dominykas Svetikas <dominykas@svetikas.lt>
Subject: Re: [PATCH] HID: Kysona: Add support for VXE Dragonfly R1 Pro
In-Reply-To: <20260324204306.694760-1-me@lodewillems.com>
Message-ID: <rp716901-o53p-o4o6-onq9-r271271rqn95@xreary.bet>
References: <20260324204306.694760-1-me@lodewillems.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Mar 2026, Lode Willems wrote:

> Apparently this same protocol is used by more mice from different brands.
> 
> This patch adds support for the VXE Dragonfly R1 Pro.
> 
> Tested-by: Dominykas Svetikas <dominykas@svetikas.lt>
> Signed-off-by: Lode Willems <me@lodewillems.com>

Applied to hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

