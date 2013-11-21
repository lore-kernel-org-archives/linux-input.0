From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/3] Input: Added thumb detection in BCM5974 multitouch
 driver
Date: Thu, 21 Nov 2013 10:20:24 +0100
Message-ID: <528DD058.4030803@euromail.se>
References: <1384988052-31898-1-git-send-email-linux@schoeller.se> <1384988052-31898-3-git-send-email-linux@schoeller.se> <20131121050549.GC4702@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:44986 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab3KUJRV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 04:17:21 -0500
In-Reply-To: <20131121050549.GC4702@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Friedrich?= =?ISO-8859-1?Q?_Sch=F6ller?= <linux@schoeller.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> On Wed, Nov 20, 2013 at 11:54:12PM +0100, Friedrich Sch=F6ller wrote:
>> Trackpads with integrated buttons are hard to use when the driver re=
sponds to
>> movements of the thumb that is resting or clicking on the surface of=
 the
>> trackpad. This patch adds rudimentary support to filter out these to=
uch events.
>>
>> The feature can be turned on via sysfs:
>> 	/sys/class/input/input[0-9]+/thumb_ignore:
>> 		Enables thumb detection
>> 		Values: 0/1
>> 	/sys/class/input/input[0-9]+/thumb_ratio_on:
>> 		When the ratio of ABS_MT_TOUCH_MINOR / ABS_MT_TOUCH_MAJOR
>> 		times 100 is smaller than this value the touch qualifies
>> 		as a thumb.
>> 	/sys/class/input/input[0-9]+/thumb_ratio_off:
>> 		When the ratio of ABS_MT_TOUCH_MINOR / ABS_MT_TOUCH_MAJOR
>> 		times 100 is bigger than this value the touch no longer
>> 		qualifies as a thumb.
>> 	/sys/class/input/input[0-9]+/thumb_y_on:
>> 		When ABS_MT_POSITION_Y is bigger than this value the touch
>> 		qualifies as a thumb.
>> 	/sys/class/input/input[0-9]+/thumb_y_off:
>> 		When ABS_MT_POSITION_Y is smaller than this value the touch
>> 		no longer qualifies as a thumb.
>=20
> I'd rather this been implemented in userspace (synaptics and/or evdev=
 X
> drivers).

And it has been in userland since at least 2008. It can be found in
input-synaptics, input-multitouch, input-mtrack, possibly more places.

Thanks,
Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
