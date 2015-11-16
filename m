From: Jiri Kosina <jikos@kernel.org>
Subject: Re: drivers/hid/wacom_wac.c:2484: bad if test ?
Date: Tue, 17 Nov 2015 00:21:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511170020530.20111@pobox.suse.cz>
References: <DUB128-W780599F7F3EBF63F33B96A9C1E0@phx.gbl> <alpine.LNX.2.00.1511162336270.20111@pobox.suse.cz> <CAF8JNhJ1Rpxnhcu=BtnhN551sLEBYzTmjrvbcjxk-gF5VqHdig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48184 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbbKPXVm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 18:21:42 -0500
In-Reply-To: <CAF8JNhJ1Rpxnhcu=BtnhN551sLEBYzTmjrvbcjxk-gF5VqHdig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: David Binderman <dcb314@hotmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Skomra <aaron.skomra@wacom.com>

On Mon, 16 Nov 2015, Ping Cheng wrote:

> Oh, boy! It should be:
> 
>  if (features->type>= INTUOSHT && features->type <= BAMBOO_PT)
> 
> Thank you David for your sharp eyes ;-).
> 
> Jiri,
> 
> Can you fix it upstream or do you need a patch from me?

Yup, I have already comitted fix with David's Reported-by:, just wanted to 
make you aware of this.

Thanks,

-- 
Jiri Kosina
SUSE Labs

