From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] input: fix sur40.c dependency/build errors
Date: Sun, 18 Oct 2015 16:27:42 -0700
Message-ID: <20151018232742.GA12041@dtor-ws>
References: <559FE1AD.5020907@infradead.org>
 <20150710170328.GB35720@dtor-ws>
 <20150710170853.GC35720@dtor-ws>
 <20151017171354.GF13470@dtor-ws>
 <5622955C.2060204@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36236 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbJRX1q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Oct 2015 19:27:46 -0400
Content-Disposition: inline
In-Reply-To: <5622955C.2060204@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Florian floe Echtler <floe@butterbrot.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

On Sat, Oct 17, 2015 at 11:37:16AM -0700, Randy Dunlap wrote:
> On 10/17/15 10:13, Dmitry Torokhov wrote:
> > On Fri, Jul 10, 2015 at 10:08:53AM -0700, Dmitry Torokhov wrote:
> >> On Fri, Jul 10, 2015 at 10:03:28AM -0700, Dmitry Torokhov wrote:
> >>> On Fri, Jul 10, 2015 at 08:15:57AM -0700, Randy Dunlap wrote:
> >>>> From: Randy Dunlap <rdunlap@infradead.org>
> >>>>
> >>>> Fix build errors due to missing Kconfig dependency.
> >>>>
> >>>> drivers/built-in.o: In function `sur40_disconnect':
> >>>> sur40.c:(.text+0x22be6e): undefined reference to `video_unregister_device'
> >>>> sur40.c:(.text+0x22be77): undefined reference to `v4l2_device_unregister'
> >>>> drivers/built-in.o: In function `sur40_process_video':
> >>>> sur40.c:(.text+0x22c1d4): undefined reference to `v4l2_get_timestamp'
> >>>> drivers/built-in.o: In function `sur40_probe':
> >>>> sur40.c:(.text+0x22ca82): undefined reference to `v4l2_device_register'
> >>>> sur40.c:(.text+0x22cb1a): undefined reference to `v4l2_device_unregister'
> >>>> sur40.c:(.text+0x22cbf7): undefined reference to `video_device_release_empty'
> >>>> sur40.c:(.text+0x22cc53): undefined reference to `__video_register_device'
> >>>> sur40.c:(.text+0x22cc90): undefined reference to `video_unregister_device'
> >>>> drivers/built-in.o: In function `sur40_vidioc_querycap':
> >>>> sur40.c:(.text+0x22ccb0): undefined reference to `video_devdata'
> >>>>
> >>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>
> >>> Applied, thank you.
> >>
> >> Actually, Mauro, can this go through media tree for now?
> > 
> > Do we still need this patch?
> 
> Yes, I just tested 4.3-rc5 and it still has this problem.

Applied, thank you.

-- 
Dmitry
