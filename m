From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [Regression][v3.10][v3.11] Revert "HID: Fix logitech-dj: missing
 Unifying device issue"
Date: Wed, 17 Jul 2013 11:01:17 +0200
Message-ID: <CAE7qMrrLiArdcCt+9a7UTAUrgDrFn_rAV0JVC-M+WnWGmpnudQ@mail.gmail.com>
References: <51E430E0.9050304@canonical.com> <CAAfQ=89uUcT9RAPSXN1AoJ9tBvAT-z66WuAvRsYUtEW66A7DoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfQ=89uUcT9RAPSXN1AoJ9tBvAT-z66WuAvRsYUtEW66A7DoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew de los Reyes <adlr@chromium.org>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
List-Id: linux-input@vger.kernel.org

Added Benjamin.

On Mon, Jul 15, 2013 at 8:37 PM, Andrew de los Reyes <adlr@chromium.org> wrote:
> I believe this commit was an optimization, so it should be okay to revert
> it.
>
> Nestor, can you confirm?

5962640 is not an optimization, is a workaround for the dropped
packets during enumeration. After a9dd22b73085734 it should not be
necessary as the issue should be resolved.

Nevertheless, it turns out that the workaround not only helps in the
case that some input reports get dropped (which no longer happens),
but also in the case that the underlying usb controllers fail to send
the report that request the enumeration of the Unifying receiver.
We've seen this ocassionally depending on the usb controllers and some
time dependent behaviour.

Concluding I'd say that this patch being otherwise harmless, albeit
ugly, could be put back in. I'd suggest as well investigating why the
usb controllers fails to send the enumeration request with -EPIPE, as
this my be hiding a race inside those usb drivers.

If we re-add 596264082f10dd4. We should fix setting querying_devices
flag to true. This was not done in the original patch. As the impact
was not seen and the patch was to be removed anyway it was never
corrected.

>
>
> On Mon, Jul 15, 2013 at 10:26 AM, Joseph Salisbury
> <joseph.salisbury@canonical.com> wrote:
>>
>> Hi Andrew,
>>
>> A bug was opened against the Ubuntu kernel[0].  It was found that
>> reverting the following commit resolved this bug:
>>
>> commit 8af6c08830b1ae114d1a8b548b1f8b056e068887
>> Author: Andrew de los Reyes <adlr@chromium.org>
>> Date:   Mon Feb 18 09:20:23 2013 -0800
>>
>>     Revert "HID: Fix logitech-dj: missing Unifying device issue"
>>
>>
>> The regression was introduced as of v3.10-rc1.  Commit 8af6c08 reverts
>> commit 5962640, so it seems commit 5962640 may still be needed.
>>
>> I see that you are the author of this patch, so I wanted to run this by
>> you.  I was thinking of requesting a revert for v3.11, but I wanted to
>> get your feedback first.
>>
>>
>> Thanks,
>>
>> Joe
>>
>> [0] http://pad.lv/1194649
>
>

Cheers,
Nestor
