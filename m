From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
Date: Wed, 12 Jun 2019 17:21:04 +0200
Message-ID: <CAO-hwJKDxu0Bxxjd9reAojHODQTnW1POmifBCVsnjt8+CT4rmw@mail.gmail.com>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
 <20190606161322.47192-1-jeffrey.l.hugo@gmail.com> <20190612003507.GG143729@dtor-ws>
 <nycvar.YFH.7.76.1906121644160.27227@cbobk.fhfr.pm> <CAKdAkRQOxTX51rhodoFyYpwi85pk8apvWjCLLX5Sw6NTH=j1kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQOxTX51rhodoFyYpwi85pk8apvWjCLLX5Sw6NTH=j1kA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <agross@kernel.org>, David Brown <david.brown@linaro.org>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 12, 2019 at 5:14 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 7:45 AM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Tue, 11 Jun 2019, Dmitry Torokhov wrote:
> >
> > > > +static const char *hid_elan_i2c_ignore[] = {
> > >
> > > If this is a copy of elan whitelist, then, if we do not want to bother
> > > with sharing it in object form (as a elan-i2c-ids module), can we at
> > > least move it into include/linux/input/elan-i2c-ids.h and consume from
> > > hid-quirks.c?
> >
> > Let's just not duplicate it in both objects. Why not properly export it
> > from hid_quirks?
>
> Strictly speaking Elan does not depend on HID; exporting it from
> quirks would mean adding this dependency. This also mean that you
> can't make Elan built-in while keeping HID as a module (I think this
> at least used to be config on some Chromebooks).
>

I also think it would me things cleaner to have the list of devices in elan_i2c.
If we put the list of devices supported by elan_i2c in a header, and
have HID read this .h file directly, there will be no runtime
dependency.

I am sure we can work something out to remove Jeffrey's fears.

Cheers,
Benjamin
