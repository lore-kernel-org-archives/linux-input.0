Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CE30EF96;
	Wed, 26 Nov 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173939; cv=none; b=UMbu+RZxjNfG/aR66emSBWmbmIKGUpDIsZJnbGxrBGXqKZVRnQ75tXcBvzGws5ZmppcT/Ij58HontMGTAg3OS0i+sC3ATwRsBaz2k/LRm1FOHypaK/0rL+Pl6ExfxLC+K9S+MwfEaKZmgK66KrTrRVTR0ET18vS7QnTEepGBe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173939; c=relaxed/simple;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EPTGPkopprTun/S2GIbcoHDS34eFzG7ohlYWhhqRG5UG6QWqcKPi+LHyfeOaKCd/BD3Z3lHo+88uhSC7f6nNycs3UauRX5hYIMLAa1UqFBrIKcBzhKHyynUr6DGpEopFWJmbPMGT5Zdlq9KOzUdbNnA0RzZF9ppHWYO1AFZBeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQHTjOLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQHTjOLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC431C4CEF7;
	Wed, 26 Nov 2025 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764173939;
	bh=YsmZBVpIc4B7O5IpTFE3k08A2Cn0DMN/SxP6LAJOrz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AQHTjOLp4xtfu/6atQNbEjbgbcQFe256qxQJpUapiCWeM0yBIsvWtmu830Lj93ZtN
	 U4Fe1YUnPOUPVE12dlZ++tf/1rTaz+T3NENFgO1nXgJp9TUolqiV99aSP7lUJPZRSl
	 DpHMWWoamMUNXNEuQwpK7tesrp/weOXxhY9l0J4A7kcjx99gCBAKl+onb1s/u/lulE
	 z+rmssRsb/2XxdLPf7mqmEWfK2/JtzXEfkirZywAvGZdHRQa/3egu3qGLtVaI2QzoK
	 bp0+63MrSqeLt4RIj9rQXW3ggsuwKe+3a5wuPH76SrImcsgrkXgJ281VQTmOGqWeuy
	 tRDkIMM4OmgRw==
Date: Wed, 26 Nov 2025 17:18:56 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Terry Junge <linuxhid@cosmicgizmosystems.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Artem <temabiill@gmail.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] HID: Fix Report Descriptor for Evision Wireless
 Receiver 320f:226f
In-Reply-To: <20251120014931.580340-1-linuxhid@cosmicgizmosystems.com>
Message-ID: <3208p630-4rpr-51p9-n68s-q6o39p3n29n9@xreary.bet>
References: <b627cfc9-0dda-4b59-ae5f-83f40cf6088b@cosmicgizmosystems.com> <20251120014931.580340-1-linuxhid@cosmicgizmosystems.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

