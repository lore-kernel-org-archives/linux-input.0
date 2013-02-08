From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Fri, 08 Feb 2013 22:51:51 +0000
Message-ID: <20130208225151.4BF8C3E2C27@localhost>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130108094134.GA21994@gmail.com> <201301081044.14876.marex@denx.de>
 <201301081048.38149.marex@denx.de>
 <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
 <20130108111104.GF21994@gmail.com>
 <CAKohpomiS+UFzgiJaQbm8aZVPY0jeYhm1k7Yndk50z8=K4LvGQ@mail.gmail.com>
 <CACRpkdZWi4M3HmO_rq1O9aGTKYR0iMLXJo+nos3hYu3C_DFRHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZWi4M3HmO_rq1O9aGTKYR0iMLXJo+nos3hYu3C_DFRHQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, vipul kumar samar <vipulkumar.samar@st.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 10 Jan 2013 12:42:53 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 8, 2013 at 12:14 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 8 January 2013 16:41, Lee Jones <lee.jones@linaro.org> wrote:
> >>> Hmm.. I tried a bit, but couldn't find any such call :(
> >>> Probably an assumption is taken here. GPIO pins which are going to be used as
> >>> interrupt lines, wouldn't be getting set in output mode at all. So,
> >>> once they are put
> >>> in input mode in beginning, nobody would change it ever.
> >>>
> >>> Much of gpio controllers configure gpio pins in input mode in their probe().
> >>>
> >>> Maybe, there is something else :)
> >>
> >> Pinctrl?
> >
> > I don't think pinctrl is playing with it. I searched for
> > "direction_input" string and
> > pinctrl routine also had similar name. I couldn't fine use of
> > direction_input anywhere
> > in kernel, for setting them as irqs for OF cases.
> 
> pinctrl has pinctrl_gpio_direction_input() and
> pinctrl_gpio_direction_output() which are supposed to
> be called *only* by GPIOlib frontends using pinctrl
> as backend to control the pins.
> 
> But if it's a pinctrl driver using standard pinconfig from
> include/linux/pinctrl/pinconf-generic.h
> I'm all for adding a PIN_CONFIG_INPUT_ENABLE
> to these definintions so it can be set up as input
> at boot from the device tree using hogs or something,
> that make things easy when using GPIOs as IRQ
> providers only.
> 
> So the alternative is to just set up the IRQ using the
> gpiolib functions for this: of_get_gpio() if you need the
> number from DT, then gpio_request() and
> gpio_direction_input() as on any GPIO. This can be
> done in the device driver or board code depending
> on use case.
> 
> In the Nomadik I did this (maybe ugly) hack for a
> similar case:
> 
> +/*
> + * The SMSC911x IRQ is connected to a GPIO pin, but the driver expects
> + * to simply request an IRQ passed as a resource. So the GPIO pin needs
> + * to be requested by this hog and set as input.
> + */
> +static int __init cpu8815_eth_init(void)
> +{
> +       struct device_node *eth;
> +       int gpio, irq, err;
> +
> +       eth = of_find_node_by_path("/external-bus@34000000/ethernet@300");
> +       if (!eth) {
> +               pr_info("could not find any ethernet controller\n");
> +               return 0;
> +       }
> +       gpio = of_get_gpio(eth, 0);
> +       err = gpio_request(gpio, "eth_irq");
> +       if (err) {
> +               pr_info("failed to request ethernet GPIO\n");
> +               return -ENODEV;
> +       }
> +       err = gpio_direction_input(gpio);
> +       if (err) {
> +               pr_info("failed to set ehernet GPIO as input\n");
> +               return -ENODEV;
> +       }
> +       irq = gpio_to_irq(gpio);
> +       pr_info("enabled ethernet GPIO %d, IRQ %d\n", gpio, irq);
> +       return 0;
> +}
> +device_initcall(cpu8815_eth_init);
> 
> I haven't read review comments on that patch.
> 
> Maybe it's not such a good idea to add the GPIO to the device itself
> when it's being hogged by board code like this. It's a bit of a grey area
> so I'm a bit confused here.
> 
> Maybe the GPIO lib actually needs a "hog" mechanism that can
> request and set GPIO pins as input/output on boot and then
> forget about them.

That would be reasonable. Probably as properties in the gpio controller
node that specify how to set the inital state.

g.
