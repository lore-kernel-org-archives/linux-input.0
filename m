From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Surface Book
Date: Thu, 8 Dec 2016 17:11:32 +0100
Message-ID: <20161208161131.GB30888@mail.corp.redhat.com>
References: <CAFvc4bCRB7N_ErdCH6gneW7XjiEnnDCxtkJTiuTBbRq39oo-hg@mail.gmail.com>
 <1481202321.30772.30.camel@linux.intel.com>
 <CAFvc4bCETydYeqBH=eh7r87X2k8f9DdqJRP9PA97gCGAogquew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbcLHQLg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 8 Dec 2016 11:11:36 -0500
Content-Disposition: inline
In-Reply-To: <CAFvc4bCETydYeqBH=eh7r87X2k8f9DdqJRP9PA97gCGAogquew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zeus =?utf-8?B?R8OzbWV6?= Marmolejo <zeus@aluzina.org>
Cc: linux-input <linux-input@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Dec 08 2016 or thereabouts, Zeus Gómez Marmolejo wrote:
> Hi Benjamin & linux-input folks,
> 
> I would definitely recommend pushing this patch to mainstream kernel tree,
> because it is actually the only way to use the keyboard in a Microsoft
> Surface Book laptop.

Please give a test to the hid/for-next branch[1]. This branch (scheduled
for v4.10) should contain a fix that make the surface book keyboard
working.

And BTW, the patch has been submitted, I requested some changes, and we
did not manage to get it fixed for some weird reasons. Sometimes, making
the device "working" is just not enough.

Cheers,
Benjamin

[1] merge https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/
brnach hid/for-next with a v4.9-rc8 to have something useful

> 
> Thanks for your great work!
> zeus.
> 
> On 8 December 2016 at 14:05, Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, 2016-12-06 at 22:43 +0100, Zeus Gómez Marmolejo wrote:
> > > Hi Andy,
> > >
> > > I am writing just to know how is that your patch here didn't get
> > > submitted:
> > >
> > > https://patchwork.kernel.org/patch/9047221/
> > >
> > > As I also have a Surface Book and this patch enables me to use the
> > > keyboard. Is there any reason where you could not submit it?
> >
> > I'm not eager to answer private emails for open source topics.
> > Thus, +Cc: Benjamin and public mailing list.
> >
> > --
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Intel Finland Oy
> >
