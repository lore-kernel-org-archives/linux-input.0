From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 1/4] input: Set default events per packet.
Date: Fri, 25 Mar 2011 16:30:20 -0700
Message-ID: <AANLkTi=KotXd4TyyUrhMdKn3mEq+pz2ac3Vnraa5udFh@mail.gmail.com>
References: <1300842244-42723-1-git-send-email-jeffbrown@android.com>
 <1300842244-42723-2-git-send-email-jeffbrown@android.com> <20110325082030.GB5664@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42638 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab1CYXbA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 19:31:00 -0400
In-Reply-To: <20110325082030.GB5664@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 25, 2011 at 1:20 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
>> +static inline bool is_mt_axis(int axis)
>> +{
>> + =A0 =A0 return axis =3D=3D ABS_MT_SLOT ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 (axis >=3D ABS_MT_FIRST && axis <=3D ABS_M=
T_LAST);
>> +}
>
> It would be great to get this inline into input/mt.h instead.

Makes sense.  I'll do that.

>> + =A0 =A0 else if (test_bit(ABS_MT_TRACKING_ID, dev->absbit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 mt_slots =3D dev->absinfo[ABS_MT_TRACKING_=
ID].maximum -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->absinfo[ABS_MT_TRACKI=
NG_ID].minimum + 1;
>
> This one is a bit iffy - the tracking id is not limited like this in
> mainline, looks like android usage. A test againts some arbitrary max
> should do it.

Yeah, I'm not sure about this one.  Tracking ID could effectively have
any range.  All of the MT Protocol A touch screen drivers I have
looked at, assuming they report tracking ids at all, report a
reasonable upper bound on the contact points they support.

Originally, I set an arbitrary maximum bound of 20 slots.  In the
interests of keeping it simple, I decided to remove that bound when I
submitted the patch for review here.

How about:

mt_slots =3D min(MAX_MT_SLOTS_TO_INFER_FROM_TRACKING_ID_RANGE,
   dev->absinfo[ABS_MT_TRACKING_ID].maximum -
dev->absinfo[ABS_MT_TRACKING_ID].minimum + 1);

Where MAX_MT_SLOTS_TO_INFER_FROM_TRACKING_ID_RANGE is set to 32 or some=
thing.

There's also the question of how many slots we should infer when
neither ABS_MT_SLOT or ABS_MT_TRACKING_ID is available.  The drivers
I've seen that don't provide tracking ids, are very basic and tend to
only support 2 touch points.

I guess we could add a DEFAULT_NUMBER_OF_MT_SLOTS constant to handle th=
at case.

Please feel free to suggest better names for these constants.

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
