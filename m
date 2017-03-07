From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Tue, 7 Mar 2017 10:06:51 -0800
Message-ID: <20170307180651.GE13740@dtor-ws>
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
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 04, 2017 at 07:58:51PM +0200, Andy Shevchenko wrote:
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

__deprectaed annoys innocent bystanders who just want to compile their
kernels; we can simply make sure we will not add new users and clean up
old ones in the next release or 2.

Thanks.

-- 
Dmitry
