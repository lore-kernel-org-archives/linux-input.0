From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] platform/x86: surfacepro3_button: Fix device check
Date: Sat, 27 Jul 2019 15:26:41 +0300
Message-ID: <CAHp75VdsL+-bhAUcxLKFKLZedN3gFD3jxnhELD1RtKGSHdagjw@mail.gmail.com>
References: <20190720150511.95076-1-luzmaximilian@gmail.com>
 <20190720150511.95076-2-luzmaximilian@gmail.com> <CAHp75Ve+3c-TFeN3Dh-DB75Rjft8mY2DA8vNkrFyp7JK-ZOjDA@mail.gmail.com>
 <20190727091541.GD795@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190727091541.GD795@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jul 27, 2019 at 12:15 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Jul 25, 2019 at 08:57:53PM +0300, Andy Shevchenko wrote:
> > On Sat, Jul 20, 2019 at 6:05 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> > >
> > > Do not use the surfacepro3_button driver on newer Microsoft Surface
> > > models, only use it on the Surface Pro 3 and 4. Newer models (5th, 6th
> > > and possibly future generations) use the same device as the Surface Pro
> > > 4 to represent their volume and power buttons (MSHW0040), but their
> > > actual implementation is significantly different. This patch ensures
> > > that the surfacepro3_button driver is only used on the Pro 3 and 4
> > > models, allowing a different driver to bind on other models.
> > >
> >
> > Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > assuming it will go thru Input subsystem.
>
> I can take it, but I do not think it is dependent on the other change
> and thus can go through platform tree as well.

Pkease, take it. I do not expect any changes to the driver this cycle.

-- 
With Best Regards,
Andy Shevchenko
