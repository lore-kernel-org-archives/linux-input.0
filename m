From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sparse-keymap - add managed version of
 sparse_keymap_setup()
Date: Wed, 1 Mar 2017 10:19:16 -0800
Message-ID: <20170301181916.GE30349@dtor-ws>
References: <20170228094525.26683-1-kernel@kempniu.pl>
 <20170228184558.GG20776@dtor-ws>
 <20170301103714.GA973@ozzy.nask.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170301103714.GA973@ozzy.nask.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 01, 2017 at 11:37:14AM +0100, Michał Kępień wrote:
> > On Tue, Feb 28, 2017 at 10:45:25AM +0100, Michał Kępień wrote:
> > > Some platform drivers use devm_input_allocate_device() together with
> > > sparse_keymap_setup() in their .probe callbacks.  While using the former
> > > simplifies error handling, using the latter necessitates calling
> > > sparse_keymap_free() in the error path and upon module unloading to
> > > avoid leaking the copy of the keymap allocated by sparse_keymap_setup().
> > > 
> > > To help prevent such leaks and enable simpler error handling in these
> > > drivers, add a new function which allows automatic freeing of the keymap
> > > copy upon probe failure and on driver detach.
> > > 
> > > As devm_input_allocate_device() adds its devres to the device owning the
> > > input device, we do the same for managed input devices to ensure freeing
> > > the keymap copy is properly slotted in the devres stack.
> > > 
> > > The new function can also be used by non-managed input devices, though
> > > in this case the devres is attached to the struct device embedded inside
> > > the input device itself.
> > 
> > This is wrong and does not work as input devices are never probed and
> > never unbound, so the cleanup will never happen.
> > 
> > Either pass device explicitly, or always take input's parent.
> 
> Thank you for taking a look, Dmitry.  I may be missing something, but
> please bear with me.  AFAICT, in the non-managed input device case the
> devres release callback is called when the last reference to that input
> device is dropped, i.e. after input_unregister_device() is called.
> Setting devres.log=1 confirms this, so does putting a WARN_ON() inside
> devm_sparse_keymap_free().  Could you please elaborate?  Perhaps I am
> misunderstanding your argument.

Ah, I missed the fact that we drop devres resources when we destroy the
device. OK, in this case why don't we make sparse keymap always use
devm-allocated memory and make sparse_keymap_free() a noop for the time
being? Once we remove it from all the drivers we can kill the stub.

Thanks.

-- 
Dmitry
