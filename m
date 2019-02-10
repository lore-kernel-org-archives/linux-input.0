From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: apanel - switch to using brightness_set_blocking()
Date: Sun, 10 Feb 2019 18:21:27 -0500
Message-ID: <CAGngYiVjAX50R5HPnqqkxvWvbABWWnQ-3r3GAoiW=mb+OEUaqw@mail.gmail.com>
References: <20190209171925.GA24193@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190209171925.GA24193@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Sat, Feb 9, 2019 at 12:19 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that LEDs core allows "blocking" flavor of "set brightness" method we
> can use it and get rid of private work item. As a bonus, we are no longer
> forgetting to cancel it when we unbind the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is the blocking set_brightness callback after applying the patch :
(it's not immediately obvious when looking at only the patch)

struct apanel {
...
        u16    led_bits;
...
};

static int mail_led_set(struct led_classdev *led,
             enum led_brightness value)
{
    struct apanel *ap = container_of(led, struct apanel, mail_led);

    if (value != LED_OFF)
        ap->led_bits |= 0x8000;
    else
        ap->led_bits &= ~0x8000;

    return i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
}

ap->led_bits was previously used as a 'mailslot' between the
set_brightness callback and the deferred work, right?

After the patch, it's used only in this function. Maybe it could be
replaced by a local variable? As a bonus, that would make
the driver's private struct slightly smaller.
