From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH] input: for best practices, return -ENOMEM instead of
 -1 when returning on mem allocation errors
Date: Thu, 23 Sep 2010 16:56:30 -0400
Message-ID: <1285275390.1999.0.camel@cowboy>
References: <1285251245.2127.4.camel@cowboy>
	 <20100923154407.GA17807@core.coreip.homeip.net>
Reply-To: dave@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:52250 "EHLO
	homiemail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752017Ab0IWU4g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Sep 2010 16:56:36 -0400
In-Reply-To: <20100923154407.GA17807@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, 2010-09-23 at 08:44 -0700, Dmitry Torokhov wrote:
> On Thu, Sep 23, 2010 at 10:14:05AM -0400, Davidlohr Bueso wrote:
> > input: for best practices, return -ENOMEM instead of -1 when returning on mem allocation errors.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> 
> Applied, thank you Davidlohr.
> 
> FWIW there are more code in drivers/input/serio and drivers/input/mouse/
> that return -1 instead of a proper error codes.
> 
Yes, I'll be preparing a patch shortly for those.

Thanks,
Davidlohr

