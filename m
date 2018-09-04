From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
Date: Tue, 4 Sep 2018 11:53:12 +0200
Message-ID: <CAO-hwJL20efqKS3MP_UttgwgoUxPRW6CaGUDy9=CsqbgHndGWg@mail.gmail.com>
References: <20180831093604.5915-1-benjamin.tissoires@redhat.com> <SN6PR02MB4864D83F3B3FD94CB4741732ED0F0@SN6PR02MB4864.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <SN6PR02MB4864D83F3B3FD94CB4741732ED0F0@SN6PR02MB4864.namprd02.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Terry.Junge@plantronics.com
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Terry,

On Fri, Aug 31, 2018 at 7:48 PM Junge, Terry
<Terry.Junge@plantronics.com> wrote:
>
> For what it's worth the Report Descriptor is a little questionable
> which could be causing the collection to split in two
>
> >-----Original Message-----
> >From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> >owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
> >Sent: Friday, August 31, 2018 2:36 AM
> >To: Jiri Kosina <jikos@kernel.org>; Dmitry Torokhov
> ><dmitry.torokhov@gmail.com>
> >Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin
> >Tissoires <benjamin.tissoires@redhat.com>; stable@vger.kernel.org
> >Subject: [PATCH] Partially revert "HID: generic: create one input report per
> >application type"
> >
> >This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.
> >
> >It looks like some mice are not correctly treated by
> >HID_QUIRK_INPUT_PER_APP. Those mice have the following
> >report descriptor:
> >
> >0x05, 0x01,                    // Usage Page (Generic Desktop)        0
> >0x09, 0x02,                    // Usage (Mouse)                       2
> >0xa1, 0x01,                    // Collection (Application)            4
> >0x85, 0x01,                    //  Report ID (1)                      6
> >0x09, 0x01,                    //  Usage (Pointer)                    8
>
> This physical collection is associated with Generic Desktop:Pointer (0x0001:0x0001)
>
> >0xa1, 0x00,                    //  Collection (Physical)              10
> >0x95, 0x05,                    //   Report Count (5)                  12
> >0x75, 0x01,                    //   Report Size (1)                   14
> >0x05, 0x09,                    //   Usage Page (Button)               16
>
> We are now in the Button page
>
> >0x19, 0x01,                    //   Usage Minimum (1)                 18
> >0x29, 0x05,                    //   Usage Maximum (5)                 20
> >0x15, 0x00,                    //   Logical Minimum (0)               22
> >0x25, 0x01,                    //   Logical Maximum (1)               24
> >0x81, 0x02,                    //   Input (Data,Var,Abs)              26
> >...
> >0xc0,                          //  End Collection                     57
> >0x85, 0x02,                    //  Report ID (2)                      58
> >0x09, 0x01,                    //  Usage (Consumer Control)           60
>
> This physical collection is associated with Button:Button 1 (0x0009:0x0001)
> not Generic Desktop:Pointer (0x0001:0x0001)
>
> >0xa1, 0x00,                    //  Collection (Physical)              62
> >0x75, 0x0c,                    //   Report Size (12)                  64
> >0x95, 0x02,                    //   Report Count (2)                  66
> >0x05, 0x01,                    //   Usage Page (Generic Desktop)      68
>
> Now we're back in the Generic Desktop page

You are missing one bit in the HID specification. The report
descriptor is both a stack and a machine with states. The 'usage page'
can be considered as a 'register' that needs to be associated to the
'usage' to provide the final usage.
For example, Usage Page 0x01 (Generic Desktop) plus Usage 0x30 gives
you the "X" usage.
While Usage Page 0x0d (digitizer) plus the same Usage 0x30 gives you
the "Tip Pressure".

So here, there is nothing wrong.

The stack part concerns the collections. You open a collection type
(physical, or application), and you can close it.

So here, the problem is that the 2 reports with Ids 1 and 2 are part
of the same application collection "mouse" and should be tied to the
same input device (at least that is how I thought of the code).
Unfortunately, the bug makes that these 2 reports each have an input
node, and this is where things start to mess up.

Cheers,
Benjamin

>
> >0x09, 0x30,                    //   Usage (X)                         70
> >0x09, 0x31,                    //   Usage (Y)                         72
> >0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
> >0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
> >0x81, 0x06,                    //   Input (Data,Var,Rel)              80
> >0xc0,                          //  End Collection                     82
> >0xc0,                          // End Collection                      83
> >...
> >
