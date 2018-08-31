From: "Junge, Terry" <Terry.Junge@plantronics.com>
Subject: RE: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
Date: Fri, 31 Aug 2018 17:47:50 +0000
Message-ID: <SN6PR02MB4864D83F3B3FD94CB4741732ED0F0@SN6PR02MB4864.namprd02.prod.outlook.com>
References: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

For what it's worth the Report Descriptor is a little questionable
which could be causing the collection to split in two

>-----Original Message-----
>From: linux-input-owner@vger.kernel.org [mailto:linux-input-
>owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
>Sent: Friday, August 31, 2018 2:36 AM
>To: Jiri Kosina <jikos@kernel.org>; Dmitry Torokhov
><dmitry.torokhov@gmail.com>
>Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin
>Tissoires <benjamin.tissoires@redhat.com>; stable@vger.kernel.org
>Subject: [PATCH] Partially revert "HID: generic: create one input report p=
er
>application type"
>
>This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.
>
>It looks like some mice are not correctly treated by
>HID_QUIRK_INPUT_PER_APP. Those mice have the following
>report descriptor:
>
>0x05, 0x01,                    // Usage Page (Generic Desktop)        0
>0x09, 0x02,                    // Usage (Mouse)                       2
>0xa1, 0x01,                    // Collection (Application)            4
>0x85, 0x01,                    //  Report ID (1)                      6
>0x09, 0x01,                    //  Usage (Pointer)                    8

This physical collection is associated with Generic Desktop:Pointer (0x0001=
:0x0001)

>0xa1, 0x00,                    //  Collection (Physical)              10
>0x95, 0x05,                    //   Report Count (5)                  12
>0x75, 0x01,                    //   Report Size (1)                   14
>0x05, 0x09,                    //   Usage Page (Button)               16

We are now in the Button page

>0x19, 0x01,                    //   Usage Minimum (1)                 18
>0x29, 0x05,                    //   Usage Maximum (5)                 20
>0x15, 0x00,                    //   Logical Minimum (0)               22
>0x25, 0x01,                    //   Logical Maximum (1)               24
>0x81, 0x02,                    //   Input (Data,Var,Abs)              26
>...
>0xc0,                          //  End Collection                     57
>0x85, 0x02,                    //  Report ID (2)                      58
>0x09, 0x01,                    //  Usage (Consumer Control)           60

This physical collection is associated with Button:Button 1 (0x0009:0x0001)
not Generic Desktop:Pointer (0x0001:0x0001)

>0xa1, 0x00,                    //  Collection (Physical)              62
>0x75, 0x0c,                    //   Report Size (12)                  64
>0x95, 0x02,                    //   Report Count (2)                  66
>0x05, 0x01,                    //   Usage Page (Generic Desktop)      68

Now we're back in the Generic Desktop page

>0x09, 0x30,                    //   Usage (X)                         70
>0x09, 0x31,                    //   Usage (Y)                         72
>0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
>0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
>0x81, 0x06,                    //   Input (Data,Var,Rel)              80
>0xc0,                          //  End Collection                     82
>0xc0,                          // End Collection                      83
>...
>
>Both the cursor position and the buttons are located in the
>same application collection (Mouse) and the kernel should
>only create one input device for those.
>
>However, for an undetermined reason, the kernel splits the
>device in 2, making systemd not tagging the second mouse
>with the coordinates only as a mouse. And then userspace
>ignores it which leads to a mouse where only the buttons
>are working.
>
>Until the quirk gets properly fixed, we should probably
>revert applying it to all of the generic devices and
>re-enable it when the root reason has been found.
>
>link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200847
>link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200849
>link: https://bugs.archlinux.org/task/59699
>link: https://github.com/NixOS/nixpkgs/issues/45165
>
>Cc: stable@vger.kernel.org # v4.18+
>Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>---
> drivers/hid/hid-generic.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
>diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
>index 3b6eccbc2519..c25b4718de44 100644
>--- a/drivers/hid/hid-generic.c
>+++ b/drivers/hid/hid-generic.c
>@@ -56,20 +56,6 @@ static bool hid_generic_match(struct hid_device *hdev,
>        return true;
> }
>
>-static int hid_generic_probe(struct hid_device *hdev,
>-                            const struct hid_device_id *id)
>-{
>-       int ret;
>-
>-       hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
>-
>-       ret =3D hid_parse(hdev);
>-       if (ret)
>-               return ret;
>-
>-       return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>-}
>-
> static const struct hid_device_id hid_table[] =3D {
>        { HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID,
>HID_ANY_ID) },
>        { }
>@@ -80,7 +66,6 @@ static struct hid_driver hid_generic =3D {
>        .name =3D "hid-generic",
>        .id_table =3D hid_table,
>        .match =3D hid_generic_match,
>-       .probe =3D hid_generic_probe,
> };
> module_hid_driver(hid_generic);
>
>--
>2.14.3
>
>________________________________
>NOTE: THIS EMAIL DID NOT COME FROM A PLANTRONICS ASSOCIATE.
>If the sender claims to be a Plantronics associate it may be fraudulent an=
d
>spoofing the associates address. Please report suspicious emails or phishi=
ng
>attempts to:
>phishalarm@Plantronics.com<mailto:phishalarm@Plantronics.com>.
