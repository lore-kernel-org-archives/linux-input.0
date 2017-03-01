From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH] Input: sparse-keymap - add managed version of
 sparse_keymap_setup()
Date: Wed, 1 Mar 2017 11:37:14 +0100
Message-ID: <20170301103714.GA973@ozzy.nask.waw.pl>
References: <20170228094525.26683-1-kernel@kempniu.pl>
 <20170228184558.GG20776@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35355 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdCAKiJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 05:38:09 -0500
Received: by mail-lf0-f68.google.com with SMTP id z127so3015647lfa.2
        for <linux-input@vger.kernel.org>; Wed, 01 Mar 2017 02:37:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170228184558.GG20776@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> On Tue, Feb 28, 2017 at 10:45:25AM +0100, Michał Kępień wrote:
> > Some platform drivers use devm_input_allocate_device() together with
> > sparse_keymap_setup() in their .probe callbacks.  While using the former
> > simplifies error handling, using the latter necessitates calling
> > sparse_keymap_free() in the error path and upon module unloading to
> > avoid leaking the copy of the keymap allocated by sparse_keymap_setup().
> > 
> > To help prevent such leaks and enable simpler error handling in these
> > drivers, add a new function which allows automatic freeing of the keymap
> > copy upon probe failure and on driver detach.
> > 
> > As devm_input_allocate_device() adds its devres to the device owning the
> > input device, we do the same for managed input devices to ensure freeing
> > the keymap copy is properly slotted in the devres stack.
> > 
> > The new function can also be used by non-managed input devices, though
> > in this case the devres is attached to the struct device embedded inside
> > the input device itself.
> 
> This is wrong and does not work as input devices are never probed and
> never unbound, so the cleanup will never happen.
> 
> Either pass device explicitly, or always take input's parent.

Thank you for taking a look, Dmitry.  I may be missing something, but
please bear with me.  AFAICT, in the non-managed input device case the
devres release callback is called when the last reference to that input
device is dropped, i.e. after input_unregister_device() is called.
Setting devres.log=1 confirms this, so does putting a WARN_ON() inside
devm_sparse_keymap_free().  Could you please elaborate?  Perhaps I am
misunderstanding your argument.

Thanks,

-- 
Best regards,
Michał Kępień
