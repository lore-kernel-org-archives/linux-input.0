From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v3 2/3] HID: quirks: Fix keyboard + touchpad on Lenovo
 Miix 630 for DT
Date: Thu, 18 Apr 2019 08:43:02 -0600
Message-ID: <CAOCk7NrSiepivq8qjXJ1eKai3gdUD+uNy3eC6wgjA3ubPzt0RQ@mail.gmail.com>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161108.16419-1-jeffrey.l.hugo@gmail.com> <CAO-hwJKeACBPW52ej6mVeG4aVDYvGF8zEMtegonVwFjT-ZoLOQ@mail.gmail.com>
 <a47672ed-fc25-dd07-0ddf-2deca08283ef@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a47672ed-fc25-dd07-0ddf-2deca08283ef@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <jikos@kernel.org>, Lee Jones <lee.jones@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org, David Brown <david.brown@linaro.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 18, 2019 at 3:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 18-04-19 11:34, Benjamin Tissoires wrote:
> > On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
> >>
> >> Following up on commit 2bafa1e96254 ("HID: quirks: Fix keyboard + touchpad
> >> on Lenovo Miix 630"), the devicetree (DT) identifier for the combo keyboard
> >> + touchpad device is "elan,combo400-i2c", which differs from the ACPI ID,
> >> thus if we want the quirk to work properly when booting via DT instead of
> >> ACPI, we need to key off the DT id as well.
> >>
> >> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> >> ---
> >>   drivers/hid/hid-quirks.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> >> index 77ffba48cc73..00c08f8318b8 100644
> >> --- a/drivers/hid/hid-quirks.c
> >> +++ b/drivers/hid/hid-quirks.c
> >> @@ -997,7 +997,8 @@ bool hid_ignore(struct hid_device *hdev)
> >>                          return true;
> >>                  /* Same with product id 0x0400 */
> >>                  if (hdev->product == 0x0400 &&
> >> -                   strncmp(hdev->name, "QTEC0001", 8) != 0)
> >> +                   (strncmp(hdev->name, "QTEC0001", 8) != 0 ||
> >> +                    strncmp(hdev->name, "elan,combo400-i2c", 17) != 0))
> >
> > I think we are taking the problem the wrong way here.
> >
> > When I first introduced 6ccfe64, I thought 0x0400 would be reserved
> > for the elan_i2c touchpads only. But it turns out we are deliberately
> > disabling valid HID touchpads hoping that they would be picked up by
> > elan_i2c when elan_i2c has its own whitelist of devices.
> >
> > How about we turn this into list with the matching ones from elan_i2c:
> > if ((hdev->product == 0x0400 || hdev->product == 0x0401) &&
> >     (strncmp(hdev->name, "ELAN0000", 8) == 0 ||
> >      strncmp(hdev->name, "ELAN0100", 8) == 0 ||
> >      ...
> >      strncmp(hdev->name, "ELAN1000", 8) == 0))
> >        return true;
> >
> > So next time we need to force binding a HID touchpad to elan_i2c, we
> > can just blacklist here and whitelist it in elan_i2c.
>
> This indeed sounds like a better way forward with this.

This sounds good to me.  Let me implement it and test with the Miix
630.  Thanks for the suggestion.
