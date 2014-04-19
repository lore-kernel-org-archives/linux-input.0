From: Ping Cheng <pinglinux@gmail.com>
Subject: Fwd: [PATCH 1/4] Input: wacom: Use full 32-bit HID Usage value in
 switch statement
Date: Fri, 18 Apr 2014 17:31:34 -0700
Message-ID: <CAF8JNhKQqKriDy7uOCOrxExmBq6f5fQ=+KatCJ1HepPydd_hEw@mail.gmail.com>
References: <CAF8JNhKamRE0E_hXpWdHrK3REBe-nT7pzxt1nTEz_rt=TgHwRQ@mail.gmail.com>
	<CAF8JNhJxhZkR+7QooNJgab0_SSVm6dRCe96yvNhbOunnkSWHYA@mail.gmail.com>
	<CAF8JNhKuqi_=971iz0kKPmyQy6Zgus6RwNMcbGOgf0EmYqjXmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:40903 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaDSAbf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2014 20:31:35 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so1792018lab.32
        for <linux-input@vger.kernel.org>; Fri, 18 Apr 2014 17:31:34 -0700 (PDT)
In-Reply-To: <CAF8JNhKuqi_=971iz0kKPmyQy6Zgus6RwNMcbGOgf0EmYqjXmQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi Dmitry,

I believe you have valid reasons for holding patches these days. If
you are just overwhelmed by the workload, you should ask for help.
Jiri, Benjamin, and a few others in the list should have the
experience, knowledge, and kindness to help you out.

Wish I can do something to help too.

Ping

