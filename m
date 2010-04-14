From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH] Use TipSwitch for Touch
Date: Wed, 14 Apr 2010 10:15:04 +0200
Message-ID: <t2u45cc95261004140115pda82ce66md30790d117888378@mail.gmail.com>
References: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
	<1271221494-14846-1-git-send-email-rafi@seas.upenn.edu> <20100414063242.GB9428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:54784 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0DNIPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 04:15:32 -0400
Received: by bwz25 with SMTP id 25so6507943bwz.28
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2010 01:15:30 -0700 (PDT)
In-Reply-To: <20100414063242.GB9428@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, micki@n-trig.com, chatty@enac.fr

Hi,

Maybe off-topic, but what about the support of Bamboo multitouch
devices from Wacom ?
http://www.wacom.com/bamboo/

M-I


On Wed, Apr 14, 2010 at 8:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Apr 14, 2010 at 01:04:54AM -0400, Rafi Rubin wrote:
>> TipSwitch is a better match for touch. =A0Confidence and InRange wor=
k
>> for more current firmwares, but with some older versions only
>> TipSwitch is appropriate.
>>
>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
>> ---
>> =A0drivers/hid/hid-ntrig.c | =A0 27 +++++++++++++++++++--------
>> =A01 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
>> index 58ba0d3..071f86d 100644
>> --- a/drivers/hid/hid-ntrig.c
>> +++ b/drivers/hid/hid-ntrig.c
>> @@ -31,10 +31,12 @@ struct ntrig_data {
>> =A0 =A0 =A0 /* Incoming raw values for a single contact */
>> =A0 =A0 =A0 __u16 x, y, w, h;
>> =A0 =A0 =A0 __u16 id;
>> - =A0 =A0 __u8 confidence;
>> +
>> + =A0 =A0 bool tipswitch;
>> + =A0 =A0 bool confidence;
>> + =A0 =A0 bool first_contact_touch;
>>
>> =A0 =A0 =A0 bool reading_mt;
>> - =A0 =A0 __u8 first_contact_confidence;
>>
>> =A0 =A0 =A0 __u8 mt_footer[4];
>> =A0 =A0 =A0 __u8 mt_foot_count;
>> @@ -141,9 +143,10 @@ static int ntrig_event (struct hid_device *hid,=
 struct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0xff000001:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Tag indicating the st=
art of a multitouch group */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nd->reading_mt =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nd->first_contact_confiden=
ce =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nd->first_contact_touch =3D=
 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TIPSWITCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nd->tipswitch =3D value;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Prevent emission of t=
ouch until validated */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_CONFIDENCE:
>> @@ -171,10 +174,17 @@ static int ntrig_event (struct hid_device *hid=
, struct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to emit a normal (X=
, Y) position
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!nd->reading_mt) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_repo=
rt_key(input, BTN_TOOL_DOUBLETAP,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(nd->confidence !=3D 0));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* TipSw=
itch indicates the presence of a
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* finge=
r. =A0Touch is the preferred event for
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* downs=
tream support. =A0DoubleTap is also
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* emitt=
ed to support proper operation with
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the w=
acom X driver (for now).
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>
> I am not sure if we want to propagate unfortunate event selection in
> wacom drievr into other drivers. Any chance you could lend Ping hand =
in
> adding proper multitouch support to wacom X driver instead?
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
