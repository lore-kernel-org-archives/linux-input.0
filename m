Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398B3CAA2E;
	Tue, 12 May 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602318; cv=none; b=VxKEaUdp5cFYNwHeaI48p4SuZrJVGHUHmazjn1cD8J04d14by5vUwbzQUObWy2Cv/Wsnh9gZmBIDWJtIXnHQ0vLjFVTf9zB6MUy8elQL3oSfWVnxcK8FXqxYRzCZoJ5LOoUoAU9LZUIwZ6bU5xtITMViD4iUFM9C4QfA3KhVeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602318; c=relaxed/simple;
	bh=ia+qKRrCXglO+20uOarFjQ6i5urSzNUA0J09VcrbhcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iksHmxOttDy4VjpBLyjHEc7SoEngaazsQY6jscAS6iexxUVECLDOc6tO02ScpFHjVUS8cwtPukj/Gc90o5lJ4ydiMCk2s34bWlu2T52E8vYtJYps2Iw820ochRKQb2YfztQfPzjEf7yUdcVcDUpKz1HEPd/3w/wE0WwakZLDEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+CSx7Na; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+CSx7Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65036C2BCB0;
	Tue, 12 May 2026 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602317;
	bh=ia+qKRrCXglO+20uOarFjQ6i5urSzNUA0J09VcrbhcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Z+CSx7NazrtB0VBk8G0LsBmjXuOv+6NL4ELLUUnXkwARA+7FOo6C1sUDHUFcVPO5m
	 Lc/sjfLIueo2jFn7GU2JWLpOi3qB/a5V7bFuo1sdzZ/4JePiIVvfH1mIlda99z3ZCV
	 bHbfGBFZKz3VOyAFfwTevmX39dDemM0fzs1KQ0M+qtuBhBR7S8SF0WcF9g5NQl42T+
	 ZUw4B5Rv0Wpqf7ws9nyA23mifyZvXVUnPz9B1hxBPbgSuKL40zTT8aYxFUY387IHD3
	 b7COk8Q2nq/Xm/MaZGmyeeFMOrZC0FNE32gqHix8ag3LAltOunpNgOrFN2AnSYoQLc
	 d51gShKzHmK1g==
Date: Tue, 12 May 2026 18:11:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Xu Rao <raoxu@uniontech.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add reset quirk for BLTP7853 touchpad
In-Reply-To: <882C8FD17740299C+20260509082132.2188313-1-raoxu@uniontech.com>
Message-ID: <nn4o9no1-rr48-6s31-65o6-so87pq782286@xreary.bet>
References: <882C8FD17740299C+20260509082132.2188313-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 9 May 2026, Xu Rao wrote:

> The BLTP7853 I2C HID touchpad may fail to probe after reboot or
> reprobe because reset completion is not signalled to the host. The
> driver then waits for the reset-complete interrupt until it times out
> and the device probe fails:
> 
>   i2c_hid i2c-BLTP7853:00: failed to reset device.
>   i2c_hid i2c-BLTP7853:00: can't add hid device: -61
>   i2c_hid: probe of i2c-BLTP7853:00 failed with error -61
> 
> Add I2C_HID_QUIRK_NO_IRQ_AFTER_RESET for the device so i2c-hid does
> not wait for a reset interrupt that may never arrive.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

