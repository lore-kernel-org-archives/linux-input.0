From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Initialize device count variables by -1
Date: Thu, 4 Dec 2014 10:27:14 -0800
Message-ID: <20141204182714.GB8275@dtor-ws>
References: <1417639146-3494-1-git-send-email-aniroop.mathur@gmail.com>
 <20141203223521.GD16951@dtor-ws>
 <CADYu30_FS0A0=fh-uyQ84m8uNkgfs7Ns2OCnigXAM=i5KrPETA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:52904 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbaLDS1T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Dec 2014 13:27:19 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so16182748iga.2
        for <linux-input@vger.kernel.org>; Thu, 04 Dec 2014 10:27:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADYu30_FS0A0=fh-uyQ84m8uNkgfs7Ns2OCnigXAM=i5KrPETA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, a.mathur@samsung.com

On Thu, Dec 04, 2014 at 09:52:26AM +0530, Aniroop Mathur wrote:
> On Thu, Dec 4, 2014 at 4:05 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Dec 04, 2014 at 02:09:06AM +0530, Aniroop Mathur wrote:
> >> This patch initializes input device count variables by -1 in order
> >> to avoid extra subtraction operation performed everytime for
> >> allocation of an input device.
> >>
> >> Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
> >
> > Applied, thank you.
> >
> 
> Thank you Mr. Torokhov for applying the patch !!
> 
> And umm... Could you please provide a link where I can see it ?
> Actually I tried to search on kernel.org but could not find it.

It's in the 'next' branch of my tree on git.kernel.org.

Thanks.

-- 
Dmitry
