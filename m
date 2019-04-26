From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2 2/3] input: keyboard: gpio_keys_polled: use gpio lookup table
Date: Fri, 26 Apr 2019 16:16:19 -0400
Message-ID: <CAGngYiWGpCeJfBQraTidHLDGjNWsUkp0g4HD=0JRUwT8mX8txg@mail.gmail.com>
References: <1556305282-24148-1-git-send-email-info@metux.net> <1556305282-24148-3-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556305282-24148-3-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 26, 2019 at 3:03 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> +static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
> +       struct device *dev,
> +       int idx,
> +       const char *desc)
> +{
> +       struct gpio_desc *gpiod;
> +       struct fwnode_handle *child;
> +       int x;
> +
> +       /* get the idx'th child node */
> +       child = device_get_next_child_node(dev, NULL);
> +       while (child && x) {
> +               child = device_get_next_child_node(dev, child);
> +               x--;
> +       }

x is uninitialized here.
