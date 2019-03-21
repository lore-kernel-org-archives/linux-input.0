From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Thu, 21 Mar 2019 10:55:27 +0200
Message-ID: <CAHp75VeavkzZDYK4CWAC62GciynQ3KYgmPpPRwsd3RcLFw4jxA@mail.gmail.com>
References: <LaQHUFs--3-1@tutanota.com> <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com> <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com> <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dmitry Torokhov <dtor@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 21, 2019 at 6:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
> >>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:

> >> Recently we found that Elan touchpad doesn=E2=80=99t like GpioInt() fr=
om its _CRS.
> >> Once the Interrupt() is used instead, the issue goes away.
> >
> > IIRC i2c core tries to get interrupt from Interrupt() resource and
> > then falls back to GpioInt().
> > See i2c_acpi_get_info() and i2c_device_probe().
>
> Here=E2=80=99s its ASL:

>              Name (SBFB, ResourceTemplate ()
>              {
>                  I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
>                      AddressingMode7Bit, "\\_SB.PCI0.I2C4",
>                      0x00, ResourceConsumer, , Exclusive,
>                      )
>              })
>              Name (SBFG, ResourceTemplate ()
>              {
>                  GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0=
000,
>                      "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                      )
>                      {   // Pin list
>                          0x0012
>                      }
>              })
>              Name (SBFI, ResourceTemplate ()
>              {
>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive=
AndWake, ,, )
>                  {
>                      0x0000003C,
>                  }
>              })

>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource S=
ettings
>              {

>                  If ((OSYS < 0x07DC))
>                  {
>                      Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
>                  }

This will return only Interrupt() resource

>
>                  Return (ConcatenateResTemplate (SBFB, SBFG))

This one I2cSerialBus() and GpioInt().

>              }


>          }
>      }
>
> Change SBFG to SBFI in its _CRS can workaround the issue.
> Is ASL in this form possible to do the flow you described?

Since it's enumerated in Linux as I2C device, it means it gets I2C and
GPIO resources.
So, no, it's not possible.

What are you describing might tell us about one of the following:
- touchpad should be switched to PS/2 mode in order to get working
- GPIO resource is not correct / bug in GPIO driver

I don't believe the first one is a case here.
If GPIO resource is not correct and main OS has some quirks, we need
to do similar in Linux.
Otherwise, debugging GPIO driver, starting from what exactly (pin
number, pin settings, etc) gets i2c-hid module.

Note, ACPICA and related stuff is done in order to be Windows compatible.
If you have settings in BIOS that defines OS to boot, it should be
chosen Windows.

--=20
With Best Regards,
Andy Shevchenko
