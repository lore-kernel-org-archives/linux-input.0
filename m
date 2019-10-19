Return-Path: <SRS0=RHEz=YM=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B7BCA9EA9
	for <linux-input@archiver.kernel.org>; Sat, 19 Oct 2019 02:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843E222CC
	for <linux-input@archiver.kernel.org>; Sat, 19 Oct 2019 02:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LKhQM7IT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJSCDU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 18 Oct 2019 22:03:20 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:25534 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfJSCDU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Oct 2019 22:03:20 -0400
Date:   Sat, 19 Oct 2019 02:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571450596;
        bh=fGAFKa0dt3dcLpVCJE+L98SsSJUmX8cOpMelXd7ommA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=LKhQM7IT+rWYuQYXt5TlWIaiNvQ+cHVFsTt0GVCOImKx473RTHlBwYEFX4N+5CIDO
         W6SLr0FoM4qxKb3L1wq+hUjEcRMlkRh6/9JCIL6K7s5jPtTGDUNFWa9zhP+7KCuv6r
         I5dtrTrisHdSGo4rhCXgkEyLLXz6VuVHyemzG408=
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>,
        "mnrzk@protonmail.com" <mnrzk@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH v6 2/2] HID: logitech: Support WirelessDeviceStatus connect events
Message-ID: <_XAAROgmVQtz0wM-41RjBE2iGA8WwIQA_CBMMzPBdAuwXU6KbN8K5owaFm6FbU9kSjazcpp2N5GvlNXKrsobND18-I3dRzK4ZBCzMyJasYs=@protonmail.com>
In-Reply-To: <CAO-hwJK3Q1Bu+6JVbXmbZ2-JqaPzX=dEVPfue=v2LRJsU7FmGA@mail.gmail.com>
References: <_1Ewv9AvBhbWTNcFOkmvCyjVph73eQIz23Plyv5ffgaWWHnmPBTbSIJhs47AnYatJsmDWu4JlMjcsKE8Cf31lvmwQipYEu47YglNfroyJtM=@protonmail.com>
 <CAO-hwJK3Q1Bu+6JVbXmbZ2-JqaPzX=dEVPfue=v2LRJsU7FmGA@mail.gmail.com>
Feedback-ID: 18B_FC5q-t32TXzMsVp9BgkgrdNH3iwklfW8WOrHrcxZA0WRj7JodCh5VXKxs6A3OaiHK0QNd8wi3SImKex8yQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Friday, October 18, 2019 11:38 AM, Benjamin Tissoires <benjamin.tissoire=
s@redhat.com> wrote:

