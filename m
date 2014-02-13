From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: adp5588: get value from data out when dir is out
Date: Thu, 13 Feb 2014 13:50:00 +0100
Message-ID: <CACRpkdY-LdJLMJpHyVGO=crij80GpZK_NNF-UWcVnqi2kmFydQ@mail.gmail.com>
References: <1392051929-32290-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1392051929-32290-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 10, 2014 at 6:05 PM, Jean-Francois Dagenais
<jeff.dagenais@gmail.com> wrote:

> As discussed here: http://ez.analog.com/message/35852,
> the 5587 revC and 5588 revB spec sheets contain a mistake
> in the GPIO_DAT_STATx register description.
>
> According to R.Shnell at ADI, as well as my own
> observations, it should read:
> "GPIO data status (shows GPIO state when read for inputs)".
>
> This commit changes the get value function accordingly.
>
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

Patch applied with Michael's ACK.

Yours,
Linus Walleij
