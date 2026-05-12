Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664C3C5836;
	Tue, 12 May 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601303; cv=none; b=Adv/H18a0nRoJyAl6EGrpQb+MqrXLk8GYtAvA+9RhvplxgVzQpozoUAPmdLHG+Xc1aOERt3iTEtw9iHtNxttft1FMpjpk5Dm8KvLJeHkaPshUNoRoVXD1UMZM6SNmKL2X8NjC/LhHGm1ATsT0U5RTn/QSQDcYDorIEJC6Fin8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601303; c=relaxed/simple;
	bh=Vr12ih/E/5VYpS+KG/piuQBqrc07dVhzh3PK0kpEK7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ritd+oc/TR5cm8xzMJYOXaUBaYyBtkQ1YTwBz6KF/T5sniP6XddA8ebHMayOeMGhZa7Vt6C3Vnf6r+oCBqEimYB2xRc+nAfiYVS6tnDPedENdT9VJOPidfdXoFAgt2Rp3hZJzQQS9x+hrQvJ4W4CKtGoG6EEnIGgKJ/a19xZQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUqlSn3+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUqlSn3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95125C2BCB0;
	Tue, 12 May 2026 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601303;
	bh=Vr12ih/E/5VYpS+KG/piuQBqrc07dVhzh3PK0kpEK7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LUqlSn3+Bj3RR9kl871uviJa8Oo+atFF2RnPmybjob14HW1eUlSqBkcoLOYsc0Y5v
	 snb0dTqwZMjfSDLA+iQTr4+zPUDg70PKckcdnlpaOxUA1Isds8NbN4DXngYAaVmVmR
	 3UiSpyvPU1+5xtDKRSm77IWkKx6o8Oo/kej2ePfF2hDSw0LcmE6UQ3jT+yFYoOBYRM
	 bMb6g9ZJERQ+uR+wzg11kC5X/wlgLxMFPD6+X/qHcUM/lGWlIsBZYJjmPkm/VRzpWz
	 uiIfuMz+LUSeTk2maw6rFe+11VqrVRNeXpyk1qxGcVOc75GFh4HjUaHXJ+F7Ms9kNq
	 hxpz26GRcxX4A==
Date: Tue, 12 May 2026 17:55:00 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
cc: roderick.colenbrander@sony.com, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org, 
    Xingyu Jin <xingyuj@google.com>, 
    Roderick Colenbrander <roderick@gaikai.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: playstation: Clamp num_touch_reports
In-Reply-To: <20260417154704.1186803-1-tjmercier@google.com>
Message-ID: <89s27nso-4053-p971-4q69-p4nqo5n7p65q@xreary.bet>
References: <20260417154704.1186803-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Apr 2026, T.J. Mercier wrote:

> A device would never lie about the number of touch reports would it?
> 
> If it does the loop in dualshock4_parse_report will read off the end of
> the touch_reports array, up to about 2 KiB for the maximum number of 256
> loop iteraions. The data that is read is emitted via evdev if the
> DS4_TOUCH_POINT_INACTIVE bit happens to be set. Protect against this by
> clamping the num_touch_reports value provided by the device to the
> maximum size of the touch_reports array.
> 
> Fixes: 752038248808 ("HID: playstation: add DualShock4 touchpad support.")
> Cc: stable@vger.kernel.org
> Reported-by: Xingyu Jin <xingyuj@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

