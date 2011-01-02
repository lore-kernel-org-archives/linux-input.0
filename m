From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Sun, 2 Jan 2011 01:01:13 -0800
Message-ID: <20110102090113.GH5429@core.coreip.homeip.net>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
 <20101229074058.GA13061@core.coreip.homeip.net>
 <AANLkTinmm1=Xp587ii4fHWUv25Skx_V=3eumjpuC48O6@mail.gmail.com>
 <AANLkTikpxkYUjEJQKqtW0KZJDnOZcWpjVho6JLtOt3dm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50008 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1ABJBT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Jan 2011 04:01:19 -0500
Received: by pzk35 with SMTP id 35so1232822pzk.19
        for <linux-input@vger.kernel.org>; Sun, 02 Jan 2011 01:01:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikpxkYUjEJQKqtW0KZJDnOZcWpjVho6JLtOt3dm@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Dec 30, 2010 at 10:25:20AM -0800, Ping Cheng wrote:
> On Wed, Dec 29, 2010 at 2:30 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > Dmitry,
> >
> > Thank you for your effort in updating the patch. Most changes work for
> > me. I do have comments related to raw touch data scaling for MT and
> > single touch legacy client support. Details are inline.
> 
> After revisited the change you made, I think I can accept both
> suggestions. The legacy client support may introduce issue. But it
> won't hurt too much, I hope ;).  The MT scaling offers a consistent
> support between one and two finger touch, which is good.
> 
> So, the only change left is to scale the raw x,y of 2FGT to max_pen. I
> can make a version 3 of this patch for you or you can change those two
> lines if you don't mind. Just let me know.

If there are such devices that have pen + 2FGT then please adjust the
patch as you should be able to test it ;)

Also, if you [re]send me inputattach part for 8001 I shoudl try adding
it to inputattach (it's not there yet, is it?).

-- 
Dmitry
