Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A517BA2;
	Mon, 23 Feb 2026 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771821662; cv=none; b=RRdpEfeE6BOi+JSXHKBD7SaRD3Jzb/e7qOwkBSUh+3iVWHjombyCm90v5R5n5WOgkeh2lU1iI0bRJVB9StjBRTfOc0XttQyaSZu5f4SQY8k+E9uZPWJmcKBwcfnZmSOGpbZSmF+azVs5PqlKG1yXw3+o9sXdJWmwLAUoxXFTF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771821662; c=relaxed/simple;
	bh=rkl5ISYTA5WogYu2j4eAKVAPBZHyxjqdXWucu8dPCAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE7PNqLJc1uHNArht8alUl4UN9iDQu7ns7l016BUijWiEJqMCMStuZIOks/CQNEpPMyCOTOfm6bLImp4Qoz1OOnZL6L9gz3QxkseyaLLf+LGG+Zxrf0hexDKaE3KVflLFeTp2fRdK9+1deseu3w2Pvj0+xwE/1IC+moAbhQVLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaNt2MyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaNt2MyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36784C116C6;
	Mon, 23 Feb 2026 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771821661;
	bh=rkl5ISYTA5WogYu2j4eAKVAPBZHyxjqdXWucu8dPCAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaNt2MyZer1trVczxD8HG4WS21rjmsF6n5m0L+AqiDwTlwiiKpzjEOJQmFUC03rJZ
	 HwNLNBG77qaL6gR3RPQ9jBb56ObE3Q8VD94tCEGFXxiSQMzhbHMQZ2xkW1r8D88RD4
	 EB8DbP11ONW1x+e9ZNvG+gpz7WEoZ3+K11k5RH4+KdfrPXmOfVdRX0MzQxLZ1NQgmB
	 x2j0OAxY2CrvG7TnC6hj3GbbEJZH1revO+OC8q6zzPFT4LG1rNnWiATh9qjqVBEgrP
	 kjZNbeNLWixoYtxPPR0+ppDWefoXX69Km0E6nFxEesHBxxr0VOpbkZ2TqSLAPx75dh
	 zpGkVvvmqERWA==
Date: Mon, 23 Feb 2026 12:40:57 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Input: cros_ec_keyb - factor out column processing
Message-ID: <aZvaWdFPN5TJm4Rb@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-7-dmitry.torokhov@gmail.com>
 <aZre8rWDvVDZ_T6p@tzungbi-laptop>
 <aZvOcaGq3VAVV2Oh@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZvOcaGq3VAVV2Oh@google.com>

On Sun, Feb 22, 2026 at 07:51:10PM -0800, Dmitry Torokhov wrote:
> On Sun, Feb 22, 2026 at 06:48:18PM +0800, Tzung-Bi Shih wrote:
> > On Sat, Feb 21, 2026 at 04:37:15PM -0800, Dmitry Torokhov wrote:
> > > +static void cros_ec_keyy_process_col(struct cros_ec_keyb *ckdev, int col,
> > > +				     u8 col_state, u8 changed)
> > 
> > What does the second 'y' of keyy stand for?
> 
> It was supposed to be "keyb", I'll fix it before applying.

Feel free to use my R-b tag after applying the change:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
