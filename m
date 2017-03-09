From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH v3] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Thu, 9 Mar 2017 08:58:54 +0100
Message-ID: <20170309075854.GA1620@ozzy.nask.waw.pl>
References: <20170308082217.5466-1-kernel@kempniu.pl>
 <20170308181250.GC20567@dtor-ws>
 <CAHp75VdjQS_D5=gZ5Ei1quqjqyhPADxeT=a832Mb+Sk1kDz0mQ@mail.gmail.com>
 <20170308210506.GD20567@dtor-ws>
 <CAHp75VdKNnnyu5cJr=uzvimfbwJJyZ+nwBkJzUxu+RitHf1_1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdKNnnyu5cJr=uzvimfbwJJyZ+nwBkJzUxu+RitHf1_1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>
List-Id: linux-input@vger.kernel.org

> On Wed, Mar 8, 2017 at 11:05 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Mar 08, 2017 at 10:50:16PM +0200, Andy Shevchenko wrote:
> >> On Wed, Mar 8, 2017 at 8:12 PM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Wed, Mar 08, 2017 at 09:22:17AM +0100, Michał Kępień wrote:
> 
> >> If there PDx86 related patches are anticipated this cycle, definitely
> >> we need an immutable branch (perhaps based on v4.11-rc1).
> >
> > OK, I'll make one (based on 4.10 final - the patch should apply cleanly
> > there and there is no point of forcing anyone's workflow to use kernel
> > in the beginning of stabilization cycle).
> 
> Fine by me.
> 
> > As to whether there are PDx86 patches - I hope Michał will supply them
> > ;)
> 
> Michał, whenever you send the first one based on this change, please
> mention that it has dependency, I will pull the immutable branch at
> that time.

Noted.  I will prepare the patches and submit them within the next few
days.

-- 
Best regards,
Michał Kępień
