From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: cap11xx - switch to using set_brightness_blocking()
Date: Wed, 6 Feb 2019 09:33:53 -0500
Message-ID: <CAGngYiXFYb8DczTL2dbRWx1pUhYhLAqRdVzXbGdG_FLY8pzHLQ@mail.gmail.com>
References: <20190205222050.GA145676@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205222050.GA145676@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 5, 2019 at 5:20 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Updating LED state requires access to regmap and therefore we may sleep, so
> we could not do that directly form set_brightness() method. Historically
> we used private work to adjust the brightness, but with the introduction of
> set_brightness_blocking() we no longer need it.
>

Elegant solution, nice !

I read the patch to verify that the user-after-free is now gone, but
obviously I cannot test,
as I have no cap11xx hardware. For what it's worth:

Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
