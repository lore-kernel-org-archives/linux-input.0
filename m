From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Recognise "Dolphin V2" touchpads
Date: Tue, 7 Jan 2014 10:59:09 -0800
Message-ID: <20140107185909.GC31842@core.coreip.homeip.net>
References: <1389039034-14040-1-git-send-email-chris@diamand.org>
 <CAKvfdtK18rQ4TOqwKCj1P3oQs-BQZr2h3db5NH18WdtNjjnH=g@mail.gmail.com>
 <CA+F6ckNx8nxjtXLrgzYyNUBnnmb09tFx8zSe=y0JxtMiVrTooQ@mail.gmail.com>
 <52CC47C5.4090307@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37037 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaAGS7N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 13:59:13 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so501432pbc.20
        for <linux-input@vger.kernel.org>; Tue, 07 Jan 2014 10:59:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52CC47C5.4090307@diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Tommy Will <tommywill2011@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org

Hi Chris,

On Tue, Jan 07, 2014 at 06:30:29PM +0000, Chris Diamand wrote:
> Hi, and thanks for your reply.
> 
> >Umm, however, I had submited a similar patch for supporting dolphin v2
> >device last month and it was now applied into latest mainline.
> 
> Do you mean commit 'ee65d4...add support for "Dolphin" devices'?
> 
> It's in the dtor/input.git kernel but I don't think it's been merged
> into mainline (torvalds/linux.git).
> 
> Running 'git log drivers/input/mouse/alps.c' with the latest
> mainline kernel shows the last commit as '95f75e...add support for
> DualPoint device on Dell XT2 model', which doesn't work with my
> device (Dell Vostro 3360).
> 
> Are there any plans for it to be merged? It looks like your patch
> fixes it much better than mine ;)

Yes, it will be merged together with all other changes to the input
subsystem when the next merge window opens.

Thanks.

-- 
Dmitry
