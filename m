Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F852BEFFB;
	Sat, 21 Feb 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667812; cv=none; b=ACUJ1Addjv6CJCULKQ/8xRLb3SIRA/Gqe9wL6LoEetDT81U7Tzu9ByVK2Qw+oLs+/81w6Ndnc0v09tQ9ep4UMChsO2ZBB5FZDW1WLUM2zNtEa7ib5XS0e4vGnb0JXxBH4uG0xB8c2Jv5Lj13BS+hgK4cgL/T2o/slESR3f6E5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667812; c=relaxed/simple;
	bh=RYdzY8tQ9WLmiDZFYcDMxIalaEqaLH3ibEPw4R78R7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pAVWRFyvs0DJytt1ONkHo+rAdpxMQqhu+jJndikFKKZynTq2mwO1I4gRvlBacc6s+6lQm5GluBPHWJk5w88hmHQSp0G+GhaWhK/TGfEqpYo4CHVL23+YtlixVaEfeyHaywAsN47QzJxXN6HnATz4XxhetomI/C5CmSUDcN4ZD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtU5gU0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtU5gU0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBCCC4CEF7;
	Sat, 21 Feb 2026 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771667812;
	bh=RYdzY8tQ9WLmiDZFYcDMxIalaEqaLH3ibEPw4R78R7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CtU5gU0v9gyYCiX7bO4ryH4k/4arK+sP9d7mREUXrPgILB7QJM4HLv9qgnAtPmzYf
	 +onfi178MPk25aoAOwrf0v/9XmdFyD4GxRFf+tokTVVdVlH0JWIuiJkQgvfNAj78pQ
	 NrkMWU4l0gKTR9hItJ6oAIdHUF5n5TwtZTqqSAeBw/rRy9vaYtYzAC3lSYXH82ngYO
	 QNrO8pAP56Fgoi0EN5TJbQKv+wTeI6mnwLecXXBQxF5s8+/QOIapxyxvKWvRPsZcpF
	 FTB6zUF1b7WeyxwJNJ/AdHbG5k8FU855gdY+lwAX81/uyFlaljnrAfGFtIfb+7xODB
	 puIB7si2LqdQA==
Date: Sat, 21 Feb 2026 10:56:49 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Skomra, Erin" <erin.skomra@wacom.com>
cc: Alex Tran <alex.t.tran@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
    Shuah Khan <shuah@kernel.org>, "Cheng, Ping" <Ping.Cheng@wacom.com>, 
    "Gerecke, Jason" <Jason.Gerecke@wacom.com>, Erin Skomra <skomra@gmail.com>, 
    "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] selftests: hid: tests: test_wacom_generic: add tests
 for display devices and opaque devices
In-Reply-To: <AS8PR07MB8373592F3C7C20ACE67808EDF598A@AS8PR07MB8373.eurprd07.prod.outlook.com>
Message-ID: <13s2r95p-s360-r467-40q1-61720162101s@xreary.bet>
References: <20260131-wacom_selftests_display_opaque_dev_tests-v3-1-0857d734ba4b@gmail.com> <AS8PR07MB8373592F3C7C20ACE67808EDF598A@AS8PR07MB8373.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Feb 2026, Skomra, Erin wrote:

> Tested by Erin Skomra <erin.skomra@wacom.com>
> Reviewed-by Erin Skomra <erin.skomra@wacom.com>

Erin,

thanks for testing and reviewing the patch.
Next time please make sure that you send the tags in an appropriate format 
so that it can be automatically picked by the tools like b4 when applying.

I've fixed it manually this time and applied.

Thanks,

-- 
Jiri Kosina
SUSE Labs

