From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Date: Mon, 28 Jan 2019 11:22:53 -0800
Message-ID: <20190128192253.GD34692@dtor-ws>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws>
 <CAMRc=MfOWWK+nfYLt03EFe-ekTnbDr6oCoqd=n3dpMjz1sELMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MfOWWK+nfYLt03EFe-ekTnbDr6oCoqd=n3dpMjz1sELMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 21, 2019 at 11:52:50AM +0100, Bartosz Golaszewski wrote:
> sob., 19 sty 2019 o 10:03 Dmitry Torokhov <dmitry.torokhov@gmail.com>
> napisał(a):
> >
> > Hi Bartosz,
> >
> > On Fri, Jan 18, 2019 at 02:42:43PM +0100, Bartosz Golaszewski wrote:
> > > +     input_set_capability(onkey->input, EV_KEY, onkey->code);
> > > +
> > > +     rv = devm_request_threaded_irq(dev, irq_f, NULL,
> >
> > Why threaded interrupt with only hard interrupt handler? If parent
> > interrupt is threaded use "any_context_irq" here.
> >
> 
> Hi Dmitry,
> 
> actually it's the other way around. Take a look at the function
> prototype for  devm_request_threaded_irq()[1].
> 
> The third parameter is the hard-irq handler (NULL in my patch), the
> fourth is the thread function. Actually even if I did what you're
> saying - it would never work as this is a nested irq for which the
> hard-irq handler is never called.

Sorry, my eyes must have crossed. Still, from the driver POV the
interrupt does not have to be threaded, this is dictated by the
constraints beyond the driver control. For these cases we have
devm_request_any_context_irq() that takes essentially only "hard" IRQ
handler, but internally either does request_irq() or
request_threaded_irq(), depending on the context (whether the interrupt
is nested or not). Using devm_request_any_context_irq() should not have
any behavioral changes, but documents the logic better.

Thanks.

-- 
Dmitry