> On Mon, Oct 14, 2019 at 8:36 PM Mazin Rezk mnrzk@protonmail.com wrote:
>
> > This patch allows WirelessDeviceStatus (0x1d4b) events to be detected a=
s
> > connection events in the hid-logitech-hidpp module.
> > Devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS use WirelessDeviceStatu=
s
> > instead of traditional connect events. Since all Bluetooth LE devices s=
eem
> > to act this way, HIDPP_QUIRK_CLASS_BLUETOOTH_LE aliases this quirk.
> >
> > Signed-off-by: Mazin Rezk mnrzk@protonmail.com
> >
> > -----------------------------------------------
> >
> > drivers/hid/hid-logitech-hidpp.c | 42 ++++++++++++++++++++++++++++----
> > 1 file changed, 37 insertions(+), 5 deletions(-)
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
> > index 997b1056850a..9b3df57ca857 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -60,6 +60,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> > #define HIDPP_QUIRK_CLASS_K750 BIT(4)
> > /* bits 2..15 are reserved for classes /
> > +#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS BIT(19)
> > #define HIDPP_QUIRK_MISSING_SHORT_REPORTS BIT(20)
> > / #define HIDPP_QUIRK_CONNECT_EVENTS BIT(21) disabled */#define HIDPP_Q=
UIRK_WTP_PHYSICAL_BUTTONS BIT(22)
> > @@ -82,7 +83,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
> > HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
> > HIDPP_QUIRK_HI_RES_SCROLL_X2121)
> > -#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE HIDPP_QUIRK_MISSING_SHORT_REPOR=
TS
> > +#define HIDPP_QUIRK_CLASS_BLUETOOTH_LE (HIDPP_QUIRK_MISSING_SHORT_REPO=
RTS | \
> >
> > -                                          HIDPP_QUIRK_WIRELESS_DEVICE_=
STATUS)
> >
> >
> >
> > #define HIDPP_QUIRK_DELAYED_INIT HIDPP_QUIRK_NO_HIDINPUT
> > @@ -189,6 +191,8 @@ struct hidpp_device {
> >
> >         struct hidpp_battery battery;
> >         struct hidpp_scroll_counter vertical_wheel_counter;
> >
> >
> > -
> > -         u8 wireless_feature_index;
> >
> >
> >
> > };
> > /* HID++ 1.0 error codes */
> > @@ -402,10 +406,14 @@ static inline bool hidpp_match_error(struct hidpp=
_report *question,
> > (answer->fap.params[0] =3D=3D question->fap.funcindex_clientid);
> > }
> > -static inline bool hidpp_report_is_connect_event(struct hidpp_report *=
report)
> > +static inline bool hidpp_report_is_connect_event(struct hidpp_device *=
hidpp,
> >
> > -                                                  struct hidpp_report =
*report)
> >
> >
> >
> > {
> >
> > -         return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
> >
> >
> > -                 (report->rap.sub_id =3D=3D 0x41);
> >
> >
> >
> > -         return ((hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) =
&&
> >
> >
> > -                 (report->fap.feature_index =3D=3D hidpp->wireless_fea=
ture_index)) ||
> >
> >
> > -               (((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
> >
> >
> > -                 (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) =
&&
> >
> >
> > -                 (report->rap.sub_id =3D=3D 0x41));
> >
> >
>
> I wonder if we need a quirk after all: if
> hidpp->wireless_feature_index is non null, that means that we have the
> quirk.
> Unless the feature is present for non BLE devices, in which case, we
> might want to enable them one by one, for now.
>
> Cheers,
> Benjamin

Come to think of it, it does seem redundant. I'll likely extend the
WirelessDeviceStatus check to all HID++ 2.0 devices and just forgo the
added quirks entirely.

Thanks,
Mazin

>
> > }
> > /**
> > @@ -1282,6 +1290,24 @@ static int hidpp_battery_get_property(struct pow=
er_supply *psy,
> > return ret;
> > }
> > +/* -------------------------------------------------------------------=
------- /
> > +/ 0x1d4b: Wireless device status /
> > +/ --------------------------------------------------------------------=
------ */+#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS 0x1d4b
> > +
> > +static int hidpp_set_wireless_feature_index(struct hidpp_device *hidpp=
)
> > +{
> >
> > -         u8 feature_type;
> >
> >
> > -         int ret;
> >
> >
> > -
> > -         ret =3D hidpp_root_get_feature(hidpp,
> >
> >
> > -                                      HIDPP_PAGE_WIRELESS_DEVICE_STATU=
S,
> >
> >
> > -                                      &hidpp->wireless_feature_index,
> >
> >
> > -                                      &feature_type);
> >
> >
> > -
> > -         return ret;
> >
> >
> >
> > +}
> > +
> > /* --------------------------------------------------------------------=
------ /
> > / 0x2120: Hi-resolution scrolling /
> > / ---------------------------------------------------------------------=
----- */@@ -3077,7 +3103,7 @@ static int hidpp_raw_hidpp_event(struct hidpp=
_device *hidpp, u8 *data,
> > }
> > }
> >
> > -         if (unlikely(hidpp_report_is_connect_event(report))) {
> >
> >
> >
> > -         if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
> >                   atomic_set(&hidpp->connected,
> >                                   !(report->rap.params[0] & (1 << 6)));
> >                   if (schedule_work(&hidpp->work) =3D=3D 0)
> >
> >
> >
> > @@ -3624,6 +3650,12 @@ static int hidpp_probe(struct hid_device *hdev, =
const struct hid_device_id *id)
> > hidpp_overwrite_name(hdev);
> > }
> >
> > -         if (connected && (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE=
_STATUS)) {
> >
> >
> > -                 ret =3D hidpp_set_wireless_feature_index(hidpp);
> >
> >
> > -                 if (ret)
> >
> >
> > -                         goto hid_hw_init_fail;
> >
> >
> > -         }
> >
> >
> > -         if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
> >                   ret =3D wtp_get_config(hidpp);
> >                   if (ret)
> >
> >
> >
> > --
> > 2.23.0


