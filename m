Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE02F8BC3;
	Mon, 13 Apr 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097242; cv=none; b=B9rQpsGxWxNp4CBkavJehWFstEh5dOVlowIDU1huSlNfIDV99HPqSobkSK00o0lLtjIUnDjSNRY0XERVyJqHx8nlVsQ3eGAtttL/AWr3zSRl82YJArdQ8LpVnpn+Gz63rrU0hM8NeH69R6TcOkA9zdBIYFyWN9arPn9aqgWiC8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097242; c=relaxed/simple;
	bh=g/WtVQkyeD/GocRIbrpr/aBI66iBgMs11BwvGQKEUnk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qxqInaKEJ2aBWnVkxWkklR8k/857/08Ra8XYreGMBE0D27hY1OMhFznMFes865M3/StiXOC+61hMAnQ7KHAUKndwIKqI76KaE3yYwBq2/4XnxfxM7DOs6YE6tEsdxTnxm7qlg9HzrQq2xQ6HF+/vCjo4++1K6F1yDVLNB/ha7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ALkNiugE; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ALkNiugE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=YH0mHltCpk09vpZSv6nIZp375YekbuGJG93Vt+2dp8Y=; b=ALkNiugEU9QiB3sJvasopnP1WS
	kPR56ItS7pU6bT5IH8rswElfE1WdMcdIDusm0jcm9/uDclmAMqs79cE2jmokMOPy2XWOhBC38obV7
	CY9jjmfZ5fa3Mf90rM4Lo9YhfnlZMMnfbwkT2BrOhU/+ApeCaJKd5hqCiVwMmJxvIGco=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wCK1R-0000000038Y-2Ca0;
	Mon, 13 Apr 2026 12:20:26 -0400
Date: Mon, 13 Apr 2026 12:20:24 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: robin@protonic.nl, andy@kernel.org, geert@linux-m68k.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com,
 mkorpershoek@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lee@kernel.org,
 alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-Id: <20260413122024.0abf7e1da5e1e954edc52bc9@hugovil.com>
In-Reply-To: <abPXX1eWoq7C7J1R@ashevche-desk.local>
References: <20260312180304.3865850-1-hugo@hugovil.com>
	<20260312180304.3865850-5-hugo@hugovil.com>
	<abPXX1eWoq7C7J1R@ashevche-desk.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Dmitry,

On Fri, 13 Mar 2026 11:22:39 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 12, 2026 at 02:00:58PM -0400, Hugo Villeneuve wrote:
> > 
> > Add support for GPIO-based charlieplex keypad, allowing to control
> > N^2-N keys using N GPIO lines.
> > 
> > Reuse matrix keypad keymap to simplify, even if there is no concept
> > of rows and columns in this type of keyboard.
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I was just wondering if this will go into v7.1, as I am not seing the
patch series in your input/next tree/branch for the moment? Let me know
if you need me to rebase it on v7.0.

-- 
Hugo Villeneuve
