From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: qt2160 - switch to using brightness_set_blocking()
Date: Sun, 10 Feb 2019 18:47:11 -0500
Message-ID: <CAGngYiWX5CzRnjZ1O4gMe-Zmc=G90ccLDGS6gwiw-c7ppjgQ0g@mail.gmail.com>
References: <20190209172058.GA24435@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209172058.GA24435@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Feb 9, 2019 at 12:21 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that LEDs core allows "blocking" flavor of "set brightness" method we
> can use it and get rid of private work items.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looking good !

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>

Good job to get rid of that led_lock mutex. It didn't serve any purpose
but more importantly, it could introduce a sleep in brightness_set,
which cannot sleep...
