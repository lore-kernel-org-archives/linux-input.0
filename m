Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123212;
	b=Q9WCdblQlRp9HT9V5IUp/Lh1wiZ3xvMKO4Wx+7JBwBKhC3hioY1W2iWmg87+zfl50NAM
	 X+zHJzKBinZIJeaDyEGgvzsZOV1CWSCZQba5o/HY6Qj3Yl8Sm+0A4/LkfLvjRyG63Ukfp
	 wo9toceyIGeUj2yoL4vkd9kWsdfmEh5N5wzJg6UV2ajV1OWSeoll/NUWf59xvSBqktYs1
	 ANTW7LjoAnTbyaxheOONthjj+0eZCiaxFLAD5OoZmXVR/CTMDViilTWki8Sahs/i2voyV
	 huRiZ4jY46eGhUoORJtV8IQ1wIUIy7axy0B2Es4YcD+XhUOz7/CgHxq629lFOg3evQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123212;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=Gw66a+sDjwft2wN1oLoRvyKrQ7uIrA0DLzOo7L2rtYM=;
	b=JDHojYW9fwf/bqZWAZGGXj/pUrs5L9cPpqVHtGCD0jcmNagA+yQ09mfLDcy4Mil4pG2m
	 /ECukQajifFpQapoEUSohY2DneGRm/vjZEFi0t0kfo2OsqHU5Om9QpnmOvxUU6Dq2glHP
	 4DP2uzBXlzP+A9jYhopM6rvD0dTb1YH21Luq7KM/ai0Im33ARfv7fWfvQFAA4UQhl66Wy
	 d5gENqU3t0F/S0m0FUWcXksJrwHHCBsM31gyUuiijA5uFtHt/PgVjYjJlj+UMcOXOrfNq
	 KtD6sAYWUPTwwipwCmJyCHQjqp2/hLSMHmucqLzg08NRY3lNQhBGwgYCrTGIQ8DJd4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhUlT94y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D60606A331;
	Thu, 19 Nov 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhUlT94y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C19C1F000CF;
	Thu, 19 Nov 2026 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123211;
	bh=Gw66a+sDjwft2wN1oLoRvyKrQ7uIrA0DLzOo7L2rtYM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=EhUlT94yadxrApewXhCXRtGvEnmxipK+gltSFknFfkRDDwfefdhBPbu99KY309zvQ
	 M4PJ7VEY7X5qqE/9dRIgllHT6V1/xnPebaDil0X14sE6mzW37X+fgZhRlkuxML2Bc5
	 RZgyfcMrSJza0OugANCalrXHWTslDd/6/jhwTom/ZjhKDB6LxtCM4SB3XXEYe3Oiic
	 8u8AT4cS5A87xoJbOuo/OJmYSuQKkfCMA6bvlCghadldxiG5nvApDSb4y7P77jGLnh
	 MFR8DmbEPscTHRzeP3hPeb1FeAT/nuJdCj0zC5Zv1BwrDGy+6OedMkpnBESaOQ9BM+
	 YDdkOVcaBAZmA==
Date: Thu, 19 Nov 2026 22:20:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
cc: even.xu@intel.com, xinpeng.sun@intel.com, bentiss@kernel.org, 
    srinivas.pandruvada@linux.intel.com, mpearson-lenovo@squebb.ca, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    ae878000@gmail.com
Subject: Re: [PATCH v3 0/2] HID: intel-thc-hid: quiesce IRQs during
 teardown
In-Reply-To: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
Message-ID: <76s03s4o-r7o0-r450-1n59-3nrs508o9452@xreary.bet>
References: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Nov 2026, Myeonghun Pak wrote:

> This resends v2 with the probe cleanup formatting requested by Even.
> There are no functional changes from v2.
> 
> Changes in v3:
> - Add blank lines in the probe error paths of both drivers (Even).
> 
> v2: https://lore.kernel.org/all/20261109-thc-rebase-v2-0-mhun512@gmail.com/
> 
> No hardware testing.
> 
> Myeonghun Pak (2):
>   HID: intel-thc-hid: quickspi: quiesce IRQs during teardown
>   HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

