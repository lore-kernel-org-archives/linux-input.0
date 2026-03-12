Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63592BEFF5;
	Thu, 12 Mar 2026 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320161; cv=none; b=Rd1T8lNIugB53MLrGK07GXTZxnBgL/UbFKfc7q3hI84JfbBXJvsTpFosiyGmVpspERmLWE7IA8PsLN79wQ/7BZaLhTZxtchY62ZxZorrdVoC1f3Ix2P25eBAzKprs5EIqq9UJ9oMjrLV1RHaNV5epbfw0cR8VW7znD1xhrVSH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320161; c=relaxed/simple;
	bh=ONjCBgqouAGfuJ+ex/IEfBcDviqwC9MU3wg300qZMk4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ec9+FSelk6o76mXcmSQ85u31zrbvfUSzotkrtVaQGbq+lwBukmc5jPKNHvSIDBoh2rehJXk3h8f7UlF9l8Z3PvOJoLbadjxvxyM4s8kwcY062qdoAbkAkAK2zM586eaNr1HdbWrXlshSxZzZnBt+a3l836i7dS2PdTfU6ul9mLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCBMs8Jj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCBMs8Jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25A5C4CEF7;
	Thu, 12 Mar 2026 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320161;
	bh=ONjCBgqouAGfuJ+ex/IEfBcDviqwC9MU3wg300qZMk4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XCBMs8JjzZiSaX5GezN+J8zHM8k71wININOZ2zhi27zFlb+aav2yIxjeHAVgh/xg5
	 7z7eLET9F1EOTFjQujohyknRVJc7i4mWJz/85u0PbcykbGzwJvgBx/NweWO84g56HG
	 yukX/GTPK3mE86p/LhHD9/gg7CfrrpH1b/P30uHlBQJjUp25OC4s0EQWD8EwXkXdlG
	 zo+TAbt+RWWqaTqIlXMLWeXWrayk2HM+SPcMqBksg+2GTj08j79bz2ihYzItBLi4O8
	 T9hrNY48OyKg5BJTxQiRTHk0v5RHzKAsXXBU/qdbgy5g5yzGqZx5mI5ped0kZFD5/v
	 YR4qQXQJXCjdA==
Date: Thu, 12 Mar 2026 13:55:58 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lucas Zampieri <lzampier@redhat.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sebastian Reichel <sre@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
    linux-pm@vger.kernel.org, lcasmz54@gmail.com
Subject: Re: [PATCH v6 0/3] HID: Add support for multiple batteries per
 device
In-Reply-To: <20251226111019.31243-1-lzampier@redhat.com>
Message-ID: <5079os89-ss44-43o8-ooo2-5n4nr292rrsr@xreary.bet>
References: <20251226111019.31243-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Dec 2025, Lucas Zampieri wrote:

> This series adds support for HID devices with multiple batteries.
> 
> Currently, the HID battery reporting subsystem only supports one battery per
> device. There are several devices with multiple batteries that would benefit
> from this support:
> - Gaming headsets with batteries in both the headset and charging dock
> - Wireless earbuds with per-earbud batteries plus charging case
> - Split keyboards with per-side batteries

Lucas,

I've gone through this v6 and it looks good to me.

There are some simple conflicts with the current codebase through. So 
instead of me fixing them without testing, could you please look into 
rebasing it once more on top of hid.git, and I'll then merge it?

Thanks!

-- 
Jiri Kosina
SUSE Labs

