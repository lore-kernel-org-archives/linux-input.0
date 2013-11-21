From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] Input: Fixed ABS_MT_TOUCH_MINOR scale factor in BCM5974
 multitouch driver
Date: Thu, 21 Nov 2013 10:05:01 +0100
Message-ID: <528DCCBD.80009@euromail.se>
References: <1384988052-31898-1-git-send-email-linux@schoeller.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:33475 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab3KUJBs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 04:01:48 -0500
In-Reply-To: <1384988052-31898-1-git-send-email-linux@schoeller.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Friedrich_Sch=F6ller?= <linux@schoeller.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Friedrich,

> On wellspring3 devices ABS_MT_TOUCH_MINOR was sometimes reported bigger than
> ABS_MT_TOUCH_MAJOR. This is fixed by rescaling ABS_MT_TOUCH_MINOR by a factor of
> 0.85 instead of 2. Excessive tapping on the trackpad shows this to be the right
> value. Circular touches should now lead to values for ABS_MT_TOUCH_MAJOR and
> ABS_MT_TOUCH_MINOR that are similar, with ABS_MT_TOUCH_MINOR never greater than
> ABS_MT_TOUCH_MAJOR.
> ---
>  drivers/input/mouse/bcm5974.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

The major/minor scales are following the aspect ratio of the device, and as such
it could happen that minor > major. Most userland drivers do not use the finger
width limits, which are estimates, but only the device axes limit, which are
accurate.

Also, we cannot have floats in the kernel.

I would consider a patch which tries to make the finger widths more accurate,
but all in all, I think this problem is best solved in userland.

Thanks,
Henrik

