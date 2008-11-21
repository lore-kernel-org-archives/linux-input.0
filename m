From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
 protocol
Date: Fri, 21 Nov 2008 15:44:44 +0100
Message-ID: <4926C95C.7000609@bitmath.org>
References: <49142351.9080805@euromail.se> <20081119113508.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756440AbYKUOpA@vger.kernel.org>
In-Reply-To: <20081119113508.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry,

My patch is all wrong. It would certainly benefit from using the
EV_SYN/SYN_MT_REPORT, but the defuzz mechanism of the EV_ABS class
simply will not work when sending data for several different fingers
using the same event.

I can see two clear alternatives: either add a new event class, EV_MT,
which sends all data without trying to limit the bandwidth, or forget
about the whole serial-finger-data idea and expand the current EV_ABS
class with an array of MT finger data [1]. I would very much appreciate
your input on this. Maybe there is a third option.

Cheers,
Henrik

[1] An example of a straight-forward addition of EV_ABS/ABS_MT events:

#define ABS_MT_FINGER_CNT	10
#define ABS_MT_PROPERTY_CNT	12

#define ABS_MT_FINGER_START	0x30
#define ABS_MT_TOUCH(x)		(ABS_MT_FINGER_START + 0 * ABS_MT_FINGER_CNT + x)
#define ABS_MT_WIDTH(x)		(ABS_MT_FINGER_START + 1 * ABS_MT_FINGER_CNT + x)
...
#define ABS_MT_FINGER_END	0xa8 /* = ABS_MT_FINGER_START + ABS_MT_PROPERTY_CNT * ABS_MT_FINGER_CNT */
