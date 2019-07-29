From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] drivers: base: swnode: link devices to software nodes
Date: Mon, 29 Jul 2019 11:26:28 +0200
Message-ID: <4416208.J65fGlVMeU@kreacher>
References: <20190713075259.243565-1-dmitry.torokhov@gmail.com> <20190713075259.243565-2-dmitry.torokhov@gmail.com> <CACRpkdZxJZyQD4WZ68hSNGXtGS23hHDv=rrnu9oFmMN0oRNb2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZxJZyQD4WZ68hSNGXtGS23hHDv=rrnu9oFmMN0oRNb2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Linux Input <linux-input@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Monday, July 29, 2019 12:11:41 AM CEST Linus Walleij wrote:
> On Sat, Jul 13, 2019 at 9:53 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > It is helpful to know what device, if any, a software node is tied to, so
> > let's store a pointer to the device in software node structure. Note that
> > children software nodes will inherit their parent's device pointer, so we
> > do not have to traverse hierarchy to see what device the [sub]tree belongs
> > to.
> >
> > We will be using the device pointer to locate GPIO lookup tables for
> > devices with static properties.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If some device core person like Rafael and/or Greg can ACK it I can
> apply this patch to the GPIO tree.

I don't have any concerns regarding this, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the commit when you apply it.

Thanks!
