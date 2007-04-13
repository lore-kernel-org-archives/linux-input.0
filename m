From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] gpio_keys ev_sw support
Date: Fri, 13 Apr 2007 17:24:27 -0400
Message-ID: <d120d5000704131424i51ec9c60y5ffc22130f67b121@mail.gmail.com>
References: <461BC11C.7020401@gmail.com>
	 <d120d5000704101120x4c292ae1w94b281b718a158d1@mail.gmail.com>
	 <461C96F9.5000808@gmail.com> <1417248704.20070414001305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1417248704.20070414001305@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Roman Moravcik <roman.moravcik@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, kernel-discuss@handhelds.org
List-Id: linux-input@vger.kernel.org

Hi Paul,

On 4/13/07, Paul Sokolovsky <pmiscml@gmail.com> wrote:
> Hello Dmitry,
>
>        I wonder if you're satisfied with Roman patch now. I guess it could just fall to the bottom of your queue due to bad formatting. So, here's resend, hopefully correct. One change is that we had to put "type" member to the end of struct gpio_keys_button, the reason is backwards compatibility. As you see, we'd like EV_KEY to be still default, and nay other type to be used only if explicitly specified. And as structure is already big, and there're usually several keys to define, we use positional initialization to save space:
>
>        { KEY_ENTER,    GPIO_NR_H4000_ACTION_BUTTON_N,  1, "Action button"      },
>
> So, putting type after keycode will break this, and moreover compiler issues only warning, so that may go unnoticed.
>

OK.

>
> Thanks,
> Paul
>
>
> -------------
> This patch adds switch event support to gpio_keys driver.
>
> Signed-off-by: Roman Moravcik <roman.moravcik@gmail.com>
> Signed-off-by: Paul Sokolovsky <pmiscml@gmail.com>
>
>
> Index: include/linux/gpio_keys.h
> ===================================================================
> RCS file: /cvs/linux/kernel26/include/linux/gpio_keys.h,v
> retrieving revision 1.1
> diff -u -p -r1.1 gpio_keys.h
> --- include/linux/gpio_keys.h   25 Feb 2007 15:21:52 -0000      1.1
> +++ include/linux/gpio_keys.h   13 Apr 2007 21:07:03 -0000
> @@ -6,6 +6,7 @@ struct gpio_keys_button {
>        int gpio;
>        int active_low;
>        char *desc;
> +       int type;
>  };
>
>  struct gpio_keys_platform_data {
> Index: drivers/input/keyboard/gpio_keys.c
> ===================================================================
> RCS file: /cvs/linux/kernel26/drivers/input/keyboard/gpio_keys.c,v
> retrieving revision 1.15
> diff -u -p -r1.15 gpio_keys.c
> --- drivers/input/keyboard/gpio_keys.c  25 Feb 2007 15:26:10 -0000      1.15
> +++ drivers/input/keyboard/gpio_keys.c  13 Apr 2007 21:07:03 -0000
> @@ -39,7 +39,10 @@ static irqreturn_t gpio_keys_isr(int irq
>                if (irq == gpio_to_irq(gpio)) {
>                        int state = (gpio_get_value(gpio) ? 1 : 0) ^ (pdata->buttons[i].active_low);
>
> -                       input_report_key(input, pdata->buttons[i].keycode, state);
> +                       if (pdata->buttons[i].type == EV_SW)
> +                               input_report_switch(input, pdata->buttons[i].keycode, state);
> +                       else
> +                               input_report_key(input, pdata->buttons[i].keycode, state);
>                        input_sync(input);
>                }
>        }
> @@ -84,7 +87,12 @@ static int __devinit gpio_keys_probe(str
>                                irq, error);
>                        goto fail;
>                }
> -               set_bit(code, input->keybit);
> +               if (pdata->buttons[i].type == EV_SW) {
> +                       input->evbit[0] |= BIT(EV_SW);
> +                       set_bit(code, input->swbit);
> +               } else {
> +                       set_bit(code, input->keybit);
> +               }
>        }

One thing that I was just going to write Roman about is that we need
to set EV_KEY in the same fashion we set EV_SW - conditionally, on a
slim chance there is a keymap with switches only. I will fix it up,
you don't need to resend.

-- 
Dmitry
