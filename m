From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] Input: sparse-keymap - use a managed allocation for
 keymap copy
Date: Wed, 8 Mar 2017 23:47:26 +0200
Message-ID: <CAHp75VdKNnnyu5cJr=uzvimfbwJJyZ+nwBkJzUxu+RitHf1_1Q@mail.gmail.com>
References: <20170308082217.5466-1-kernel@kempniu.pl> <20170308181250.GC20567@dtor-ws>
 <CAHp75VdjQS_D5=gZ5Ei1quqjqyhPADxeT=a832Mb+Sk1kDz0mQ@mail.gmail.com> <20170308210506.GD20567@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170308210506.GD20567@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 8, 2017 at 11:05 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Mar 08, 2017 at 10:50:16PM +0200, Andy Shevchenko wrote:
>> On Wed, Mar 8, 2017 at 8:12 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Wed, Mar 08, 2017 at 09:22:17AM +0100, Micha=C5=82 K=C4=99pie=C5=84=
 wrote:

>> If there PDx86 related patches are anticipated this cycle, definitely
>> we need an immutable branch (perhaps based on v4.11-rc1).
>
> OK, I'll make one (based on 4.10 final - the patch should apply cleanly
> there and there is no point of forcing anyone's workflow to use kernel
> in the beginning of stabilization cycle).

Fine by me.

> As to whether there are PDx86 patches - I hope Micha=C5=82 will supply th=
em
> ;)

Micha=C5=82, whenever you send the first one based on this change, please
mention that it has dependency, I will pull the immutable branch at
that time.

Thanks.

--=20
With Best Regards,
Andy Shevchenko
