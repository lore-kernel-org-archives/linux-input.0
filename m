Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AD21B185;
	Mon, 13 Apr 2026 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073209; cv=none; b=kDIDPmgTn1JFAyTdJAO96sK9PZsMfcNwjBFV1QT/KtxPcHKSPqrU/r2qAZ4WfBTUA5STrR2HX7AHLnynY75XoVKcqG8zoSg2HfoqmxoBOeI8fncl6Z8mLanSEDxGrjfEj/AhDz1pb/MKEsraJXfu2ggzPy45SuV96GPZUJz6X00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073209; c=relaxed/simple;
	bh=0RZoQTZtPmpXjQCPiRk1/jlpWRRbzrQZo8LeV2Anfyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jWDPedUI0aYoU461l+THEgjjosb30J5LiDk/e0mBamzOkSAIjhAv1a9r2Oke87O53o73Lb3ogu1q7NvAvhhvFuh151NdikM7KO+rYllsYRtThEL016yQNEOYj9OntMsutznYiXmd5qBKKkmnjY/Gi0DPd+d5crA9AtPoSu89eoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUVPlgPQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUVPlgPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD5BC116C6;
	Mon, 13 Apr 2026 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073209;
	bh=0RZoQTZtPmpXjQCPiRk1/jlpWRRbzrQZo8LeV2Anfyw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eUVPlgPQ6sIiYOOYrVO2qeSeMa4ONUTSoArVsfB/kk6D/G3OcxGWY4GG22ET5b3M+
	 I4JMA067FYEIoII9b6TYkPl7bauYCKUEzkq8v++RsgG6nNnQcwqZLwy5flw/ZS+SI9
	 ZRHlXXKAdtMfGFOh6mLCdwvGaBkljFmH10gcba9Vc2yaZ2mDqJuw9vCmyG2kOQlfQl
	 FPAKLFw9AeTa3KmrZJoPlZRuvXjjQ0PuiGMLw4cCjgqzo91G6fLZ7qZ/dsboqv53Al
	 QAFIn7j1EtfF0UKaeK8LWfgxHI2cfwSiXfc7QdIEQE9zU9LRGqNh5pHErjzBsT05+x
	 A/7+EFgf2LJog==
Date: Mon, 13 Apr 2026 11:40:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable <stable@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] HID: core: clamp report_size in s32ton() to avoid
 undefined shift
In-Reply-To: <2026040609-equation-ascent-2b3d@gregkh>
Message-ID: <77813997-239q-78s4-spq4-26802200s79p@xreary.bet>
References: <2026040609-equation-ascent-2b3d@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Apr 2026, Greg Kroah-Hartman wrote:

> s32ton() shifts by n-1 where n is the field's report_size, a value that
> comes directly from a HID device.  The HID parser bounds report_size
> only to <= 256, so a broken HID device can supply a report descriptor
> with a wide field that triggers shift exponents up to 256 on a 32-bit
> type when an output report is built via hid_output_field() or
> hid_set_field().
> 
> Commit ec61b41918587 ("HID: core: fix shift-out-of-bounds in
> hid_report_raw_event") added the same n > 32 clamp to the function
> snto32(), but s32ton() was never given the same fix as I guess syzbot
> hadn't figured out how to fuzz a device the same way.
> 
> Fix this up by just clamping the max value of n, just like snto32()
> does.
> 
> Cc: stable <stable@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

