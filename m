From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Wed, 8 Mar 2017 13:05:06 -0800
Message-ID: <20170308210506.GD20567@dtor-ws>
References: <20170308082217.5466-1-kernel@kempniu.pl>
 <20170308181250.GC20567@dtor-ws>
 <CAHp75VdjQS_D5=gZ5Ei1quqjqyhPADxeT=a832Mb+Sk1kDz0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdjQS_D5=gZ5Ei1quqjqyhPADxeT=a832Mb+Sk1kDz0mQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 08, 2017 at 10:50:16PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 8, 2017 at 8:12 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Mar 08, 2017 at 09:22:17AM +0100, Michał Kępień wrote:
> >> Some platform drivers use devm_input_allocate_device() together with
> >> sparse_keymap_setup() in their .probe callbacks.  While using the former
> >> simplifies error handling, using the latter necessitates calling
> >> sparse_keymap_free() in the error path and upon module unloading to
> >> avoid leaking the copy of the keymap allocated by sparse_keymap_setup().
> >>
> >> To help prevent such leaks and enable simpler error handling, make
> >> sparse_keymap_setup() use devm_kmemdup() to create the keymap copy so
> >> that it gets automatically freed.
> >>
> >> This works for both managed and non-managed input devices as the keymap
> >> is freed after the last reference to the input device is dropped.
> >>
> >> Note that actions previously taken by sparse_keymap_free(), i.e. taking
> >> the input device's mutex and zeroing its keycode and keycodemax fields,
> >> are now redundant because the managed keymap will always be freed after
> >> the input device is unregistered.
> 
> > OK, I think this looks good. Do platform folks want an immutable branch
> > off 4.10 with this change so we can start cleaning sparse_keymap_free()
> > users in this cycle?
> 
> If there PDx86 related patches are anticipated this cycle, definitely
> we need an immutable branch (perhaps based on v4.11-rc1).

OK, I'll make one (based on 4.10 final - the patch should apply cleanly
there and there is no point of forcing anyone's workflow to use kernel
in the beginning of stabilization cycle).

As to whether there are PDx86 patches - I hope Michał will supply them
;) I'll take care of the 2 instances in drivers/input/misc.

Thanks.

-- 
Dmitry
