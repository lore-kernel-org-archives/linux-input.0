From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Sat, 4 Mar 2017 19:58:51 +0200
Message-ID: <CAHp75Veewvym2gVXhUSktOxb6=MLMwXXnSoTDEaMhtSa_zL2Kg@mail.gmail.com>
References: <20170302120242.6342-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34573 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdCDR6x (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Mar 2017 12:58:53 -0500
In-Reply-To: <20170302120242.6342-1-kernel@kempniu.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Mar 2, 2017 at 2:02 PM, Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempni=
u.pl> wrote:
> Some platform drivers use devm_input_allocate_device() together with
> sparse_keymap_setup() in their .probe callbacks.  While using the former
> simplifies error handling, using the latter necessitates calling
> sparse_keymap_free() in the error path and upon module unloading to
> avoid leaking the copy of the keymap allocated by sparse_keymap_setup().
>
> To help prevent such leaks and enable simpler error handling, make
> sparse_keymap_setup() use devm_kcalloc() to allocate memory for the
> keymap copy so that it gets automatically freed.

> + * Since sparse_keymap_setup() now uses a managed allocation for the
> + * keymap copy, use of this function is deprecated.

So...

>   */
>  void sparse_keymap_free(struct input_dev *dev)

... add __deprecated then?

>  {

>  }
>  EXPORT_SYMBOL(sparse_keymap_free);

--=20
With Best Regards,
Andy Shevchenko
