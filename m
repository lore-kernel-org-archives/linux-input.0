Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525222D5412;
	Tue,  2 Jun 2026 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382531; cv=none; b=WOc6mmFkRwCEQZDQyMeDuZDUmRu6D1IWiDG+B8YwnzAKqZtW43a0bdrNzp4DVZSyRtyLBYlXufYZw1Wof7AtyAMpcwJ9s2C7fcjFXaaaDBRxtP4JXwPsJnoGLJq4naGQKXhMWdu9ceCO6TdTWB84BEqFrX3iQnns1BUQN/iiZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382531; c=relaxed/simple;
	bh=/BvtIuJaqaod6Smnrww2cwqnIZLc0N+F7oQyJ0IUlMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkSt+krSEDzEtbAM1g4qATuN7AiyzISgdzYfcRWJxTcqSsMA5VtiKuT7odYhp9higPXNQ4ocsqj5IkanW7K3v58eupT1iFNTuRTTA9RmPuL7qDMuSswAWVFDhbalyxJwC7bD50y4IUXjBANtQ3ykxiGcqOGns+N6Uw7IYtzcnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QH7folVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QH7folVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2067C1F00893;
	Tue,  2 Jun 2026 06:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780382530;
	bh=DqbZJTPPL4+f97UZ7puF0NIKCaJWCDaBOpewRU4sP+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QH7folVnpOcVYglvXiQr+uKa68di16nbg6lAuCAavvNJ7gJkd9GX6vniu3gjzNnfx
	 kxVe/NYNojmwWxjUYkX+6pHIEG0pS59xh2ewvp13ip4O0AYyu3r2sXSPghFPFEeYAu
	 nSU6sVKcMtASXUYV0ge9YC8gOBkAbyXfEcW5shYo=
Date: Tue, 2 Jun 2026 08:41:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Rao <raoxu@uniontech.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: switch HIDBP devices to boot protocol
Message-ID: <2026060216-freezable-donated-99e5@gregkh>
References: <A49C63267F00CDA8+20260602014835.2624940-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A49C63267F00CDA8+20260602014835.2624940-1-raoxu@uniontech.com>

On Tue, Jun 02, 2026 at 09:48:35AM +0800, Xu Rao wrote:
> usbkbd and usbmouse are HID Boot Protocol drivers. They do not
> parse report descriptors before decoding interrupt reports; instead,
> they interpret input data as the fixed boot keyboard and boot mouse
> formats.
> 
> The HID specification defines SET_PROTOCOL as the class request
> to select report or boot protocol. Boot subclass devices may power
> up or return from reset in report protocol, and hosts are expected
> to select the protocol they intend to use.
> 
> Do not depend on firmware or a previous driver to leave the
> interface in boot protocol. Send SET_PROTOCOL(BOOT) during probe
> before the interrupt URB can be opened.
> 
> Keep failures non-fatal. Some devices may reject the request while
> still sending boot-compatible reports. For those devices, the
> existing driver behavior is preferable.

Do you really use these drivers for devices?  If so, why?

And shouldn't the failure be fatal?  If not, why even attempt to send
it?

How was this tested?  On what devices?

thanks,

greg k-h
