Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D63B7741;
	Thu,  9 Apr 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751004; cv=none; b=ESOYTyli3pgnazQZxcJkEhWXyPaXQ+RsQoiljmEZNHwryxSx89QBnvZx1Fc310bfYtYevKbprTthxBTyTKKRYsJhHdGYOfj/uQtBE3dqz4Ml8QQyPfnIjVkLbn1Yz7iAAZOEipvqO63wa6ivZVcSPMMQpvmyadcwgNtPGvgXBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751004; c=relaxed/simple;
	bh=sunJjNYG84U5F3W1iWNU0WknqFPvvCVjX8TdSKZ5RzY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qFiJyQ5ILmDwz9CC41ZinPHQvHwB1qn5K4mvSleamMuMja5Vs2HLOAy+7eyq+zyKan2A0dcelVJk/q+MF8AsFKCMEUCI7CpWfm/iSHrEW7rS/oa9pXuaj6C5ak+jB3TtGCQZWLo3jepNRo7nwX4rTqNzgSahj4Sr6jT21SnMFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQfS6HoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQfS6HoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC94DC4CEF7;
	Thu,  9 Apr 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751004;
	bh=sunJjNYG84U5F3W1iWNU0WknqFPvvCVjX8TdSKZ5RzY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XQfS6HoVdkr0fOIKzzzynSPwax9A7SMpX1Mup43YXSdlGXhBqWlMOi2J16XwaQ7Uw
	 e5HHmb9aiVaBWg+q+HAZQnKcJOeTj633STV2K7gcOLtv4pnQ4pjq3rJn7Rp1bmbqRT
	 DvBktF8FdApKnX/fgU9FWPzJoDlD0upnDV1S3Vm0d46TfL7dCm+eny7Bnao/bExfRO
	 ETS6VwmIYt5CKAznIU03Hk1wpfRj3wnJ46Pif9vlbgNqIvtKoBYJMcvqtmIidAVnvo
	 EhxVX+h1l1BHnGlCERzmxs5XoVvvDhw8NdtnsPzWQG6GxMBKJ2US7Oq5CtF41HGkdY
	 65T81Wwzk3QIA==
Date: Thu, 9 Apr 2026 18:10:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ivan Gorinov <linux-kernel@altimeter.info>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: winwing: Enable rumble effects
In-Reply-To: <20260307052246.GA21987@altimeter-info>
Message-ID: <s5445noo-o79q-6739-00q8-0q9q0p2o794q@xreary.bet>
References: <20260307052246.GA21987@altimeter-info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 7 Mar 2026, Ivan Gorinov wrote:

> Enable rumble motor control on TGRIP-15E and TGRIP-15EX throttle grips
> by sending haptic feedback commands (EV_FF events) to the input device.
> 
> Signed-off-by: Ivan Gorinov <linux-kernel@altimeter.info>
> ---
> 
>     Changes since v2:
>        - Add comments about USB requests for LED and rumble control
> 
>     Changes since v1:
>        - Fix possible NULL pointer dereference

Now applied to hid.git#for-7.1/winwing, thanks.

-- 
Jiri Kosina
SUSE Labs

