From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Input: gpio_keys: Add level trigger support for GPIO keys
Date: Sun, 11 Feb 2018 09:54:51 +0800
Message-ID: <CAMz4kuJjLDGrrHyd2xQ1+ojxjtbVoyX=9OA1sB9K9oVqM7D3xg@mail.gmail.com>
References: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
 <CAKdAkRQ6+9=GUJfoMT_gtwS8DqWKeH9FAqPG2BFzL9GPbPNB4w@mail.gmail.com>
 <CAMz4kuKb8g5dAu5WQ847CODtVgJQBa_svbeQGGDsYpCjipBp_g@mail.gmail.com> <CAHp75VcJdYh8fKpqkRXxegRkESaN2Cgxybyei1NVwf_1C7rhwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcJdYh8fKpqkRXxegRkESaN2Cgxybyei1NVwf_1C7rhwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, stephen lu <lumotuwe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kate Stewart <kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 9 February 2018 at 23:03, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Feb 9, 2018 at 11:23 AM, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On 9 February 2018 at 14:39, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On Thu, Feb 8, 2018 at 10:08 PM, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>>>> be triggered by level type.
>>>
>>> How do you stop the interrupt from re-triggering as long as the key
>>> stays pressed?
>>
>> We will set the level type irq handler as handle_level_irq(), in this
>> function, it will mask and ack the irq firstly.
>
> Wouldn't be ambiguous?
>
> 1. User presses the key ->
>   a) we got edge followed by level signaling;
>   b) IRQ core masks line, calls handler, ACKs, unmasks;
>   c) somewhere here Press Event is sent;
>   d) we still have level... We get IRQ fired again? But see 1. It
> obviously not the case.
> 2. User releases the key ->
>   ...
>
> So, the main question if I understood Dmitry correctly is the period
> in time where IRQ line should be masked on one hand, and on the other
> it will guarantee that user didn't release-press cylcle.

Yes, you and Dmitry are right. I realized my problem. When I tested on
Spreadtrum platform, we use Spreadtrum-special EIC (external interrupt
controller) to trigger button events, if we acked the EIC irq, it will
drop the interrupt line and never trigger events until we set irq type
again. But this can not work for general GPIOs like you said.

So I think I need disable the irq until reversing the level type. Thanks.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
