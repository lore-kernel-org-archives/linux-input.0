From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/1] of: Pass GPIO label down to gpiod_request when
 using get_gpiod_from_child
Date: Tue, 24 Jan 2017 12:18:05 +0100
Message-ID: <CAMuHMdXUM8dCPwWjXmUP4gefB-_Apw7-LBENxjq7AqimEc+EXQ@mail.gmail.com>
References: <20170112163924.4414-1-alexander.stein@systec-electronic.com> <CACRpkdbbRcKvYuE4_oA2pPQsCpEhb_JbPDyvrcuJvK5y1BD6Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbbRcKvYuE4_oA2pPQsCpEhb_JbPDyvrcuJvK5y1BD6Og@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Linus,

On Tue, Jan 17, 2017 at 4:07 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jan 12, 2017 at 5:39 PM, Alexander Stein
> <alexander.stein@systec-electronic.com> wrote:
>
>> Currently all users of fwnode_get_named_gpiod() have no way to specify a
>> label for the GPIO. So GPIOs listed in debugfs are shown with label "?".
>> With this change a proper label is used.
>> Also adjust all users so they can pass a label, properly retrieved from
>> device tree properties.
>>
>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> ---
>> v2:
>> * Non-RFC
>> * This patch is rebased on gpio/for-next branch and cherry-picked commit
>> 2715bbe from https://bitbucket.org/andy-shev/linux.git
>
> Patch applied on top of Andy's patch.
>
> Let's see if this all builds and works :)

Yes it does, thanks!

-gpio-780 (?): gpiod_set_debounce: missing set() or set_debounce() operations
+gpio-780 (SW30): gpiod_set_debounce: missing set() or set_debounce() operations

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
