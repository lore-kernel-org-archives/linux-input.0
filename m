Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEA86323;
	Fri, 27 Mar 2026 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614730; cv=none; b=NZMoQC43jN/Amsx30077nbjSIKWO3hL6+5tpoUMldXJXjEc1nVtXxSEnaAVhYz7udLN8ISan6Ea5puGCdeV4tGTSmIiqKofQR/2DdPTwcLBXdt1fcvfuCMHaXDH/CsrUgSVh+6jNQbd7NfUAaT8NYCFzmKm1kJQOXTnowMrFbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614730; c=relaxed/simple;
	bh=1ES2z+ICEEWMqCqEH+74iTXiVsn/8qNnFja3Nzh1nh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FsCBXfZVHmJdEJ6l05fB/CTy5cNbeyjpFDqJxJj18k1Kd1nwxznVyz2/PDhPronQwn2x1bB3FRTU/qlEMHAutinQ74Svi97A7+0Zpyyacurj23nugpprXXWgAGRHbEtDRdQFwGOUOaGMN/CbHsjGBuVKGVA0aZpr+Q+JS5z89cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHrAB2VO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHrAB2VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1F0C2BC86;
	Fri, 27 Mar 2026 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774614730;
	bh=1ES2z+ICEEWMqCqEH+74iTXiVsn/8qNnFja3Nzh1nh8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oHrAB2VONn3NrgPY38keS03Gf6cRRVVG9rjt5A9mALQI4990Sdi6fIQktKa5F6O9o
	 duUAfW95LoIktw8vhwYoBNK0flBnkMjBrJqEzw1Z8Gt6WNIqQU+ErQHK3QPga5vm4x
	 bZb4nIo0TVN5iRDBebghkWEDZbJjaq6NKiiuHpKxIgaCDuvYi3fHwB9ecdBJLE0x+S
	 hVYQBbtwyxVd5UNJt8E1EHSVZgrkLI9m1uIeDWo5FslJawj6VJFQVPxxE5rP4WZp69
	 VVmz3WjTIRNuMcrlYUrodL2UI0A3qrz3uu0Gm1HxlesaL1ETjkgh5Os5wN5O00wxR5
	 cElZmnnPRLnSA==
Date: Fri, 27 Mar 2026 13:32:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Rui Zhang <rui1.zhang@intel.com>
Subject: Re: [PATCH] Hid: Intel-thc-hid: Intel-thc: Add more frequency support
 for SPI
In-Reply-To: <20260318032204.835621-1-even.xu@intel.com>
Message-ID: <3op0o0rq-o5r3-4n68-n3pp-237s14106qs5@xreary.bet>
References: <20260318032204.835621-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Mar 2026, Even Xu wrote:

> The Nova Lake platform enhances THC with half divider capability for
> clock division, allowing more granular frequency control for the THC
> SPI port.
> 
> Supported frequencies include 50MHz (125MHz/2.5), 35MHz (125MHz/3.5),
> and 10MHz (125MHz/8/1.5).
> 
> Signed-off-by: Even Xu <even.xu@intel.com>
> Tested-by: Rui Zhang <rui1.zhang@intel.com>

Applied to hid.git#for-7.1/intel-thc. Once again -- if you could follow 
the standard shortlog convention with all-uppercase "HID: " prefix in the 
shortlog, it'd be appreciated.

-- 
Jiri Kosina
SUSE Labs

