From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: HID, driver interaction with device during probe defeated by 4ea5454203d991ec85264f64f89ca8855fce69b0
Date: Mon, 9 Apr 2012 12:36:37 +0200
Message-ID: <CANq1E4S2n8betsYapPVTH5qL1czyG5Ob=ExxMSz1mSUexTkaYw@mail.gmail.com>
References: <20120409000306.101c3427@neptune>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34662 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2DIKgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Apr 2012 06:36:39 -0400
Received: by wgbdr13 with SMTP id dr13so3944989wgb.1
        for <linux-input@vger.kernel.org>; Mon, 09 Apr 2012 03:36:37 -0700 (PDT)
In-Reply-To: <20120409000306.101c3427@neptune>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi

On Mon, Apr 9, 2012 at 12:03 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> Hi,
>
> picolcd driver stopped working (probe fails) recently, probably in
> relation with commit 4ea5454203d991ec85264f64f89ca8855fce69b0
> (HID: Fix race condition between driver core and ll-driver).
>
> The probe code does send a report to the HID device to query version
> information but times-out getting the response.

If there is no driver loaded we discard all messages. During probe we
consider a driver unloaded and picolcd seems to send a lot of requests
during probe. So it does make sense that this patch causes the
troubles.

> What would be the proper approach to fix this chicken-egg problem?
> Semaphore introduced by above patch is only being released after
> driver probe function has returned but prevents and incoming reports
> from being delivered.
>
> Touching the semaphore inside driver looks like a bad idea to me...

The initial idea of the semaphore was to avoid that during probe() and
remove() other HID callbacks are called. Otherwise, other drivers will
fail (the commit message explains this in more detail). Therefore, the
design of picolcd seems broken with respect to the semaphore.
The only idea I currently have is adding a flag that releases the
semaphore during driver->probe() and driver->remove() callbacks. I
think the driver-core uses its own locks so we will not get races
here. However, other HID drivers probably require proper
synchronization during probe() and remove() (which is totally
reasonable) as their internal structure might not be initialized, yet.
picolcd has several races here, too. hid_set_drvdata() is not
thread-safe or atomic so the raw-callback might get invalid "data"
pointers if we remove the semaphore again.

The nicest solution probably is releasing the semaphore during
hid_hw_start(). That way every driver is prepared to receive data.
However, it's an ugly solution because we release the lock not in the
same function as we acquire it. We also need to catch cases where
probe() actually did never call hid_hw_start().

Any other ideas?

> Thanks,
> Bruno

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
