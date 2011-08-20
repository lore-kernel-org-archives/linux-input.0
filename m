From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 4/9 v4] Input: synaptics - add image sensor support
Date: Sat, 20 Aug 2011 15:07:41 +0800
Message-ID: <CAGS+omCZSjJoESSvimLEpj9Mwr3d9Vn78e1ZLk-NWEdgQbxNKw@mail.gmail.com>
References: <1313666888-18939-1-git-send-email-djkurtz@chromium.org>
 <1313666888-18939-5-git-send-email-djkurtz@chromium.org> <20110819222203.GC5146@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:52894 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1HTHIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Aug 2011 03:08:04 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p7K782MV008022
	for <linux-input@vger.kernel.org>; Sat, 20 Aug 2011 00:08:02 -0700
Received: from iye7 (iye7.prod.google.com [10.241.50.7])
	by wpaz33.hot.corp.google.com with ESMTP id p7K781Up009470
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sat, 20 Aug 2011 00:08:01 -0700
Received: by iye7 with SMTP id 7so7698719iye.3
        for <linux-input@vger.kernel.org>; Sat, 20 Aug 2011 00:08:01 -0700 (PDT)
In-Reply-To: <20110819222203.GC5146@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: chase.douglas@canonical.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

On Sat, Aug 20, 2011 at 6:22 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Daniel,
>
> On Thu, Aug 18, 2011 at 07:28:03PM +0800, Daniel Kurtz wrote:
>> @@ -558,6 +626,11 @@ static void synaptics_process_packet(struct psm=
ouse *psmouse)
>> =A0 =A0 =A0 if (synaptics_parse_hw_state(psmouse->packet, priv, &hw)=
)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 synaptics_image_sensor_process(psmouse, &h=
w);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>
> So what about the rest of the SYnaptics processing (wheel, additional
> buttons, etc)? =A0Are we sure that touchpads with image sensors will =
never
> implement them?
>
> --
> Dmitry
>

All image sensors that I am aware of are clickpads, with one button
integrated under the pad, which is reported as the middle button.

We could report right, middle, up, down, and ext_buttons (scroll is
not possible, since w=3D2;buf[1] is used for x for devices that send ag=
m
packets).
However, I have no way of knowing if this added complexity is
necessary, nor any way of testing it.

-Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
