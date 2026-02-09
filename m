Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013B2C11DE;
	Mon,  9 Feb 2026 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.82.102.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667702; cv=none; b=SnZRFu99nvJWKh7yf2QjGh4iTsGrb5PpQd+uOR4OAF8gEBKQCYZKAn9473zgtzkh5PZC/TQC+tTTqOHBf3ynuSHnqLgYNExoeBzjdK+E6yJcLFaDxH+24NR0oflwAVgQoU7DsoNFHPcuRcmZWTVQCjZvKzP9NRJU2V4YiohVqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667702; c=relaxed/simple;
	bh=peUj/waymOyzmN9vbS8BAjPS6LY1dDsUThjMYMVkHdc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HVuR2lWBEiPPygrncLh2Rdaby22dmxurBA05hFz7/6E9EnYLOjF6S7TSCwBZcvkzTMeHl82G6nU8Qd4HPeScaGh19GetkzNzh3yUuOSh9f8EO++CPgBxrwjoezUf9CbE2OLk2lR6ePTVGIoNHOSFT/KCi+o1NojdkdeTGoSLFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info; spf=pass smtp.mailfrom=altimeter.info; dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b=s5WgUg4J; arc=none smtp.client-ip=35.82.102.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altimeter.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b="s5WgUg4J"
Received: from webmail.porkbun.com (unknown [35.86.129.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: linux-kernel@altimeter.info)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id 70D2D463C9E;
	Mon,  9 Feb 2026 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altimeter.info;
	s=default; t=1770667696;
	bh=TIPwcV8ypNJnYEXCHkuserUUtmXrjj93n8Hn742KDuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=s5WgUg4JqPVHANYldLATyohIOvL7UIyP73GzS0v410mniViOM0a9cPO9AdFdaw6+Y
	 ZUfW86pB09BRqrIxU2+ZAphfGTmZbd8xIU58zxyiXYVDLb+2MuMJbNgHeF+Gs6EQuY
	 b9VA4/aZH4riFJVsGZi8Qy/3BairdISMgpqDSHfk=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Feb 2026 12:08:16 -0800
From: Ivan Gorinov <linux-kernel@altimeter.info>
To: Ricardo Esteves <ricardo.lopes.esteves@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Input: change joystick 80 buttons limitation
In-Reply-To: <fc66f27b-9a73-4a71-8dbe-f48609719d90@oracle.com>
References: <fc66f27b-9a73-4a71-8dbe-f48609719d90@oracle.com>
Message-ID: <e648336f4a4c3aae98091900706abc49@altimeter.info>
X-Sender: linux-kernel@altimeter.info
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-09 05:36, Ricardo Esteves wrote:

> Currently linux joystick support is limited to 80 buttons.
> The default value for the max scan code that a key/button can hav
e in the linux kernel is 0x2ff (767), which is equivalent to 80 
keys/buttons.
> The value i propose in the bellow patch is 0x31d (797) which is +30 
> buttons, so a max of 110 keys/buttons.
> Works perfectly with WINWING Orion Throttle Base II + F15EX HANDLE, all 
> 110 buttons are recognized (is the joystick i found to have the biggest 
> amount of buttons so far).

That device will be supported in 6.19, including LED controls. I have 
also posted a patch to enable rumble feedback.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-winwing.c?h=v6.19
