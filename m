From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Wed, 20 Mar 2019 19:18:27 +0200
Message-ID: <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
References: <LaQHUFs--3-1@tutanota.com> <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com> <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dmitry Torokhov <dtor@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
> > On 3/20/19 3:37 PM, Benjamin Tissoires wrote:

> > Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
> > is also used on Elan devices, I suspect that these Elan devices
> > likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
> > and then they probably will no longer need the bogus IRQ flag,
> > if you know about bugreports with an acpidump for any of the devices
> > needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
> > declared there, I suspect it will be declared as level-low, just like
> > with the laptop this patch was written for. And it probably need to
> > be edge-falling instead of level-low just like this case.
>
> First, I=E2=80=99ve already tried using IRQF_TRIGGER_FALLING, unfortunate=
ly it
> doesn=E2=80=99t solve the issue for me.
>
> I talked to Elan once, and they confirm the correct IRQ trigger is level
> low. So forcing falling trigger may break other platforms.

As far as I understood Vladislav the quirk he got from Elan as well.

> Recently we found that Elan touchpad doesn=E2=80=99t like GpioInt() from =
its _CRS.
> Once the Interrupt() is used instead, the issue goes away.

IIRC i2c core tries to get interrupt from Interrupt() resource and
then falls back to GpioInt().
See i2c_acpi_get_info() and i2c_device_probe().

> But I am not sure how to patch its DSDT/SSDT in i2c-hid.

--=20
With Best Regards,
Andy Shevchenko
