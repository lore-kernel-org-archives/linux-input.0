Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CF3B5E08;
	Tue, 12 May 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599453; cv=none; b=SCQHndnTrHubtcD8p7GiT5guF3ukO8VAThQdDdSA2ppdFU3wwVIFTLEVHtri5O5uHWGak0Frv1Qw3kTcRJkj4SmE74dx8ZvCNfEYrNIKh10pHWCFt11FeUV/9cPzGK6c9lqozNy+TdwXVI0Ud+y3iEvfxLdhLJK5ODfrjnb4aXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599453; c=relaxed/simple;
	bh=FqgSLSqvBNDdr2FKXGvlgIvEU5kx/WQYvLD7aJvV7uw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X0FnC8xz07H/9PNUmB/lkYmQlYODTzfQf0P2ZHc5MpTLTNNkDwTo5maOfaidk7FHhXNhNxxPyDJhNE5x+S7l6T1vkyHFUFDbnKNtmFmnlPNRBFULZiX01Z5K8722AC9Aag8Pi6lDKUPASI3dltvkoh4K8k7zss2fFZFUenEnTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmUusEH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmUusEH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55249C2BCFC;
	Tue, 12 May 2026 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599452;
	bh=FqgSLSqvBNDdr2FKXGvlgIvEU5kx/WQYvLD7aJvV7uw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FmUusEH+GGUQIXb56qGD2mZRz0UpGqO8SznBytSuh1l+s1to9SO97No5GITZ2t7Q3
	 LSBYpChg9Iv2LaGcxf/MBYC5AUVRy7m5zFiSTfHB4QCW5WxPVKQHjPzhZNFmvLHJg7
	 8L6JvitneMj01ByUo5zS6J/VznP+PeYJ1QwL9sSdoIjUQn+C56SdQC5Zq57A0thhQb
	 KNRIUysoI/RNftkhoxK4dLYsRPDST7n4D1N6rD/urvpj/kRnGDVC9gsGCAbAuissrC
	 wkWbyvhmMjRGpeM/uGHMZySQw1jJ9x8bxsN5Drd7lt2FtLb1BmvdmXuN6pDKgZ5/2B
	 xaWUHxz0MsOnw==
Date: Tue, 12 May 2026 17:24:10 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Ren=E9_Rebe?= <rene@exactco.de>, 
    linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] HID: quirks: really enable the intended work around for
 appledisplay
In-Reply-To: <20260205081131.426899-1-lukas.bulwahn@redhat.com>
Message-ID: <p05qs3nn-n563-15o4-q3o4-109402q95r17@xreary.bet>
References: <20260205081131.426899-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Feb 2026, Lukas Bulwahn wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for
> appledisplay") intends to add a quirk for kernels built with Apple Cinema
> Display support, but it refers to the non-existing config option
> CONFIG_APPLEDISPLAY, whereas the config option for Apple Cinema Display
> support is named CONFIG_USB_APPLEDISPLAY.
> 
> Refer to the intended config option CONFIG_USB_APPLEDISPLAY in the ifdef
> directive.
> 
> Fixes: c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for appledisplay")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Applied, thanks Lukas.

-- 
Jiri Kosina
SUSE Labs

