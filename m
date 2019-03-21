From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Thu, 21 Mar 2019 11:48:21 +0200
Message-ID: <CAHp75VdTMn_v8ag11jo6aYtuiWL4bhvSzCnhaUBtuqSQxxnT_w@mail.gmail.com>
References: <LaQHUFs--3-1@tutanota.com> <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com> <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com> <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Mario Limonciello <mario.limonciello@dell.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dmitry Torokhov <dtor@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

+Cc: Mario

Mario, do you have any insights about the issue with touchpad on Dell
system described below?

On Thu, Mar 21, 2019 at 6:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
> >>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
> >
> >>> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
> >>> is also used on Elan devices, I suspect that these Elan devices
> >>> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
> >>> and then they probably will no longer need the bogus IRQ flag,
> >>> if you know about bugreports with an acpidump for any of the devices
> >>> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
> >>> declared there, I suspect it will be declared as level-low, just like
> >>> with the laptop this patch was written for. And it probably need to
> >>> be edge-falling instead of level-low just like this case.
> >>
> >> First, I=E2=80=99ve already tried using IRQF_TRIGGER_FALLING, unfortun=
ately it
> >> doesn=E2=80=99t solve the issue for me.
> >>
> >> I talked to Elan once, and they confirm the correct IRQ trigger is lev=
el
> >> low. So forcing falling trigger may break other platforms.
> >
> > As far as I understood Vladislav the quirk he got from Elan as well.
>
> Ok, then this is really weird.
>
> >
> >> Recently we found that Elan touchpad doesn=E2=80=99t like GpioInt() fr=
om its _CRS.
> >> Once the Interrupt() is used instead, the issue goes away.
> >
> > IIRC i2c core tries to get interrupt from Interrupt() resource and
> > then falls back to GpioInt().
> > See i2c_acpi_get_info() and i2c_device_probe().
>
> Here=E2=80=99s its ASL:
>
>      Scope (\_SB.PCI0.I2C4)
>      {
>          Device (TPD0)
>          {
>              Name (_ADR, One)  // _ADR: Address
>              Name (_HID, "DELL08AE")  // _HID: Hardware ID
>              Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  =
// _CID: Compatible ID
>              Name (_UID, One)  // _UID: Unique ID
>              Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
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
>              Method (_INI, 0, NotSerialized)  // _INI: Initialize
>              {
>              }
>              Method (_STA, 0, NotSerialized)  // _STA: Status
>              {
>                  If ((TCPD =3D=3D One))
>                  {
>                      Return (0x0F)
>                  }
>
>                  Return (Zero)
>              }
>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource S=
ettings
>              {
>                  If ((OSYS < 0x07DC))
>                  {
>                      Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
>                  }
>
>                  Return (ConcatenateResTemplate (SBFB, SBFG))
>              }
>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Me=
thod
>              {
>                  If ((Arg0 =3D=3D ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d=
8938de") /* HID I2C Device */))
>                  {
>                      If ((Arg2 =3D=3D Zero))
>                      {
>                          If ((Arg1 =3D=3D One))
>                          {
>                              Return (Buffer (One)
>                              {
>                                   0x03                                   =
          // .
>                              })
>                          }
>                          Else
>                          {
>                              Return (Buffer (One)
>                              {
>                                   0x00                                   =
          // .
>                              })
>                          }
>                      }
>                      ElseIf ((Arg2 =3D=3D One))
>                      {
>                          Return (0x20)
>                      }
>                      Else
>                      {
>                          Return (Buffer (One)
>                          {
>                               0x00                                       =
      // .
>                          })
>                      }
>                  }
>                  ElseIf ((Arg0 =3D=3D ToUUID ("ef87eb82-f951-46da-84ec-14=
871ac6f84b")))
>                  {
>                      If ((Arg2 =3D=3D Zero))
>                      {
>                          If ((Arg1 =3D=3D One))
>                          {
>                              Return (Buffer (One)
>                              {
>                                   0x03                                   =
          // .
>                              })
>                          }
>                      }
>
>                      If ((Arg2 =3D=3D One))
>                      {
>                          Return (ConcatenateResTemplate (SBFB, SBFG))
>                      }
>
>                      Return (Buffer (One)
>                      {
>                           0x00                                           =
  // .
>                      })
>                  }
>                  }
>                  Else
>                  {
>                      Return (Buffer (One)
>                      {
>                           0x00                                           =
  // .
>                      })
>                  }
>              }
>          }
>      }
>
> Change SBFG to SBFI in its _CRS can workaround the issue.
> Is ASL in this form possible to do the flow you described?
>
> Kai-Heng
>
> >
> >> But I am not sure how to patch its DSDT/SSDT in i2c-hid.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
>


--=20
With Best Regards,
Andy Shevchenko
