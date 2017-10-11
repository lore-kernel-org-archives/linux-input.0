From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Wed, 11 Oct 2017 10:54:51 +0200
Message-ID: <20171011085451.GG865@mail.corp.redhat.com>
References: <20171010041631.22093-1-wnhuang@google.com>
 <20171010065740.GA22909@mars.bitmath.org>
 <CAE_wzQ_jPP54_1GgEuPZWHjs57=owTTP35ygO6dafYmxgDZYPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757036AbdJKIy6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Oct 2017 04:54:58 -0400
Content-Disposition: inline
In-Reply-To: <CAE_wzQ_jPP54_1GgEuPZWHjs57=owTTP35ygO6dafYmxgDZYPQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Wei-Ning Huang <wnhuang@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

On Oct 10 2017 or thereabouts, Dmitry Torokhov wrote:
> On Mon, Oct 9, 2017 at 11:57 PM, Henrik Rydberg <rydberg@bitmath.org> wrote:
> > Hi Wei-Ning,
> >
> >> The current hid-multitouch driver only allow the report of two
> >> orientations, vertical and horizontal. We use the Azimuth orientation
> >> usage 0x3F under the Digitizer usage page to report orientation if the
> >> device supports it.
> >>
> >> Changelog:
> >>   v1 -> v2:
> >>    - Fix commit message.
> >>    - Remove resolution reporting for ABS_MT_ORIENTATION.
> >>   v2 -> v3:
> >>    - Fix commit message.
> >>   v3 -> v4:
> >>    - Fix ABS_MT_ORIENTATION ABS param range.
> >>    - Don't set ABS_MT_ORIENTATION in ABS_DG_HEIGHT when it is already
> >>      set by ABS_DG_AZIMUTH.
> >>
> >> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> >> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> >> ---
> >>  drivers/hid/hid-multitouch.c | 52 ++++++++++++++++++++++++++++++++++++++++----
> >>  include/linux/hid.h          |  1 +
> >>  2 files changed, 49 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> >> index 440b999304a5..3317dae64ef7 100644
> >> --- a/drivers/hid/hid-multitouch.c
> >> +++ b/drivers/hid/hid-multitouch.c
> >> @@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
> >>  #define MT_IO_FLAGS_PENDING_SLOTS    2
> >>
> >>  struct mt_slot {
> >> -     __s32 x, y, cx, cy, p, w, h;
> >> +     __s32 x, y, cx, cy, p, w, h, a;
> >>       __s32 contactid;        /* the device ContactID assigned to this slot */
> >>       bool touch_state;       /* is the touch valid? */
> >>       bool inrange_state;     /* is the finger in proximity of the sensor? */
> >>       bool confidence_state;  /* is the touch made by a finger? */
> >> +     bool has_azimuth;       /* the contact reports azimuth */
> >>  };
> >>
> >>  struct mt_class {
> >> @@ -571,8 +572,15 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >>                       if (!(cls->quirks & MT_QUIRK_NO_AREA)) {
> >>                               set_abs(hi->input, ABS_MT_TOUCH_MINOR, field,
> >>                                       cls->sn_height);
> >> -                             input_set_abs_params(hi->input,
> >> -                                     ABS_MT_ORIENTATION, 0, 1, 0, 0);
> >> +
> >> +                             /*
> >> +                              * Only set ABS_MT_ORIENTATION if it is not
> >> +                              * already set by the HID_DG_AZIMUTH usage.
> >> +                              */
> >> +                             if (!test_bit(ABS_MT_ORIENTATION,
> >> +                                             hi->input->absbit))
> >> +                                     input_set_abs_params(hi->input,
> >> +                                             ABS_MT_ORIENTATION, 0, 1, 0, 0);
> >>                       }
> >>                       mt_store_field(usage, td, hi);
> >>                       return 1;
> >> @@ -591,6 +599,21 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >>                       td->cc_index = field->index;
> >>                       td->cc_value_index = usage->usage_index;
> >>                       return 1;
> >> +             case HID_DG_AZIMUTH:
> >> +                     hid_map_usage(hi, usage, bit, max,
> >> +                             EV_ABS, ABS_MT_ORIENTATION);
> >> +                     /*
> >> +                      * Azimuth has the range of [0, MAX) representing a full
> >> +                      * revolution. Set ABS_MT_ORIENTATION to a quarter of
> >> +                      * MAX according the definition of ABS_MT_ORIENTATION
> >> +                      */
> >> +                     input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
> >> +                             -field->logical_maximum / 4,
> >> +                             field->logical_maximum / 4,
> 
> 
> So do we expect userspace to have special handling for the range when
> "min" is negative? I.e. when range is [0,1] it is understood that we
> are reporting the first quadrant only, with 0 reported when finger is
> roughly vertical and 1 is when it is horizontal. Similarly, the range
> [0-90] would describe the 1st quadrant as well. This matches the
> in-kernel documentation. However here we have [-90, 90] that describes
> 2 quadrants. Do we want to keep it as is and have userspace adapt (we
> probably will need a patch to multi-touch-protocol.txt), or should

Actually, I requested the [-90, 90] change because the only other user
in the kernel I could find that support ABS_MT_ORIENTATION with a
different range than [0,1] was hid-magicmouse and it was not following
the documentation to the letter:
https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/tree/drivers/hid/hid-magicmouse.c?h=for-next#n411


After a deeper search, we have (reporting ABS_MT_ORIENTATION different
from [0,1]):
drivers/hid/hid-magicmouse.c -> [-32,32]
drivers/input/touchscreen/stmfts.c -> [0,255]
drivers/input/touchscreen/atmel_mxt_ts.c -> [0,255]
drivers/input/mouse/bcm5974.c -> [-16384, 16384]
drivers/input/mouse/cyapa.c -> [-127, 127]
drivers/input/misc/xen-kbdfront.c -> ???? (set_abs_params is not even
                                     called)

So we clearly already have messed up everywhere. I suspect the [0,255]
ranges to be the min/max already reported by the touchscreen.

I am not sure if libinput even uses ABS_MT_ORIENTATION, but I'd go for
fixing the documentation. And re-reading it, it's not clear that the doc
tells us to have [0,90]. It mentions negative values and out of ranges
too, so we might just as well simply clarify that we rather have [-90,90],
with 0 being "north".

Cheers,
Benjamin

> this be:
> 
> input_set_abs_params(hi->input, ABS_MT_ORIENTATION, 0,
> field->logical_maximum / 4, ...);
> 
> and userspace should be able to handle reported negative events and
> have them being understood as going counter-clockwise into the 4th and
> then 3rd quadrant?
> 
> Thanks,
> Dmitry
