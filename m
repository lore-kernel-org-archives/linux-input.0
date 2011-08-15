From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 4/8 v3] Input: synaptics - add image sensor support
Date: Mon, 15 Aug 2011 15:17:57 +0800
Message-ID: <CAGS+omAo1tPzBQ_s+vz-7_5SS6vWv4bdzD1JfqepUS7wYxK5sA@mail.gmail.com>
References: <1313169407-4358-1-git-send-email-djkurtz@chromium.org>
 <1313169407-4358-5-git-send-email-djkurtz@chromium.org> <20110812210911.GA9124@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:25607 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab1HOHSV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 03:18:21 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p7F7IK12018382
	for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 00:18:20 -0700
Received: from iye16 (iye16.prod.google.com [10.241.50.16])
	by hpaq11.eem.corp.google.com with ESMTP id p7F7IH1W003221
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 00:18:18 -0700
Received: by iye16 with SMTP id 16so6564302iye.29
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 00:18:17 -0700 (PDT)
In-Reply-To: <20110812210911.GA9124@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: chase.douglas@canonical.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

Hi Henrik,

Thanks for the great feedback.

On Sat, Aug 13, 2011 at 5:09 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Daniel,
>
> looks good, some details below.
>
>> +static void synaptics_report_slot_empty(struct input_dev *dev, int =
slot)
>> +{
>> + =A0 =A0 input_mt_slot(dev, slot);
>> + =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, false);
>> +}
>> +
>> +static void synaptics_report_slot_sgm(struct input_dev *dev, int sl=
ot,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 const struct synaptics_hw_state *sgm)
>> +{
>> + =A0 =A0 input_mt_slot(dev, slot);
>> + =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
>> + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X, sgm->x);
>> + =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y, invert_y(sgm->y))=
;
>> + =A0 =A0 input_report_abs(dev, ABS_MT_PRESSURE, sgm->z);
>> + =A0 =A0 /* SGM can sometimes contain valid width */
>> + =A0 =A0 if (sgm->w >=3D 4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_TOUCH_MAJOR, =
sgm->w);
>> +}
>
> The ABS_MT_TOUCH_MAJOR is supposed to have zero intercept, to remain
> compatible with user space handling of type A devices. Also, the scal=
e
> should match the screen/pad size, such that the actual size of the
> touch area can be deduced. In addition, based on the current sensor
> technologies, ABS_MT_PRESSURE and ABS_MT_TOUCH_MAJOR are normally
> mutually exclusive.
>
> All in all, I would prefer to only report width via (the single-finge=
r
> axis) ABS_TOOL_WIDTH, and only for compatibility reasons.
>
> +
> +static void synaptics_report_slot_agm(struct input_dev *dev, int slo=
t,
> +                                   const struct synaptics_hw_state *=
agm)
> +{
> +     input_mt_slot(dev, slot);
> +     input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
> +     input_report_abs(dev, ABS_MT_POSITION_X, agm->x);
> +     input_report_abs(dev, ABS_MT_POSITION_Y, invert_y(agm->y));
> +     input_report_abs(dev, ABS_MT_PRESSURE, agm->z);
> +}

With ABS_MT_TOUCH_MAJOR dropped, sgm and agm seems to coincide...
=2E...
>
> Looks good otherwise.
>
> Thanks,
> Henrik
>

Ahh....  ok, this makes sense.  I missed this detail previously.
Basically:
  * Only report synaptics "w" as ABS_TOOL_WIDTH (for backwards compatib=
ility)
  * Report synaptics "z" as ABS_MT_TOUCH_MAJOR (assuming it is really
'width of finger in surface units'), and ABS_PRESSURE (for backwards
compatibility).
  * Don't use ABS_MT_PRESSURE.
  * This will simplify agm/sgm reporting by making them both reoprt
the same axes.

I will rework these patches to do this.

Thanks,
-Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
