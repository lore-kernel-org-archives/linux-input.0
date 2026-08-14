Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F62931F1;
	Fri, 14 Aug 2026 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712180; cv=none; b=gljTFeryHhWoo7m04QM912ILltkiTc0W5OTqL02isA3w193zc77lF1RiTf1HbmEajD72nxeteIf1a8pnVIHPkADCGZP+Q5RyLb2rYrzY7jYoQ5Hqh28eqZavYEBpDZn0KKCozKDgL74ELF7t2pTyt/7v3mtfc2YTWFavTTBUS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712180; c=relaxed/simple;
	bh=sOh1D18gKdCJQvOIEFGmqLOgqpSvXrm+xgd8+6zx854=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kGS1yP/0qNoOZyihSg19T/XPNwDVaAQsKMMIRApcfugyI+Rgvk6maaFmq8w0bpdvfRvNzi7EdFmS0rY45A1PvL7P06HzchxeOq/Uyua6HBTuy1SE7YzlHJadKpeNvMjw5RwwgK059CFXUuKuWF1OiLz4TH1gwBNMh5uihEWRnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DapNVsEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DapNVsEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA701F000E9;
	Fri, 14 Aug 2026 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712179;
	bh=hOmLBRmRl5EVGc6D4tNAvfhNg9zr7ob+9vBVyRkxTcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DapNVsEFG495QNzGJVkuwbHcypeLpM2P633WlXB44gylwc3Ls/S/v8oNdh4UL7V/R
	 /CyyhMq0xRsSDiS7cP7FDe3QDh7qTPn0MPg0D+eHiuFJHfFNJIrzMA6h9uZNx/7jt2
	 AsRcqQC5G05D4URAJQWapWxdInr+d6k+Du/pZGj5NqzN1IMM4U9lCok2IdY7F98HfL
	 IrQpQM5Y3Fq2U+fxXO4S1DUcgdEvyhz6/MIBtTQ5CGQyUqMBTa/0krT3fDHXlevdw3
	 T1JJpYGVNIfl+SRQsyfHwhxFCA/Dq8kIFtrbRzj4cnrH0nC78P6PxwnPRJR3j7Fx3d
	 yencvgrpUJEzQ==
Date: Fri, 14 Aug 2026 14:56:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: bakabaka9 <baka9@bakabaka9.tech>
cc: jic23@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org, 
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v2 RESEND] HID: sensor-hub: Fix out-of-bounds write in
 sensor_hub_get_feature
In-Reply-To: <20260805185753.3069-1-baka9@bakabaka9.tech>
Message-ID: <37q85r5n-4r97-n0r7-6953-290r8p5p48q6@xreary.bet>
References: <20260805185753.3069-1-baka9@bakabaka9.tech>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Aug 2026, bakabaka9 wrote:

> From: Xingrui Li <baka9@bakabaka9.tech>
> 
> sensor_hub_get_feature() clamps its return value to the caller's buffer
> size, but the copy loop still copies field->report_size / 8 bytes for
> each report value. A malicious HID descriptor can advertise a large
> feature field size while an IIO caller supplies a small stack buffer,
> such as a single s32, causing an out-of-bounds write.
> 
> HID core stores parsed report values in __s32 slots and clamps extracted
> values to 32 bits. Reject feature fields that require more than one slot
> per value, guard the total byte count calculation, and clamp each
> per-value copy to the remaining caller buffer.
> 
> Fixes: 5459ada2b3cd69 ("HID: sensor-hub: Fix packing of result buffer for feature report")
> Cc: stable@kernel.org
> Assisted-by: OpenAI:GPT-5.5-Cyber
> Signed-off-by: Xingrui Li <baka9@bakabaka9.tech>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

