From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH v2] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Mon, 6 Mar 2017 08:09:00 +0100
Message-ID: <20170306070900.GA1372@ozzy.nask.waw.pl>
References: <20170302120242.6342-1-kernel@kempniu.pl>
 <CAHp75Veewvym2gVXhUSktOxb6=MLMwXXnSoTDEaMhtSa_zL2Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Veewvym2gVXhUSktOxb6=MLMwXXnSoTDEaMhtSa_zL2Kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

> On Thu, Mar 2, 2017 at 2:02 PM, Michał Kępień <kernel@kempniu.pl> wrote:
> > Some platform drivers use devm_input_allocate_device() together with
> > sparse_keymap_setup() in their .probe callbacks.  While using the former
> > simplifies error handling, using the latter necessitates calling
> > sparse_keymap_free() in the error path and upon module unloading to
> > avoid leaking the copy of the keymap allocated by sparse_keymap_setup().
> >
> > To help prevent such leaks and enable simpler error handling, make
> > sparse_keymap_setup() use devm_kcalloc() to allocate memory for the
> > keymap copy so that it gets automatically freed.
> 
> > + * Since sparse_keymap_setup() now uses a managed allocation for the
> > + * keymap copy, use of this function is deprecated.
> 
> So...
> 
> >   */
> >  void sparse_keymap_free(struct input_dev *dev)
> 
> ... add __deprecated then?

Sure, I can do that if Dmitry recognizes this patch as otherwise sane.
I have never used that attribute before, so thanks for the tip.

-- 
Best regards,
Michał Kępień
