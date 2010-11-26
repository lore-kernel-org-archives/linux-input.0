From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Fri, 26 Nov 2010 17:02:05 -0600
Message-ID: <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
References: <4CEE6D2A.9040408@euromail.se>
	<4CEE6EE8.4060805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44965 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab0KZXCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Nov 2010 18:02:06 -0500
Received: by ywl5 with SMTP id 5so1155627ywl.19
        for <linux-input@vger.kernel.org>; Fri, 26 Nov 2010 15:02:05 -0800 (PST)
In-Reply-To: <4CEE6EE8.4060805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Thu, Nov 25, 2010 at 8:12 AM, Nikolai Kondrashov <spbnick@gmail.com>=
 wrote:
> On 11/25/2010 05:05 PM, Henrik Rydberg wrote:
>>
>> =A0 =A0 =A0 =A0__u32 =A0 phys_abs_width; =A0 =A0 =A0 =A0 /* physical=
 width of surface (mm)
>> */
>> =A0 =A0 =A0 =A0__u32 =A0 phys_abs_height; =A0 =A0 =A0 =A0/* physical=
 height of surface (mm)
>> */
>
> This is better and is already covered by input_absinfo.
> You could calculate it with (maximum - minimum) / resolution.

On this topic.  I'd like to start reporting resolution for a few wacom
devices.

When I looked at input_absinfo.resolution, I see only synaptics.c is
using it right now and it is defined using units/mm.  Currently, this
makes it up to xf86-input-synaptics were X is fed this value after
converting to units/meter.  Thats my intended usage as well.

I'm more used to values in inches (lpi) or at least something higher
then mm.  If I converted my lpi to mm for resolution I'd lose some
accuracy.

We could solve that a few ways.  Provide units in input_absinfo,
convert to units/inch, units/cm or even units/meter, or define
physical size in mm.

Any preferences?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
