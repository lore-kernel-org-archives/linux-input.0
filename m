Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C782264CF;
	Sun, 22 Feb 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757270; cv=none; b=uVvSHk2EVWRqwN93COt08iKmbyIKKk9qjNPMoIXmQU9pjHgRBMW4CNcyZ7GrrFpyxdheHu2SeOgrv3TdymRuRSdO3Yc5DiqOtm83xB7/O6rQZhgikeYC/x+nls4iWEqsOvIu+kfLuQXG+IzvVdYLaoobaJ0NCObCcTTCNmYtekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757270; c=relaxed/simple;
	bh=whzhvVUn3ra9xLmeJQg/Tfgc1VyiKRgAsjj2TVVgxNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/qntqKCfkNBlAwCX6G6K+f0YFEpVItDrFCecj3hU2opmAYT+y2UZPd5CFuddHKKqEDOxu9Xfy7JLOXSkD2zxoglqaaaw78uB5ena1l1JojKSGW4ugThwb0N7NhGX2I5vEtu7Xia5wmECQZhpAZi5Ph5KRmvSeZtGA6TGYXY8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuCFZMQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuCFZMQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A95C19423;
	Sun, 22 Feb 2026 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757270;
	bh=whzhvVUn3ra9xLmeJQg/Tfgc1VyiKRgAsjj2TVVgxNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuCFZMQXDtr4Y3nWYBs6bDun7NNr/adZKgmn4MyfCQi/KNyoHgVe1/Wn2mOtfBV+U
	 IWihtsmEhS7KJXDTV9ICvgHqq/FxKONgG2HGzsJzVvzvzxidRHnKIfJRqK4yNo5JHV
	 3+CasatExAhPbfEQrIM9w9xSy6WFt5Rvf6btslQNCRbrehmefBKZUe1+OBwCqRT/iu
	 V5WU3vBlcYHIap1mOWPFkXiyuQvMyRI5sGs7ykhafZ1khxdPxp9WWmZJxk4eRMOzAf
	 qMQr4OPcMGglMnjUT2OtD4qwj5lanrDTAQxR1JYo7i/WWWu8ztFdn5D6Nm1FjXXw0U
	 6Zo9Mz9pipXjg==
Date: Sun, 22 Feb 2026 18:47:46 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] Input: cros_ec_keyb - simplify cros_ec_keyb_work()
Message-ID: <aZre0qH8rMcSJsa6@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-5-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-5-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:13PM -0800, Dmitry Torokhov wrote:
> @@ -376,12 +378,10 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  		pm_wakeup_event(ckdev->dev, 0);
>  
>  		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {

This can also be simplified: `event_data->event_type`.
