Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250634FF58;
	Wed, 11 Mar 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239179; cv=none; b=VnWiUPfNvnVJ7UYZ98C2R28p6WwHIwl5wM2qC7TNu4i5rCOYgallwW4Ml8x00j/oGn4nmbttAHU5SKIwfHZw3v1YFgeLv+JFtNyMPvv4jRNywRz8WDMdlUyqqIINzkV8obFzPpTXsubpjSgl8+RXB246jkX5dM81PniIKbNXBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239179; c=relaxed/simple;
	bh=UFJj5nlXJjOv7OkDfYn/9Dq27XtDLzCcmr3TL8+spkQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XfzxrfhkNjsLT4VtyUP0m5y0cgi+mTqUghmXY4fcD8gweP5avwYuhJC5o50z2Bz/oAjiEagg1olx/jne67fgESNnrBIdxW7RQN6xQvBeVAjn9L3jMnqkkjQ2KRu8VHYfW7cq7oRFbohpK85n2Vmh7t3YprJ3h9hiRBUtcBnl2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=fail (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=HSE5vDuG reason="key not found in DNS"; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="HSE5vDuG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=Cgamv1/SwJoWr3CbVvyTNp0GlZ/leWyEdkFeMQNIx/4=; b=HSE5vDuGzW7mbfoYMuZSAMBlYw
	rmZpUlZy0yjDV9X5rrLi/x+/oBFEG+JhuGvNFCe9gYfYGqy/Ivlkqzz0z9umGoVF4NwHsDKdoqAAv
	VmkOvkU+uOr4T8BlHkCPC6OkngNYAuAWggqhvRFTViY8pHDnXikA7NZJqQ7u1QNrETn0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w0KVe-000000005un-0wgL;
	Wed, 11 Mar 2026 10:26:04 -0400
Date: Wed, 11 Mar 2026 10:26:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, robin@protonic.nl,
 andy@kernel.org, geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hvilleneuve@dimonoff.com, mkorpershoek@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 lee@kernel.org, alexander.sverdlin@gmail.com, marek.vasut@gmail.com,
 akurz@blala.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-Id: <20260311102601.35ea20963ccebdeebec3c6bb@hugovil.com>
In-Reply-To: <abBugQOUWG_FTs4f@ashevche-desk.local>
References: <20260305192101.2125660-1-hugo@hugovil.com>
	<20260305192101.2125660-5-hugo@hugovil.com>
	<aari1Y1CPZSYEVj3@ashevche-desk.local>
	<abBkk4Ng-_MDHd6t@google.com>
	<abBugQOUWG_FTs4f@ashevche-desk.local>
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

Hi Andy,

On Tue, 10 Mar 2026 21:18:25 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 10, 2026 at 06:37:34PM +0000, Dmitry Torokhov wrote:
> > On Fri, Mar 06, 2026 at 04:21:09PM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 05, 2026 at 02:20:50PM -0500, Hugo Villeneuve wrote:
> 
> ...
> 
> > > > +	int oline;
> > > 
> > > Why signed?
> > > 
> > > > +	int code;
> > > > +
> > > > +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> > > 
> > > Can be like
> > > 
> > > 	code = 0;
> > > 	for (unsigned int oline = 0; oline < keypad->nlines; oline++) {
> > > 
> > > as iterator is not used outside the loop.
> > > 
> > > > +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> > > 
> > > > +		int iline;
> > > 
> > > Why signed?
> > 
> > Does it make any difference given practical limits on nlines?
> 
> Maybe not, but might lead to interesting bugs in the future in case if used in
> some arithmetics.

I'll fix this in next version.

Hugo.


> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


-- 
Hugo Villeneuve
