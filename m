From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: Added thumb detection in BCM5974 multitouch
 driver
Date: Wed, 20 Nov 2013 21:05:51 -0800
Message-ID: <20131121050549.GC4702@core.coreip.homeip.net>
References: <1384988052-31898-1-git-send-email-linux@schoeller.se>
 <1384988052-31898-3-git-send-email-linux@schoeller.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:58339 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3KUFGE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 00:06:04 -0500
Content-Disposition: inline
In-Reply-To: <1384988052-31898-3-git-send-email-linux@schoeller.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Friedrich =?iso-8859-1?Q?Sch=F6ller?= <linux@schoeller.se>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Friedrich,

On Wed, Nov 20, 2013 at 11:54:12PM +0100, Friedrich Sch=F6ller wrote:
> Trackpads with integrated buttons are hard to use when the driver res=
ponds to
> movements of the thumb that is resting or clicking on the surface of =
the
> trackpad. This patch adds rudimentary support to filter out these tou=
ch events.
>=20
> The feature can be turned on via sysfs:
> 	/sys/class/input/input[0-9]+/thumb_ignore:
> 		Enables thumb detection
> 		Values: 0/1
> 	/sys/class/input/input[0-9]+/thumb_ratio_on:
> 		When the ratio of ABS_MT_TOUCH_MINOR / ABS_MT_TOUCH_MAJOR
> 		times 100 is smaller than this value the touch qualifies
> 		as a thumb.
> 	/sys/class/input/input[0-9]+/thumb_ratio_off:
> 		When the ratio of ABS_MT_TOUCH_MINOR / ABS_MT_TOUCH_MAJOR
> 		times 100 is bigger than this value the touch no longer
> 		qualifies as a thumb.
> 	/sys/class/input/input[0-9]+/thumb_y_on:
> 		When ABS_MT_POSITION_Y is bigger than this value the touch
> 		qualifies as a thumb.
> 	/sys/class/input/input[0-9]+/thumb_y_off:
> 		When ABS_MT_POSITION_Y is smaller than this value the touch
> 		no longer qualifies as a thumb.

I'd rather this been implemented in userspace (synaptics and/or evdev X
drivers).

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
