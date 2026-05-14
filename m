Received: from m65s28.vlinux.de (m65s28.vlinux.de [83.151.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE593DD524
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.151.22.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747970; cv=none; b=h2u2DcjmgmwekC2PKDFv6pLrVBsM69VtcQRyp3cTjxspRcAe140LdiQswDwMJLbjRt4odpSXy6fD2B+X4XIyiIIH8ShGH/NaufMjwLjgofDsvy13KpmxYm2nzDdK0771cMtuGAva/RXyQLkkZwWYA4tm+51l5nxJdY0PNkUeE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747970; c=relaxed/simple;
	bh=WRHSkApYVxLUfGFY+Yul5zYSbSj18nsUnTsk9gggCi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IltzcwTgGI8Tiv5x0IS2wJ3Hzw1AcAsa4a3kCOv/bm0IEVvnJjCztT+b2WW0n2bS5Vki9lAEBfTmFtBzYvCzGU4eZdBGlk2UYMmAIwy9zEMWOE0CK54U6DED9LkHHIYGPLgZZhlWfl3Q1Awu83/TPZmAw+JZr6LwdDoxpcVh+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net; spf=pass smtp.mailfrom=chaoticmind.net; dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b=TrwpOTI/; arc=none smtp.client-ip=83.151.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b="TrwpOTI/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chaoticmind.net; s=default; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xSYmF/41OkD8laZ79A6ED8O7YHcdFKHBVo+dk0MCdaE=; b=TrwpOTI/PLjGkGpHSXYrAt3Bm1
	UXLnx3mVa1uDjZFRSrrXAZ2WeDVBURDA44+kpe477HmuLHUcQ7+vz9YjGgTlUVU93XjbKVvtOv4mW
	VFKh+hekFSTmNNW+7FL1NHsKrsmi+kwM341CjqEOX6+D/ArAf0tSIbnmtRc9Vt3t7ZVEvfJXuT5/k
	NiWQZFA7oku6X9Mnmn2Dac9r+vKOUSejyWtfJwF6Sg5Gq6Xr9j96WAzYX9Py4oqU3M0s0Ay92Hnnb
	cURsN9Um/c98SPYydl9uGiGz0Hmc7bUQIKwAGvifrD+/sJxVMlEj6k9NQgJksHwTHeakqDA9Qq4Jj
	370Z5ELA==;
Received: from p5de65d41.dip0.t-ipconnect.de ([93.230.93.65] helo=lothlorien.localnet)
	by m65s28.vlinux.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <hcb@chaoticmind.net>)
	id 1wNQyd-0005bh-KY; Thu, 14 May 2026 09:59:27 +0200
From: Helge Bahmann <hcb@chaoticmind.net>
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>,
 Sandeep Singh <Sandeep.singh@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bentiss@kernel.org
Subject: Re: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
Date: Thu, 14 May 2026 09:59:26 +0200
Message-ID: <2632507.ElGaqSPkdT@lothlorien>
In-Reply-To: <n0s5q66s-p747-612p-o743-pqr0q2r79448@xreary.bet>
References:
 <6879487.lOV4Wx5bFT@lothlorien>
 <n0s5q66s-p747-612p-o743-pqr0q2r79448@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tue, 12 May 2026, Jiri Kosina wrote:
> On Mon, 27 Apr 2026, Helge Bahmann wrote:
> 
> > Add an input driver that interprets the "operation mode" sensor offered
> > by the amd sfh on some laptop models.
> > 
> > Add a quirk to make the driver work again with the Asus VivoBook
> > VivoBook (turn off the "disable interrupts" flag).
> > 
> > Expose the intr_disable flag as a module parameter in case it turns out
> > to be needed on further laptop models.
> > 
> > Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
> 
> Basavaraj, can you please review this one?

Some additional context, maybe helpful for review:

1. The numbers and behavior were extracted from the ACPI tables
(WMI driver of sorts) of the notebook; I don't have access to any 
official AMD / ASUS docs or similar.

2. I have an alternate version of this change that is more indirect:
- create a HID driver providing an "abstract table mode" message
- have an input driver attaching to this newly defined HID driver

While that is keeping "more in line" with the current driver
architecture, I am not sure this indirection really helps. Particularly,
there is no "canonical" HID tablet mode switch message defined,
so it all remains completely bespoke. I am happy to change it if 
you prefer, but would need your input.

3. Since this is based on Asus VivoBook and its ACPI tables,
there is a possibility that this "op sensor / tablet mode" behavior
is not as universal as I surmise. A point could be made to make this
entire behavior model-dependent (with a mod param to override
/ activate for other models). Happy to take input / advice.

Thanks for your work!
Helge

> 
> Thanks,
> 
> 




