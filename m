From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Mon, 6 Mar 2017 09:39:58 +0200
Message-ID: <CAHp75VftVMeCgLBSR0DySG2frf3bX26=k28uPchzB1F7MH6jjw@mail.gmail.com>
References: <20170302120242.6342-1-kernel@kempniu.pl> <CAHp75Veewvym2gVXhUSktOxb6=MLMwXXnSoTDEaMhtSa_zL2Kg@mail.gmail.com>
 <20170306070900.GA1372@ozzy.nask.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34461 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbdCFHkD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Mar 2017 02:40:03 -0500
In-Reply-To: <20170306070900.GA1372@ozzy.nask.waw.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 6, 2017 at 9:09 AM, Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempni=
u.pl> wrote:
>> On Thu, Mar 2, 2017 at 2:02 PM, Micha=C5=82 K=C4=99pie=C5=84 <kernel@kem=
pniu.pl> wrote:

>> > + * Since sparse_keymap_setup() now uses a managed allocation for the
>> > + * keymap copy, use of this function is deprecated.
>>
>> So...
>>
>> >   */
>> >  void sparse_keymap_free(struct input_dev *dev)
>>
>> ... add __deprecated then?
>
> Sure, I can do that if Dmitry recognizes this patch as otherwise sane.
> I have never used that attribute before, so thanks for the tip.

It will provoke a warning when compiling the code.
It makes sense if anyone is going to fix the current users and leave
old API for one cycle.

So, the question is what we are going to do with an old API.

--=20
With Best Regards,
Andy Shevchenko
