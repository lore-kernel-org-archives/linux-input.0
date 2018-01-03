From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add entry for the Teclast
 X98 Plus II
Date: Wed, 3 Jan 2018 16:10:42 +0200
Message-ID: <CAHp75Ve6fFEwm6v5txwa-uBpGrTra5+1xEF5Ps=cvyh=S6iLEA@mail.gmail.com>
References: <20180102134239.3579-1-paul@crapouillou.net> <20180102183928.15267-1-paul@crapouillou.net>
 <20180102234033.GB24794@fury> <5c5301e1-48f5-5762-b1d8-95e5f4a2bd8d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:46352 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeACOKn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 Jan 2018 09:10:43 -0500
In-Reply-To: <5c5301e1-48f5-5762-b1d8-95e5f4a2bd8d@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Paul Cercueil <paul@crapouillou.net>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jan 3, 2018 at 10:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 03-01-18 00:40, Darren Hart wrote:
>> On Tue, Jan 02, 2018 at 07:39:27PM +0100, Paul Cercueil wrote:

>> Generally "testing" is the branch you want to base on if linus/master
>> doesn't work as the review-* branches *will* rebase frequently.
>> Exceptions exist of course, and this patch is just fine - just for
>> future reference.
>
>
> This is my "fault", I asked Paul to rebase on top of
> review-andy as that had 1 new silead_dmi patches missing
> from testing, so otherwise we would end up with a conflict when
> merging review branches. Same reason why I've been basing my
> silead_dmi patches on top of review-andy even though that is
> an unusual base to use.

Darren, in this case it's exceptional since there is a stream of a
patches against silead_dmi. They appear faster than older appear in
testing.

-- 
With Best Regards,
Andy Shevchenko
