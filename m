From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] platform/x86: add support for devices with Silead
 touchscreens
Date: Sun, 22 Jan 2017 14:22:20 -0800
Message-ID: <20170122222220.GB31009@dtor-ws>
References: <20170122152551.10423-1-hdegoede@redhat.com>
 <CAHp75Vcv077rpufZYSr9jpphT9ureJ4t1=9PRNeX_RkcE6Ri9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vcv077rpufZYSr9jpphT9ureJ4t1=9PRNeX_RkcE6Ri9Q@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Jan 22, 2017 at 06:49:11PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 22, 2017 at 5:25 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > On ACPI based tablets, the ACPI touchscreen node only contains info on
> > the gpio and the irq, and is missing any info on the axis. This info is
> > expected to be built into the tablet model specific version of the driver
> > shipped with the os-image for the device.
> >
> > Add support for getting the missing info from a table built into the
> > driver, using dmi data to identify which entry of the table to use and
> > add info for the CUBE iwork8 Air and Jumper EZpad mini3 tablets on which
> > this code was tested / developed.
> >
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=187531
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > [dmitry.torokhov@gmail.com: Move to platform/x86]
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Few nitpicks below. After addressing them
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> (in case Dmitry would like to push this via input subsystem)

Nope ;) There was a reason why I did not want to have it in the driver
proper.

It can go in separately, there are no changes needed in the driver to
make use of these properties.

Thanks.

-- 
Dmitry
