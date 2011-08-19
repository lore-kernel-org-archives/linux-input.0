From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Fri, 19 Aug 2011 14:41:01 +0200
Message-ID: <4E4E59DD.7000005@tudelft.nl>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <20110818173959.GE28313@thinkpad-t410> <87hb5ddcsa.fsf@emc.com.tw> <20110819121308.GA16386@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:46822 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1HSMlD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 08:41:03 -0400
In-Reply-To: <20110819121308.GA16386@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>Tom Lin <t>

Op 19-08-11 14:13, Seth Forshee schreef:
> On Fri, Aug 19, 2011 at 04:29:57PM +0800, JJ Ding wrote:
>>> You should only report the ABS_[XY] coordinates when fingers !=3D 0=
=2E The
>>> xorg synaptics module sees the values reported in that case as
>>> legitimate. This is causing me to see strange behaviors when scroll=
ing
>>> with two-finger drags.
>> AFAIK, though v2 and v3 differ in packet format, they really report =
the
>> same data to the userspace. In this version of v3 support, I even tr=
y to
>> make v2 and v3 report all the data in the same sequnce. If you're se=
eing
>> this issue, maybe we should do the same with v2?
>
> Actually neither v1 nor v2 reports ABS_[XY] unless fingers !=3D 0. In=
 v2
> the reporting is in a switch statement on the number of fingers, and =
0
> is unhandled.

Yes, in other words, in the case of v1 or v2, the switch(fingers) does=20
nothing if fingers =3D=3D 0.

Maybe you could do put these 3 lines inside a "if (fingers !=3D 0)":
+	input_report_abs(dev, ABS_X, x1);
+	input_report_abs(dev, ABS_Y, y1);
+	elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);

=C9ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
