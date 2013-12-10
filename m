From: "duson" <dusonlin@emc.com.tw>
Subject: RE: [PATCH 1/2] elantech: Properly differentiate between clickpads and normal touchpads
Date: Tue, 10 Dec 2013 16:35:48 +0800
Message-ID: <CF3F8F5F02EE401CBA8F5EFBCC62074D@elan.corp>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com> <CAN+gG=Eh72eBS67db_KNsUzXRNsOUXB8YkzuuHoJca22xRAkdQ@mail.gmail.com> <52A6169C.1020904@redhat.com> <CAN+gG=FgR9cBwJ_GFrU3RAmwma0XWzt8Wdi-HM2zEOOmdPNS+A@mail.gmail.com> <20131210061256.GA12524@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:25838 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3LJIgR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 03:36:17 -0500
In-Reply-To: <20131210061256.GA12524@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>
Cc: 'Hans de Goede' <hdegoede@redhat.com>, 'linux-input' <linux-input@vger.kernel.org>, 'Peter Hutterer' <peter.hutterer@redhat.com>, =?big5?B?J7bApUDEUCc=?= <phoenix@emc.com.tw>

HI Dmitry and Benjamin:

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, December 10, 2013 2:13 PM
> To: Benjamin Tissoires
> Cc: Hans de Goede; linux-input; Peter Hutterer; Duson Lin
> Subject: Re: [PATCH 1/2] elantech: Properly differentiate between
clickpads and
> normal touchpads
> 
> On Mon, Dec 09, 2013 at 02:21:19PM -0500, Benjamin Tissoires wrote:
> > On Mon, Dec 9, 2013 at 2:14 PM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> > > Hi,
> > >
> > >
> > > On 12/09/2013 07:02 PM, Benjamin Tissoires wrote:
> > >>
> > >> Hi Hans,
> > >>
> > >> adding in CC Duson, who seems to be working on the same driver
> > >> currently, and Dmitry, the input maintainer.
> > >>
> > >> On Mon, Dec 9, 2013 at 9:32 AM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> > >>>
> > >>> The current assumption in the elantech driver that hw version 3
touchpads
> > >>> are
> > >>> never clickpads and hw version 4 touchpads are always clickpads is
wrong.
> > >>>
> > >>> There are several bug reports for this, ie:
> > >>> https://bugzilla.redhat.com/show_bug.cgi?id=1030802
> > >>>
> > >>>
>
http://superuser.com/questions/619582/right-elantech-touchpad-button-not-wor
king-
> in-linux
> > >>>
> > >>> I've spend a couple of hours wading through various bugzillas,
> > >>> launchpads and forum posts to create a list of fw-versions and
> > >>> capabilities
> > >>> for different laptop models to find a good method to differentiate
> > >>> between
> > >>> clickpads and versions with separate hardware buttons.
> > >>>
> > >>> Which shows that a device being a clickpad is reliable indicated by
bit
> > >>> 12
> > >>> being set in the fw_version. I've included the gathered list inside
the
> > >>> driver,
> > >>> so that we've this info at hand if we need to revisit this later.
> > >>
> > >>
> > >> Duson, can you confirm this? It's not that I don't trust Hans, but if
> > >> we could have the hardware maker validating this part, this would be
> > >> great.
> > >>
> > >>>
> > >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >>> ---
> > >>>   drivers/input/mouse/elantech.c | 43
> > >>> +++++++++++++++++++++++++++++++++++++++---
> > >>>   1 file changed, 40 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/drivers/input/mouse/elantech.c
> > >>> b/drivers/input/mouse/elantech.c
> > >>> index 8551dca..f7baa32 100644
> > >>> --- a/drivers/input/mouse/elantech.c
> > >>> +++ b/drivers/input/mouse/elantech.c
> > >>> @@ -486,6 +486,7 @@ static void elantech_input_sync_v4(struct
psmouse
> > >>> *psmouse)
> > >>>          unsigned char *packet = psmouse->packet;
> > >>>
> > >>>          input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
> > >>> +       input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
> > >>>          input_mt_report_pointer_emulation(dev, true);
> > >>>          input_sync(dev);
> > >>>   }
> > >>> @@ -984,6 +985,42 @@ static int elantech_get_resolution_v4(struct
> psmouse
> > >>> *psmouse,
> > >>>   }
> > >>>
> > >>>   /*
> > >>> + * Advertise INPUT_PROP_BUTTONPAD for clickpads. The testing of bit
12
> > >>> in
> > >>> + * fw_version for this is based on the following fw_version & caps
> > >>> table:
> > >>> + *
> > >>> + * Laptop-model:           fw_version:     caps:           buttons:
> > >>> + * Acer S3                 0x461f00        10, 13, 0e      clickpad
> > >>> + * Acer S7-392             0x581f01        50, 17, 0d      clickpad
> > >>> + * Acer V5-131             0x461f02        01, 16, 0c      clickpad
> > >>> + * Acer V5-551             0x461f00        ?               clickpad
> > >>> + * Asus K53SV              0x450f01        78, 15, 0c      2 hw
> buttons
> > >>> + * Asus G46VW              0x460f02        00, 18, 0c      2 hw
> buttons
> > >>> + * Asus G750JX             0x360f00        00, 16, 0c      2 hw
> buttons
> > >>> + * Asus UX31               0x361f00        20, 15, 0e      clickpad
> > >>> + * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
> > >>> + * Avatar AVIU-145A2       0x361f00        ?               clickpad
> > >>> + * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw
> buttons
> > >>> + * Lenovo L430             0x350f02        b9, 15, 0c      2 hw
> buttons
> > >>> (*)
> > >>> + * Samsung NF210           0x150b00        78, 14, 0a      2 hw
> buttons
> > >>> + * Samsung NP770Z5E        0x575f01        10, 15, 0f      clickpad
> > >>> + * Samsung NP700Z5B        0x361f06        21, 15, 0f      clickpad
> > >>> + * Samsung NP900X3E-A02    0x575f03        ?
> clickpad
> > >>> + * Samsung NP-QX410        0x851b00        19, 14, 0c      clickpad
> > >>> + * Samsung RC512           0x450f00        08, 15, 0c      2 hw
> buttons
> > >>> + * Samsung RF710           0x450f00        ?               2 hw
> buttons
> > >>> + * System76 Pangolin       0x250f01        ?               2 hw
> buttons
> > >>> + * (*) + 3 trackpoint buttons
> > >>> + */
> > >>> +static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
> > >>> +{
> > >>> +       struct input_dev *dev = psmouse->dev;
> > >>> +       struct elantech_data *etd = psmouse->private;
> > >>> +
> > >>> +       if (etd->fw_version & 0x001000)
> > >>> +               __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> > >>
> > >>
> > >> Small question here: if the touchpad is a clickpad, should'nt we also
> > >> remove the BTN_RIGHT bit too?
> > >
> > >
> > > We could, but I don't see much value in that, and it would also
require
> > > if statements in the sync methods to ensure that we don't tree to send
> > > a button event for a button we don't advertise.
> >
> > We don't need this test in the sync method. The test is already
> > implemented in input_event. So now, it's just a matter of taste
> > regarding upper layers. Peter, any thoughts on this?
> 
> We should not advertise events that device does not generate. This
> should help userspace to decide if emulation is needed or not. Input
> core will drop events that are not set up as valid for device, so if we
> clear BTN_RIGHT there it should all work.

Actually, our touchpad for PS2 protocol implements the left and right click
function, even thought, it is a click-pad. And the flag for left/right click
information is recorded in the first byte of the packet (when doing sync
method).
	Byte0 Bit 0 --> for left click flag
	Byte0 Bit1 --> for right click flag
When user presses the left-bottom area of the click-pad, only the left click
flag will be set to "1". On the other hand, pressing the right-bottom area
of the click-pad, only the right click flag will be set to "1".
So, I think this is the cause of the BTN_RIGHT need to be set.

Thanks,
Duson 

