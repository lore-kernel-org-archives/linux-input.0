Received: from mail.mcld.eu (mail.mcld.eu [84.242.69.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF33446AF;
	Mon, 13 Jul 2026 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.242.69.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976999; cv=none; b=jFHUyv7Jz+yW/By5r3ajWdBR8bSyVYwbAZkYm+LxBAAJ2fPKt8ICJk2hq0bYYrR3LKa5hIxm4/XLfGHpOzgKW4RlI3UnIDlO0G7Q2wveArj8JnXkUsPUYJ4n/z+8+LNN9vsBpSwdNCrLyw7nK2iBEcl14sOLKxtmRIm+z+PbrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976999; c=relaxed/simple;
	bh=ganKHt0mJAKJ6vtYEPjFRqjYU0xXxxzivTZhFwJii/U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kA0UgmE7fHSQcI/4dZjZXm1ZTVoWEB8xJ4KH1zVMnzTIA9hYHxYBa7Y8OdZ9cON9Pct2BF9KDvuDpBWWw0CeGo6BTS9zIS7yKPzIIF24YDd1wnmmY1YmSYw43sbq+CoP5Rb1Fvdy4HSb0rCMackt74ZYrM/A7G/fhSx35AWZ6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu; spf=pass smtp.mailfrom=mcld.eu; dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=ooKDJ8jH; dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=H2E7IIeJ; arc=none smtp.client-ip=84.242.69.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcld.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="ooKDJ8jH";
	dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="H2E7IIeJ"
DKIM-Signature: v=1; a=ed25519-sha256; s=202501e; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=From:Subject:To:Date:Message-ID; t=1783976977; bh=Ah/qAmnZjMAvPiWORDGKoHq
	budX3LHuHD8w0cGF6j4U=; b=ooKDJ8jHgA/ofXQ9mt746h/Tjkkn1oskw0Q9ulhY3h5BUNeodA
	HFkrZC6Vo1MUvHI/ajoAJKFWfF9s/XvE+UCg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202501r; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=From:Subject:To:Date:Message-ID; t=1783976977; bh=Ah/qAmnZjMAvPiWORDGKoHq
	budX3LHuHD8w0cGF6j4U=; b=H2E7IIeJ4acqI/q1yaYLRKNJA1A6/IvWhBn7GLsUIVuuw/BfOj
	Oxjzxb1L9Wj7II4W4N3NyoZRyCMpzR0j1hsku64v3MwsUwn4wk4FCRuzAQOccdPibByCUDs7lmn
	NqbxblgyOcof7TVVpXx80Nb8yBNV3MCCK+arbUqd/2Y2WkFlBzPrRUpnDt9CpzZwnSPD7udPiO2
	Yf86vd2MyKxYfxo2PsR+XgPhZq5L6TrSbte7x3B/tTlna4Jmziy8zdDC4ejM14dX8j7VDULm2UK
	I2aurf5Hrka5w49Z4QE4VJQOcwbTA77K5lgjbeHnkKI3t6TOzyWGv+fBEMzzyKPbOZw==;
Message-ID: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
Date: Mon, 13 Jul 2026 23:09:37 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: erikhakan@gmail.com
Cc: bentiss@kernel.org, hadess@hadess.net, jikos@kernel.org, k8ie@mcld.eu,
 lains@riseup.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713201201.391538-2-erikhakan@gmail.com>
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
Content-Language: en-US, cs
From: =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>
In-Reply-To: <20260713201201.391538-2-erikhakan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I tested your V2 and both issues were resolved.

Not sure what caused issue number 1 on my system. I can try to dig 
deeper if it would help.

I have 3 Bolt receivers on hand. Two of them have much newer firmware 
(5.3.20, revision 3). The other one is on 5.0.9. Unfortunately I'm not 
sure which of them I was testing on.
AFAIK the only way to get this information is through Options+.

I'm so glad you're taking this on! I'll keep this on my system for daily 
driving, I love that the battery reporting works!

Thanks,
Kateřina Medvědová
