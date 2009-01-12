From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: input: stop autorepeat timer on key release
Date: Sun, 11 Jan 2009 23:36:01 -0800
Message-ID: <20090111233431.ZZRA012@mailhub.coreip.homeip.net>
References: <1231241184.3684.1.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:21657 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZALHgn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 02:36:43 -0500
Received: by qw-out-2122.google.com with SMTP id 3so9559559qwe.37
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 23:36:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1231241184.3684.1.camel@johannes>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-input <linux-input@vger.kernel.org>

Hi Johannes,

On Tue, Jan 06, 2009 at 12:26:24PM +0100, Johannes Berg wrote:
> Whenever you press and then release a key, the CPU wakes up
> three times:
>  * press
>  * release
>  * autorepeat timer exactly 250ms after press
> 
> The autorepeat timer has nothing to do, obviously, since you already
> have released the key, so stop it on key release.
> 

This introduces a slight change in behaviour (the key that is released
may not be one that is being autorepeated) but I think it still makes
sense to do it.

-- 
Dmitry
