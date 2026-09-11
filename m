Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A7275AEB;
	Fri, 11 Sep 2026 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136075; cv=none; b=KChIxhAKPHBSgFkBYAM3r7AQjSOXCENr5pm5gjJ+qS6zIRGbXzXRohTZDvo/fxPcM/riaN89g6DNRV5oFAcIi2xY1BO9Sz33Lu7/k0FbFNY9BmPJ/DlwHmlNUyWt1BA8mqOEgu6yL5R97EiPeasol3pvaj6u2CWdIs4fE8+9wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136075; c=relaxed/simple;
	bh=YcR96b0CPruCHzNuRntmU04kiz+ZDDKX3K4wZq/krw8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ABgl3qmRRCpJ/YMDHzrmB5qdrBuEiYc3TbNdztfh97abe++bAHpzaVg5zMknf2YqSsEpUtQmsGnZXG9wXlM3TPTEy0s17avyFrISTIDuMq2/jIxLJJONR2mX5P0IxTdCv0oTCQn8M9kYTvlPJGr54LnFBmLxi9JkZIl9688hFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqzrvn2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqzrvn2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37B1F008A2;
	Fri, 11 Sep 2026 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136074;
	bh=GM+2ljeyjKcDAZ8vz206TrC3EaMevn4lT70TYqXO1MQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Nqzrvn2SmfFdpH00cGbajnv8cQ6w5lCNJE5+wEbMcYxTX0qSobs0Og6uqCIDM5rdu
	 X/ddlOUchESOOFQVDAF+KkUyxgR6hL6XgfFSK0w1+xEVgC4Kmovo8tTKxF9EraZuMl
	 X30LfmgHQeFIdXZNCmkxSV5u9n0n2kKTCSsbrEOkIt7YOTZkfR8R+ZTr39ewB62hwO
	 sXHPzV1Ja34jDWlgUS/xZKFDnEap+v1keDd8pZbbvnHDSckqmDuF9PNgf8+pxnL/3o
	 6iWZeAFR3DXrqXIaJDPXY/ExvIZsX7fzE4x6rTg7vYmf2YREj/FTGkvWabylEgS1fJ
	 ExTPCVjp4JcJw==
Date: Fri, 11 Sep 2026 16:14:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
cc: bentiss@kernel.org, rydberg@bitmath.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, mayhemandcoffee <mayhemandcoffee@gmail.com>
Subject: Re: [PATCH] HID: multitouch: Add report ID mismatch quirk for ASUS
 ROG Z13 Folio
In-Reply-To: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>
Message-ID: <264920or-433p-8173-5osq-4897qr327r88@xreary.bet>
References: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Aug 2026, Lovekesh Solanki wrote:

> Commit e716edafedad ("HID: multitouch: Check to ensure report
> responses match the request") introduced validating GET_FEATURE
> responses return the requested report ID.
> 
> ASUS ROG Z13 Flow (2025) GZ302EA touchpad (USB 0b05:1a30) returns
> a different report ID for Win8 feature request. Before this check,
> the response was still processed and allowed device to switch into
> its full Touchpad Precision mode.
> 
> After the validation, the response is discarded before
> hid_report_raw_event() processes it and device remains in fallback
> mode and no longer exposes ABS_MT_SLOT, ABS_MT_TOOL_TYPE or the
> multi-finger BTN_TOOL_* capabilities for palm rejection.
> 
> Add a device quirk to allow the known firmware behavior for
> this device while preserving report ID validation for all other
> devices.
> 
> The device previously matched the generic MT_CLS_WIN_8 entry, so
> base the new class on MT_CLS_WIN_8 to keep it on the same quirk set
> as before the regression.  MT_QUIRK_CONFIDENCE must be set
> explicitly: it is normally enabled by the class name check in
> mt_touch_input_mapping(), which only matches the MT_CLS_WIN_8*
> names, and it is what makes ABS_MT_TOOL_TYPE available for
> touchpads.
> 
> Fixes: e716edafedad ("HID: multitouch: Check to ensure report responses match the request")
> 
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
> Reported-by: mayhemandcoffee <mayhemandcoffee@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221774
> Tested-by: mayhemandcoffee <mayhemandcoffee@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

