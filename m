From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 5 Feb 2019 17:32:44 +0200
Message-ID: <CAHp75Vf-9R=LLQ=AOQ3vA8uoADieOMRh1tpg2hsHTf8imnXofA@mail.gmail.com>
References: <20190204081947.25152-1-ronald@innovation.ch> <20190204081947.25152-3-ronald@innovation.ch>
 <20190205114522.GV9224@smile.fi.intel.com> <20190205131812.GC4225@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205131812.GC4225@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 5, 2019 at 4:21 PM Life is hard, and then you die
<ronald@innovation.ch> wrote:

> > > +config KEYBOARD_APPLESPI
> > > +   tristate "Apple SPI keyboard and trackpad"
> >
> > > +   depends on (X86 && ACPI && SPI) || COMPILE_TEST
> >
> > COMPILE_TEST more or less makes sense in conjunction with architecture selection.
> > It means, your code always dependant to ACPI and SPI frameworks.
> > That's why 0day complained.
>
> Thanks. Yes, looking at this again I realized I somewhat misunderstood
> the uses of COMPILE_TEST. I've changed this now to
>
>         depends on ACPI && SPI && (X86 || COMPILE_TEST)

Better to split like

depends on SPI && ACPI
depends on X86 || COMPILE_TEST

-- 
With Best Regards,
Andy Shevchenko