On Fri, Apr 11, 2014 at 2:23 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Dmitry,
>
> This patchset has been outstanding for more than 2 months. Can you merge
> them upstream?
>
> Thank you.
>
> Ping
>
>
> On Tue, Mar 4, 2014 at 1:10 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>>
>> Hi Dmitry,
>>
>> This patchset has been Tested-by: Aaron Skomra
>> <Aaron.Skomra@wacom.com> and Reviewed-by: Carl Worth
>> <cworth@cworth.org>. I think they are ready to go upstream.
>>
>> Do you have other comments?
>>
>> Ping
>>
>> On Thu, Feb 27, 2014 at 10:37 AM, Aaron Armstrong Skomra
>> <skomra@gmail.com> wrote:
>> > On Thu, Jan 30, 2014 at 10:48 AM, Jason Gerecke <killertofu@gmail.com>
>> > wrote:
>> >>
>> >> A HID Usage is a 32-bit value: an upper 16-bit "page" and a lower
>> >> 16-bit ID. While the two halves are normally reported seperately,
>> >> only the combination uniquely idenfifes a particular HID Usage.
>> >>
>> >> The existing code performs the comparison in two steps, first
>> >> performing a switch on the ID and then verifying the page within
>> >> each case. While this works fine, it is very akward to handle
>> >> two Usages that share a single ID, such as HID_USAGE_PRESSURE
>> >> and HID_USAGE_X because the case statement can only have a
>> >> single identifier.
>> >>
>> >> To work around this, we now check the full 32-bit HID Usage
>> >> directly rather than first checking the ID and then the page.
>> >> This allows the switch statement to have distinct cases for
>> >> e.g. HID_USAGE_PRESSURE and HID_USAGE_X.
>> >>
>> >> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>> >> ---
>> >>  drivers/input/tablet/wacom_sys.c | 237
>> >> ++++++++++++++++++---------------------
>> >>  1 file changed, 109 insertions(+), 128 deletions(-)
>> >>
>> >> diff --git a/drivers/input/tablet/wacom_sys.c
>> >> b/drivers/input/tablet/wacom_sys.c
>> >> index b16ebef..5be6177 100644
>> >> --- a/drivers/input/tablet/wacom_sys.c
>> >> +++ b/drivers/input/tablet/wacom_sys.c
>> >> @@ -22,23 +22,17 @@
>> >>  #define HID_USAGE_PAGE_DIGITIZER       0x0d
>> >>  #define HID_USAGE_PAGE_DESKTOP         0x01
>> >>  #define HID_USAGE                      0x09
>> >> -#define HID_USAGE_X                    0x30
>> >> -#define HID_USAGE_Y                    0x31
>> >> -#define HID_USAGE_X_TILT               0x3d
>> >> -#define HID_USAGE_Y_TILT               0x3e
>> >> -#define HID_USAGE_FINGER               0x22
>> >> -#define HID_USAGE_STYLUS               0x20
>> >> -#define HID_USAGE_CONTACTMAX           0x55
>> >> +#define HID_USAGE_X                    ((HID_USAGE_PAGE_DESKTOP << 16)
>> >> | 0x30)
>> >> +#define HID_USAGE_Y                    ((HID_USAGE_PAGE_DESKTOP << 16)
>> >> | 0x31)
>> >> +#define HID_USAGE_X_TILT               ((HID_USAGE_PAGE_DIGITIZER <<
>> >> 16) | 0x3d)
>> >> +#define HID_USAGE_Y_TILT               ((HID_USAGE_PAGE_DIGITIZER <<
>> >> 16) | 0x3e)
>> >> +#define HID_USAGE_FINGER               ((HID_USAGE_PAGE_DIGITIZER <<
>> >> 16) | 0x22)
>> >> +#define HID_USAGE_STYLUS               ((HID_USAGE_PAGE_DIGITIZER <<
>> >> 16) | 0x20)
>> >> +#define HID_USAGE_CONTACTMAX           ((HID_USAGE_PAGE_DIGITIZER <<
>> >> 16) | 0x55)
>> >>  #define HID_COLLECTION                 0xa1
>> >>  #define HID_COLLECTION_LOGICAL         0x02
>> >>  #define HID_COLLECTION_END             0xc0
>> >>
>> >> -enum {
>> >> -       WCM_UNDEFINED = 0,
>> >> -       WCM_DESKTOP,
>> >> -       WCM_DIGITIZER,
>> >> -};
>> >> -
>> >>  struct hid_descriptor {
>> >>         struct usb_descriptor_header header;
>> >>         __le16   bcdHID;
>> >> @@ -305,7 +299,7 @@ static int wacom_parse_hid(struct usb_interface
>> >> *intf,
>> >>         char limit = 0;
>> >>         /* result has to be defined as int for some devices */
>> >>         int result = 0, touch_max = 0;
>> >> -       int i = 0, usage = WCM_UNDEFINED, finger = 0, pen = 0;
>> >> +       int i = 0, page = 0, finger = 0, pen = 0;
>> >>         unsigned char *report;
>> >>
>> >>         report = kzalloc(hid_desc->wDescriptorLength, GFP_KERNEL);
>> >> @@ -332,134 +326,121 @@ static int wacom_parse_hid(struct usb_interface
>> >> *intf,
>> >>
>> >>                 switch (report[i]) {
>> >>                 case HID_USAGE_PAGE:
>> >> -                       switch (report[i + 1]) {
>> >> -                       case HID_USAGE_PAGE_DIGITIZER:
>> >> -                               usage = WCM_DIGITIZER;
>> >> -                               i++;
>> >> -                               break;
>> >> -
>> >> -                       case HID_USAGE_PAGE_DESKTOP:
>> >> -                               usage = WCM_DESKTOP;
>> >> -                               i++;
>> >> -                               break;
>> >> -                       }
>> >> +                       page = report[i + 1];
>> >> +                       i++;
>> >>                         break;
>> >>
>> >>                 case HID_USAGE:
>> >> -                       switch (report[i + 1]) {
>> >> +                       switch (page << 16 | report[i + 1]) {
>> >>                         case HID_USAGE_X:
>> >> -                               if (usage == WCM_DESKTOP) {
>> >> -                                       if (finger) {
>> >> -                                               features->device_type =
>> >> BTN_TOOL_FINGER;
>> >> -                                               /* touch device at
>> >> least supports one touch point */
>> >> -                                               touch_max = 1;
>> >> -                                               switch (features->type)
>> >> {
>> >> -                                               case TABLETPC2FG:
>> >> -
>> >> features->pktlen = WACOM_PKGLEN_TPC2FG;
>> >> -                                                       break;
>> >> -
>> >> -                                               case MTSCREEN:
>> >> -                                               case WACOM_24HDT:
>> >> -
>> >> features->pktlen = WACOM_PKGLEN_MTOUCH;
>> >> -                                                       break;
>> >> -
>> >> -                                               case MTTPC:
>> >> -
>> >> features->pktlen = WACOM_PKGLEN_MTTPC;
>> >> -                                                       break;
>> >> -
>> >> -                                               case BAMBOO_PT:
>> >> -
>> >> features->pktlen = WACOM_PKGLEN_BBTOUCH;
>> >> -                                                       break;
>> >> -
>> >> -                                               default:
>> >> -
>> >> features->pktlen = WACOM_PKGLEN_GRAPHIRE;
>> >> -                                                       break;
>> >> -                                               }
>> >> -
>> >> -                                               switch (features->type)
>> >> {
>> >> -                                               case BAMBOO_PT:
>> >> -                                                       features->x_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 5]);
>> >> -                                                       features->x_max
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 8]);
>> >> -                                                       i += 15;
>> >> -                                                       break;
>> >> -
>> >> -                                               case WACOM_24HDT:
>> >> -                                                       features->x_max
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                                       features->x_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 8]);
>> >> -                                                       features->unit
>> >> = report[i - 1];
>> >> -
>> >> features->unitExpo = report[i - 3];
>> >> -                                                       i += 12;
>> >> -                                                       break;
>> >> -
>> >> -                                               default:
>> >> -                                                       features->x_max
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                                       features->x_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 6]);
>> >> -                                                       features->unit
>> >> = report[i + 9];
>> >> -
>> >> features->unitExpo = report[i + 11];
>> >> -                                                       i += 12;
>> >> -                                                       break;
>> >> -                                               }
>> >> -                                       } else if (pen) {
>> >> -                                               /* penabled only
>> >> accepts exact bytes of data */
>> >> -                                               if (features->type >=
>> >> TABLETPC)
>> >> -
>> >> features->pktlen = WACOM_PKGLEN_GRAPHIRE;
>> >> -                                               features->device_type =
>> >> BTN_TOOL_PEN;
>> >> +                               if (finger) {
>> >> +                                       features->device_type =
>> >> BTN_TOOL_FINGER;
>> >> +                                       /* touch device at least
>> >> supports one touch point */
>> >> +                                       touch_max = 1;
>> >> +                                       switch (features->type) {
>> >> +                                       case TABLETPC2FG:
>> >> +                                               features->pktlen =
>> >> WACOM_PKGLEN_TPC2FG;
>> >> +                                               break;
>> >> +
>> >> +                                       case MTSCREEN:
>> >> +                                       case WACOM_24HDT:
>> >> +                                               features->pktlen =
>> >> WACOM_PKGLEN_MTOUCH;
>> >> +                                               break;
>> >> +
>> >> +                                       case MTTPC:
>> >> +                                               features->pktlen =
>> >> WACOM_PKGLEN_MTTPC;
>> >> +                                               break;
>> >> +
>> >> +                                       case BAMBOO_PT:
>> >> +                                               features->pktlen =
>> >> WACOM_PKGLEN_BBTOUCH;
>> >> +                                               break;
>> >> +
>> >> +                                       default:
>> >> +                                               features->pktlen =
>> >> WACOM_PKGLEN_GRAPHIRE;
>> >> +                                               break;
>> >> +                                       }
>> >> +
>> >> +                                       switch (features->type) {
>> >> +                                       case BAMBOO_PT:
>> >> +                                               features->x_phy =
>> >> +
>> >> get_unaligned_le16(&report[i + 5]);
>> >> +                                               features->x_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 8]);
>> >> +                                               i += 15;
>> >> +                                               break;
>> >> +
>> >> +                                       case WACOM_24HDT:
>> >>                                                 features->x_max =
>> >>
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                               i += 4;
>> >> +                                               features->x_phy =
>> >> +
>> >> get_unaligned_le16(&report[i + 8]);
>> >> +                                               features->unit =
>> >> report[i - 1];
>> >> +                                               features->unitExpo =
>> >> report[i - 3];
>> >> +                                               i += 12;
>> >> +                                               break;
>> >> +
>> >> +                                       default:
>> >> +                                               features->x_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 3]);
>> >> +                                               features->x_phy =
>> >> +
>> >> get_unaligned_le16(&report[i + 6]);
>> >> +                                               features->unit =
>> >> report[i + 9];
>> >> +                                               features->unitExpo =
>> >> report[i + 11];
>> >> +                                               i += 12;
>> >> +                                               break;
>> >>                                         }
>> >> +                               } else if (pen) {
>> >> +                                       /* penabled only accepts exact
>> >> bytes of data */
>> >> +                                       if (features->type >= TABLETPC)
>> >> +                                               features->pktlen =
>> >> WACOM_PKGLEN_GRAPHIRE;
>> >> +                                       features->device_type =
>> >> BTN_TOOL_PEN;
>> >> +                                       features->x_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 3]);
>> >> +                                       i += 4;
>> >>                                 }
>> >>                                 break;
>> >>
>> >>                         case HID_USAGE_Y:
>> >> -                               if (usage == WCM_DESKTOP) {
>> >> -                                       if (finger) {
>> >> -                                               switch (features->type)
>> >> {
>> >> -                                               case TABLETPC2FG:
>> >> -                                               case MTSCREEN:
>> >> -                                               case MTTPC:
>> >> -                                                       features->y_max
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                                       features->y_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 6]);
>> >> -                                                       i += 7;
>> >> -                                                       break;
>> >> -
>> >> -                                               case WACOM_24HDT:
>> >> -                                                       features->y_max
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                                       features->y_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i - 2]);
>> >> -                                                       i += 7;
>> >> -                                                       break;
>> >> -
>> >> -                                               case BAMBOO_PT:
>> >> -                                                       features->y_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                                       features->y_max
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 6]);
>> >> -                                                       i += 12;
>> >> -                                                       break;
>> >> -
>> >> -                                               default:
>> >> -                                                       features->y_max
>> >> =
>> >> -
>> >> features->x_max;
>> >> -                                                       features->y_phy
>> >> =
>> >> -
>> >> get_unaligned_le16(&report[i + 3]);
>> >> -                                                       i += 4;
>> >> -                                                       break;
>> >> -                                               }
>> >> -                                       } else if (pen) {
>> >> +                               if (finger) {
>> >> +                                       switch (features->type) {
>> >> +                                       case TABLETPC2FG:
>> >> +                                       case MTSCREEN:
>> >> +                                       case MTTPC:
>> >> +                                               features->y_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 3]);
>> >> +                                               features->y_phy =
>> >> +
>> >> get_unaligned_le16(&report[i + 6]);
>> >> +                                               i += 7;
>> >> +                                               break;
>> >> +
>> >> +                                       case WACOM_24HDT:
>> >> +                                               features->y_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 3]);
>> >> +                                               features->y_phy =
>> >> +
>> >> get_unaligned_le16(&report[i - 2]);
>> >> +                                               i += 7;
>> >> +                                               break;
>> >> +
>> >> +                                       case BAMBOO_PT:
>> >> +                                               features->y_phy =
>> >> +
>> >> get_unaligned_le16(&report[i + 3]);
>> >> +                                               features->y_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 6]);
>> >> +                                               i += 12;
>> >> +                                               break;
>> >> +
>> >> +                                       default:
>> >>                                                 features->y_max =
>> >> +
>> >> features->x_max;
>> >> +                                               features->y_phy =
>> >>
>> >> get_unaligned_le16(&report[i + 3]);
>> >>                                                 i += 4;
>> >> +                                               break;
>> >>                                         }
>> >> +                               } else if (pen) {
>> >> +                                       features->y_max =
>> >> +
>> >> get_unaligned_le16(&report[i + 3]);
>> >> +                                       i += 4;
>> >>                                 }
>> >>                                 break;
>> >>
>> >> @@ -489,7 +470,7 @@ static int wacom_parse_hid(struct usb_interface
>> >> *intf,
>> >>
>> >>                 case HID_COLLECTION_END:
>> >>                         /* reset UsagePage and Finger */
>> >> -                       finger = usage = 0;
>> >> +                       finger = page = 0;
>> >>                         break;
>> >>
>> >>                 case HID_COLLECTION:
>> >> --
>> >> 1.8.5.3
>> >>
>> > Tested-by: Aaron Skomra <Aaron.Skomra@wacom.com>
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-input"
>> > in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
