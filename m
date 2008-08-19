From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/evdev.c: Fix printf() format for sizeof
Date: Tue, 19 Aug 2008 11:37:13 -0400
Message-ID: <20080819113632.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0808191137160.1565@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36625 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYHSPhR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2008 11:37:17 -0400
Received: by gxk9 with SMTP id 9so5183207gxk.13
        for <linux-input@vger.kernel.org>; Tue, 19 Aug 2008 08:37:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0808191137160.1565@vixen.sonytel.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Tue, Aug 19, 2008 at 11:43:32AM +0200, Geert Uytterhoeven wrote:
> commit f2afa7711f8585ffc088ba538b9a510e0d5dca12 ("Input: paper over a bug in
> Synaptics X driver") introduced a compiler warning on 64-bit platforms, as
> sizeof() returns a size_t, not an (unsigned) int:
> 
> | drivers/input/evdev.c: In function 'handle_eviocgbit':
> | drivers/input/evdev.c:684: warning: format '%d' expects type 'int', but argument 3 has type 'long unsigned int'
> 
> Use the proper `z' modifier for size_t, and make the printf() formats for the
> sizes unsigned while we're at it.
> 

Oops... Applied, thank you Geert.

-- 
Dmitry
