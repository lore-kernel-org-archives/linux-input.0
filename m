Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBD466B4B;
	Fri, 16 Oct 2026 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142535; cv=none; b=gjzTXcgQxKGVI9+DSXpmAhPxL3bEhTfL3OfeoGyOYCu0W5mWHVEajC+H+lGyZzPEEMWyu+QTtfagrk5fsJPCzJqgMQDNwe5WohKtFhdLbXFZny4tPfFSOW1FvtUp9d1ImwhqiXCAZDCUjoY5otQoCv2t4v7wxaRS+JO/iksUkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142535; c=relaxed/simple;
	bh=etS4pjkAGPjNTCx5ANpUNgbzRBT1VSahH3JOm95zPMs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gRMCakzR/36I0QO3wYr6GJlpwqAtF54blSJvKuQEDYJCDHeKRdmvv1uwUFsURJGw+8uP1T8L5Pv+1ce6qOHXc1EhjnSgmYvf4nZfe2mU9llKr4uBorlA1pMUUmIlqqONyKqxTQrZdFuMDDm2Qksno5LTJVGxPGaksG384pz7JM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixVGgAg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixVGgAg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D95E1F000C4;
	Fri, 16 Oct 2026 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142534;
	bh=Qdgxp2ssNEdp4KsTciuAL1L5zVlD+aVGDM8DiApmd88=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ixVGgAg3c1YgnTZc6d7N/wehBnhMGInGU3gbgU6WdjcairiLxbTKFjNHRz79lcOPr
	 LjyN8CWYN37BUA99y7nCKzZXMCXNV0jwTH2VOxOTvLxywBuVnItdaEwzfx3gzx/iRV
	 5h9dVIf6d2nsJhqhAQFv9sOqn5H9wKEhQHgRqZ5i/WtHqEvP31ogYZTKAhVucLUJh6
	 Ew6Lkg7Jr9UroQjOKXdrSM/VU8Eiit5FP7koZjNsjbX5nhRDFWm+V0qOgs96RQp78L
	 3gvBP6BKFy+e6NRwK77t88G2sv4J/kwPHR5Wr+erIWUutIPzcGZug5gs0xGsuJdcUu
	 R738y/qeDb92Q==
Date: Fri, 16 Oct 2026 11:22:11 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Liang Haowen <nbg2974@gmail.com>
cc: linux-input@vger.kernel.org, bentiss@kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: add ALWAYS_POLL quirk for YJX-CHIP EWEADN wireless
 receivers
In-Reply-To: <20261012154240.33221-1-nbg2974@gmail.com>
Message-ID: <2024o6n5-po6s-8s39-080q-60285ss8p4o1@xreary.bet>
References: <20261012154240.33221-1-nbg2974@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Oct 2026, Liang Haowen wrote:

> The 2.4 GHz receiver in EWEADN G5 wireless mice (YJX-CHIP A8A5:2255)
> presents its mouse data on a standard interrupt IN endpoint. usbhid
> only submits read URBs for an input device while a userspace consumer
> holds it open, so on boot or replug the mouse pointer stays dead until
> something opens the node.
> 
> The same receiver ships with a number of other EWEADN models (A6, A7,
> E7, E9, E11, G2SE A, GS02 Pro, S7, S9SE, X23), so the quirk covers
> the whole family.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Liang Haowen <nbg2974@gmail.com>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

