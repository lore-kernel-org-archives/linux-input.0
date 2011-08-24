From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: wacom_w8001 - implement open and close
Date: Tue, 23 Aug 2011 23:53:31 -0700
Message-ID: <20110824065331.GC15604@core.coreip.homeip.net>
References: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
 <CAF8JNhJ+1=7J3e=Ohs-cpQVwkbYgqOfepxGt=MtWjXFq7=eHDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58425 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab1HXGxg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 02:53:36 -0400
Received: by gwaa12 with SMTP id a12so661102gwa.19
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 23:53:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNhJ+1=7J3e=Ohs-cpQVwkbYgqOfepxGt=MtWjXFq7=eHDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

On Tue, Aug 23, 2011 at 02:21:46PM -0700, Ping Cheng wrote:
> On Sun, Aug 21, 2011 at 1:15 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com>wrote:
> 
> > Implement open() and close() methods for the input device so that we
> > do not start the device unless there are users listening to the events.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
> Tested-by: Ping Cheng <pingc@wacom.com> for the series.
> 
> I can not tell if the driver doing what it claimed in the commit comment or
> not since I didn't trace into the code. As far as my testing goes, the
> driver works as it was; it works as usual after suspend and resume.
> 

Thanks Ping, much appreciated.

-- 
Dmitry
