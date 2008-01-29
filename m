From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/12] pxa: rename the pxa27x_keyboard to pxa27x_keypad
Date: Tue, 29 Jan 2008 14:57:41 +0800
Message-ID: <f17812d70801282257x573f2aehd808589344f13f9d@mail.gmail.com>
References: <f17812d70801222316w52070845r123fd9b54bb27b36@mail.gmail.com>
	 <200801290126.01530.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:42034 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbYA2G5o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 01:57:44 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1430967wxd.4
        for <linux-input@vger.kernel.org>; Mon, 28 Jan 2008 22:57:42 -0800 (PST)
In-Reply-To: <200801290126.01530.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@vger.kernel.org

On Jan 29, 2008 2:26 PM, Dmitry Torokhov <dtor@insightbb.com> wrote:
> Hi Eric,
>
> On Wednesday 23 January 2008 02:16, eric miao wrote:
> > Subject: [PATCH] pxa: rename the pxa27x_keyboard to pxa27x_keypad
> >
> > The controller should really be called keypad, and also align
> > the naming of functions and structures to use "pxa27x_keypad"
> > as prefix, instead of "pxakbd".
>
> Not sure what the difference is... Seems to be a gratuous renaming.
>

Yeah, though I used git-mv, the result of git-format-patch still looks horrible.
Anyway, this is just a naming issue. While other pxa drivers are slowly
transitioning to a more standard naming convention (if you take a look at
recent [arch/arm/mach-pxa/devices.c] in Linus's recent tree) I first update
this to later patches could be more specific.

Another reason I don't like pxa27x_keyboard is it's too long, really not
suitable as a prefix, and "pxakbd" reads a bit awkward.

> --
> Dmitry
>



-- 
Cheers
- eric
