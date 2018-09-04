From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
Date: Tue, 4 Sep 2018 15:33:42 +0200
Message-ID: <CAO-hwJ+1FGnP-rG3NJ_NCTSjQqybChYSY54XoEb1HN31Mws=Jw@mail.gmail.com>
References: <20180831093604.5915-1-benjamin.tissoires@redhat.com> <CAO-hwJKxAt95WTrNT6-SfejEpxZvv5aAgoF25SjTxuTmti=ZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKxAt95WTrNT6-SfejEpxZvv5aAgoF25SjTxuTmti=ZUQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 4, 2018 at 1:55 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Fri, Aug 31, 2018 at 11:36 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.
> >
> > It looks like some mice are not correctly treated by
> > HID_QUIRK_INPUT_PER_APP. Those mice have the following
> > report descriptor:
> >
> > 0x05, 0x01,                    // Usage Page (Generic Desktop)        0
> > 0x09, 0x02,                    // Usage (Mouse)                       2
> > 0xa1, 0x01,                    // Collection (Application)            4
> > 0x85, 0x01,                    //  Report ID (1)                      6
> > 0x09, 0x01,                    //  Usage (Pointer)                    8
> > 0xa1, 0x00,                    //  Collection (Physical)              10
> > 0x95, 0x05,                    //   Report Count (5)                  12
> > 0x75, 0x01,                    //   Report Size (1)                   14
> > 0x05, 0x09,                    //   Usage Page (Button)               16
> > 0x19, 0x01,                    //   Usage Minimum (1)                 18
> > 0x29, 0x05,                    //   Usage Maximum (5)                 20
> > 0x15, 0x00,                    //   Logical Minimum (0)               22
> > 0x25, 0x01,                    //   Logical Maximum (1)               24
> > 0x81, 0x02,                    //   Input (Data,Var,Abs)              26
> > ...
> > 0xc0,                          //  End Collection                     57
> > 0x85, 0x02,                    //  Report ID (2)                      58
> > 0x09, 0x01,                    //  Usage (Consumer Control)           60
> > 0xa1, 0x00,                    //  Collection (Physical)              62
> > 0x75, 0x0c,                    //   Report Size (12)                  64
> > 0x95, 0x02,                    //   Report Count (2)                  66
> > 0x05, 0x01,                    //   Usage Page (Generic Desktop)      68
> > 0x09, 0x30,                    //   Usage (X)                         70
> > 0x09, 0x31,                    //   Usage (Y)                         72
> > 0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
> > 0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
> > 0x81, 0x06,                    //   Input (Data,Var,Rel)              80
> > 0xc0,                          //  End Collection                     82
> > 0xc0,                          // End Collection                      83
> > ...
> >
> > Both the cursor position and the buttons are located in the
> > same application collection (Mouse) and the kernel should
> > only create one input device for those.
> >
> > However, for an undetermined reason, the kernel splits the
> > device in 2, making systemd not tagging the second mouse
> > with the coordinates only as a mouse. And then userspace
> > ignores it which leads to a mouse where only the buttons
> > are working.
> >
> > Until the quirk gets properly fixed, we should probably
> > revert applying it to all of the generic devices and
> > re-enable it when the root reason has been found.
>
> Jiri,
>
> I actually just got the proper fix today. I think it would be better
> to directly take the fix instead of the revert and a revert of the
> revert later.
>
> I just need to make sure the tests are correctly handled and I should
> be able to submit the patch today.

Patch now submitted: https://patchwork.kernel.org/patch/10587369/

Cheers,
Benjamin
