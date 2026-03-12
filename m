Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4CC30F95C;
	Thu, 12 Mar 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319453; cv=none; b=Rxwvao2tY6jQouM9H5Ql7iegwt6Dy5NF5qYfDdG1lst+lV9Ausl95LeAqVwSuoJWh4NmtyQbMXiy5bUyg5AEZVOq/kapyT/6VDg+Glps67q5fwB+Twr+4/Y+JhBo190x+qUhRkX5h373nz65Qcwr0IleXudl8oDt3SwBwUoBrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319453; c=relaxed/simple;
	bh=9CubND64ti9ZB9x0I0fJp8EzB/kjTaFnvMXXCv9MgB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sj3qrPf3aGKKwPmBHuhRMQnfMa1+mKtNo9WkiZMoBL8i0+7+fmUVtZ6ZSqHUvOs5OhGPil2YdrhRoCzb07lFGbFxmp+mF+EP7dY6cOi6yLB9EwBSNvwbNZ5v5ousKbh35YbOkT8Z3UdcXVp0G3112XfpOMhcQfhKU8jksV3gSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjK/kbpK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjK/kbpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFD8C4CEF7;
	Thu, 12 Mar 2026 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773319452;
	bh=9CubND64ti9ZB9x0I0fJp8EzB/kjTaFnvMXXCv9MgB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VjK/kbpKouxQ6fBVytr+1SCn4pB2hsn6OF3Ai6kEU1EpR4AwDUmvWufIwSRleCUT/
	 3C6AYOVO5all37IXT6jbf1T46GTtb43ktlrfDiK33GUYGo18AKKi3h0W4wspCJeGab
	 6xnoUFJe5S1VzQB5TLrBbxnVuBPjxUxi6d1MkB4uzj2xrkKvLiITmoXnN+UWXfPFba
	 nL3KLC/wUfwYRyYeXLZ3x4DSyhomumCanoPdfIAd0f9FHkN4jfb4MMFwLPX47WcYVe
	 z96Zaht4AENZND18MFsOQE6wng6pMDt0y2/3B6QXQrYdzg+zKDdFcpsHYLmGypNWKd
	 ezTOOkE/GITDw==
Date: Thu, 12 Mar 2026 13:44:09 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Adrian Freund <adrian@freund.io>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] HID: logitech-hidpp: Enable MX Master 4 over bluetooth
In-Reply-To: <20260311191933.81007-1-adrian@freund.io>
Message-ID: <0r484pnn-84on-p9oq-r799-pnp48032s2o5@xreary.bet>
References: <20260311191933.81007-1-adrian@freund.io>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Mar 2026, Adrian Freund wrote:

> The Logitech MX Master 4 can be connected over bluetooth or through a
> Logitech Bolt receiver. This change adds support for non-standard HID
> features, such as high resolution scrolling when the mouse is connected
> over bluetooth.
> Because no Logitech Bolt receiver driver exists yet those features
> won't be available when the mouse is connected through the receiver.
> 
> Signed-off-by: Adrian Freund <adrian@freund.io>

Applied to hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

