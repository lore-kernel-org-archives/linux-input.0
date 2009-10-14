From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ??: Re: how to make KEY_POWER work in terminal system
Date: Tue, 13 Oct 2009 23:12:14 -0700
Message-ID: <20091014061214.GA24535@core.coreip.homeip.net>
References: <bc65a8d50910030813y26138fbet402bdfb3f8321af8@mail.gmail.com> <bc65a8d50910030942hecf96b2hc06ff18f786a1cc@mail.gmail.com> <20091006050633.GF27881@core.coreip.homeip.net> <bc65a8d50910062032u1ab5d215xb37737b197bb7d46@mail.gmail.com> <bc65a8d50910062033j5c2f86c4s2a17cb21cf16a7f7@mail.gmail.com> <20091007043526.GA10204@core.coreip.homeip.net> <4AD47BC2.1070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:56094 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZJNGMz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 02:12:55 -0400
Received: by qyk16 with SMTP id 16so3883074qyk.15
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2009 23:12:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AD47BC2.1070605@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 13, 2009 at 09:08:18PM +0800, Xiangfu Liu wrote:
> Dmitry Torokhov wrote:
> > On Wed, Oct 07, 2009 at 11:33:47AM +0800, xiangfu liu wrote:
> >> thanks for reply
> >> so i must write userspace daemon. right?
> >>
> > 
> > Yes.
> > 
> Hi Dmitry.
> can you give me some tips on write the daemon.
> have no idea on it. 
> 

Xiangfu,

I don't think you want to write a demon from scratch really. I don't
know your platform/framework but I would expect you are using some
kind of HAL daemon/layer that handles power mamagement and other system
functions. That framework should handle powering off as well.

But this is somewhat off-topic for the linux-input mailing list which
deals with the _kernel_ issues.

-- 
Dmitry
