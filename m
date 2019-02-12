From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2] Input: apanel - switch to using brightness_set_blocking()
Date: Mon, 11 Feb 2019 20:21:21 -0500
Message-ID: <CAGngYiWSTubWWWgm7mY+ux8NronYXekmZBqpGZCh00T4krnuqg@mail.gmail.com>
References: <20190211224729.GA199018@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211224729.GA199018@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 11, 2019 at 5:47 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that LEDs core allows "blocking" flavor of "set brightness" method we
> can use it and get rid of private work item. As a bonus, we are no longer
> forgetting to cancel it when we unbind the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> v2: get rid of led_bits member (Sven)

Looking good !

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
