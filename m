Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E946A602;
	Fri, 16 Oct 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142500; cv=none; b=OZeLuhD2TFkoHVClRgOnwqaOlRp0Br81YashohLQlAhmffc0TRVgrdGTuVhP7GAMHj9pdMEinEKtzS90Dg7Z9GZ5rsSI9ELK2JtK5LHcY82D4KoqYgCWB2JxyT8yhQ3ka+mSzl9QvzWRu65WUdDb9ie4u1a71HSTjvEeXU10Na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142500; c=relaxed/simple;
	bh=Glvcebfez0+QJSJF+5VRdC9f53AUg9fYRvJWFajzc9k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YEgza5Z2RkmgH8ulx9zriHPq2JPsakBb8zPz+OCaFt11DoizmRguaw7EZto46vQNYVWbdOTrEOuVcbwFFVTiJYBtY58h9B1WcPEhDGbqT1um8jknUiwxjznTVsJM+5/Z+Ifsk5wxECO/iruHqzzWc66Ob3jU1ZUK8XF58hgl+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERb8P470; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERb8P470"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126A01F000C5;
	Fri, 16 Oct 2026 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142498;
	bh=toJtJpJ+/oTzuP+QURPjOSCP0Rb+SdTc4iIpX7bJUs4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ERb8P470EI/tZ2yEbuF1wn+QVULWchnX2LzU2ttjU3J6dfrCY6I3pUpp2XpsKttgm
	 FJ3Iq1yBlWvAYXV7s/zxonusBqahJIS1mFOh9PwYmRb/cb6hHlbEbv9xTlhF3R25tw
	 u1U1xhlh0NyRhE9tUocnUndmIKzqbEXjhm/SvxiGID3BBaK8MBPlJfnIcfIy/4KIk/
	 Qae3yoVt2Y/xgvzDMk5IxeVXQqAHZCIizdTAsUL/orbuLIhnw7upqoqFj5Sr38Y/Au
	 cZbCPmI0n2pkShgkxbrmTKB/IuLOI2WDLdZb0D3x3DhauCsblQqjYlVqlDCCInKsnR
	 mIidX5uJXT/xA==
Date: Fri, 16 Oct 2026 11:21:35 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Gabor Tanz <gabor.tanz@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Always poll the Anne Pro 2 with product ID
 a292
In-Reply-To: <20261012150357.685671-1-gabor.tanz@gmail.com>
Message-ID: <s63r0485-n7o9-r96r-987r-272052979p51@xreary.bet>
References: <20261012150357.685671-1-gabor.tanz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Oct 2026, Gabor Tanz wrote:

> The wired Anne Pro 2 identifying as 04d9:a292 stops delivering keyboard
> input after a period of inactivity. Unplugging and reconnecting the
> keyboard restores input.
> 
> Keeping ObinsKit running prevents the problem. A read-only userspace
> reader that keeps USB HID interface 1 open also prevents it, as does
> usbhid.quirks=0x04d9:0xa292:0x00000400 without either application running.
> 
> Commit ca28aff0e1dc ("HID: quirks: Always poll Obins Anne Pro 2
> keyboard") added HID_QUIRK_ALWAYS_POLL for product ID a293.
> The variant identifying as 04d9:a292 exhibits the same symptom.
> Apply the quirk to this product ID as well.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Gabor Tanz <gabor.tanz@gmail.com>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

