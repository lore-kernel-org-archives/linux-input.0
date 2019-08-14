From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Subject: Re: [PATCH v4 9/9] Input: add IOC3 serio driver
Date: Wed, 14 Aug 2019 16:37:33 +0200
Message-ID: <20190814163733.82f624e342d061866ba8ff87@suse.de>
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
        <20190809103235.16338-10-tbogendoerfer@suse.de>
        <CAOiHx=kuQtOuNfsJ+fDrps+hbrbp5cPujmQpi8Vfy+0qeP8dtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAOiHx=kuQtOuNfsJ+fDrps+hbrbp5cPujmQpi8Vfy+0qeP8dtA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Network Development <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 14 Aug 2019 15:20:14 +0200
Jonas Gorski <jonas.gorski@gmail.com> wrote:

> > +       d = devm_kzalloc(&pdev->dev, sizeof(*d), GFP_KERNEL);
> 
> &pdev->dev => dev

will change.

> 
> > +       if (!d)
> > +               return -ENOMEM;
> > +
> > +       sk = kzalloc(sizeof(*sk), GFP_KERNEL);
> 
> any reason not to devm_kzalloc this as well? Then you won't need to
> manually free it in the error cases.

it has different life time than the device, so it may not allocated
via devm_kzalloc

> > +static int ioc3kbd_remove(struct platform_device *pdev)
> > +{
> > +       struct ioc3kbd_data *d = platform_get_drvdata(pdev);
> > +
> > +       devm_free_irq(&pdev->dev, d->irq, d);
> > +       serio_unregister_port(d->kbd);
> > +       serio_unregister_port(d->aux);
> > +       return 0;
> > +}
> 
> and on that topic, won't you need to kfree d->kbd and d->aux here?

that's done in serio_release_port() by the serio core.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
