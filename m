From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] input: gpio_keys_polled: Correct check for invalid gpiod
Date: Fri, 19 Feb 2016 12:39:37 +0200
Message-ID: <20160219103937.GA1770@lahna.fi.intel.com>
References: <1455876273-5913-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455876273-5913-1-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 19, 2016 at 11:04:33AM +0100, Geert Uytterhoeven wrote:
> At this point in gpio_keys_polled_probe(), button->gpiod contains either
> a pointer to a GPIO descriptor or NULL, because:
>   - gpio_keys_polled_get_devtree_pdata() fills in button->gpiod only if
>     devm_get_gpiod_from_child() succeeded,
>   - gpio_to_desc() returns NULL on failure, not an ERR_PTR(),
>   - button->gpiod is untouched if it was NULL, and button->gpio is not
>     valid.
> 
> Hence check for NULL only, and return -EINVAL on failure.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
