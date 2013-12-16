From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 2/2] Input: joystick - use sizeof(VARIABLE) in
 documentation
Date: Mon, 16 Dec 2013 11:06:59 +0100
Message-ID: <20131216110659.25a1d9118aa6f473ccfd2e5e@studenti.unina.it>
References: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
	<1387184235-20169-3-git-send-email-ospite@studenti.unina.it>
	<20131216095140.GA15405@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:28211 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab3LPKHL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 05:07:11 -0500
In-Reply-To: <20131216095140.GA15405@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 16 Dec 2013 01:51:41 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Antonio,
> 
> On Mon, Dec 16, 2013 at 09:57:15AM +0100, Antonio Ospite wrote:
> > @@ -181,7 +181,7 @@ at a time using the typical read(2) functionality. For that, you would
> >  replace the read above with something like
> >  
> >  	struct js_event mybuffer[0xff];
> > -	int i = read (fd, mybuffer, sizeof(struct mybuffer));
> > +	int i = read (fd, mybuffer, ARRAY_SIZE(mybuffer));
> >  
> 
> This is wrong, as ARRAY_SIZE(mybuffer) would be 0xff and not the size of
> buffer in bytes. I'll fix it up.
> 
> Thanks.

You're right of course, thank you.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
