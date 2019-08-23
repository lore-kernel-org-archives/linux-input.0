From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/11] Face lift for bu21013_ts driver
Date: Fri, 23 Aug 2019 13:30:22 +0200
Message-ID: <CACRpkdaTK0pybDM6So-E=weE_+uz8TSr=38YNzNQdqjZvnnYXw@mail.gmail.com>
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
 <CACRpkdZo9so+5UoT3QpFmL_8NZT1d1i7Yab202RNn8gDfnPK7A@mail.gmail.com> <20190821174257.GC76194@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821174257.GC76194@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 21, 2019 at 7:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The issue is this:
>
> static void bu21013_disable_chip(void *_ts)
> {
>         struct bu21013_ts *ts = ts;
>
> which shuts up gcc about the fact that 'ts' is uninitialized, it should
> have said "ts = _ts". I guess it is a lesson for me to not call the voi
> d pointer argument almost the same name as the structure, as it is easy
> to miss in the review. The compiler would not care in either case, but a
> human might have noticed.
>
> Can you please try making this change (and the same in power off
> handler)?

Yes this works! :)

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
