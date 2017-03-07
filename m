From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH v2] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Tue, 7 Mar 2017 09:15:58 +0100
Message-ID: <20170307081558.GB1805@ozzy.nask.waw.pl>
References: <20170302120242.6342-1-kernel@kempniu.pl>
 <CAHp75Veewvym2gVXhUSktOxb6=MLMwXXnSoTDEaMhtSa_zL2Kg@mail.gmail.com>
 <20170306070900.GA1372@ozzy.nask.waw.pl>
 <CAHp75VftVMeCgLBSR0DySG2frf3bX26=k28uPchzB1F7MH6jjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33866 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbdCGIQV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 03:16:21 -0500
Received: by mail-lf0-f41.google.com with SMTP id k202so83327409lfe.1
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 00:16:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHp75VftVMeCgLBSR0DySG2frf3bX26=k28uPchzB1F7MH6jjw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> On Mon, Mar 6, 2017 at 9:09 AM, Michał Kępień <kernel@kempniu.pl> wrote:
> >> On Thu, Mar 2, 2017 at 2:02 PM, Michał Kępień <kernel@kempniu.pl> wrote:
> 
> >> > + * Since sparse_keymap_setup() now uses a managed allocation for the
> >> > + * keymap copy, use of this function is deprecated.
> >>
> >> So...
> >>
> >> >   */
> >> >  void sparse_keymap_free(struct input_dev *dev)
> >>
> >> ... add __deprecated then?
> >
> > Sure, I can do that if Dmitry recognizes this patch as otherwise sane.
> > I have never used that attribute before, so thanks for the tip.
> 
> It will provoke a warning when compiling the code.
> It makes sense if anyone is going to fix the current users and leave
> old API for one cycle.
> 
> So, the question is what we are going to do with an old API.

If this is a latent call to clean it up, then sure, I can take care of
it ;)  A quick scan shows ca. 30 call sites in the entire tree, fixing
which seems to be doable given a few weeks of time.

Though obviously I would really like to hear that the patch looks sound
before I set out on that journey.

-- 
Best regards,
Michał Kępień
