From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: HID, driver interaction with device during probe defeated by
 4ea5454203d991ec85264f64f89ca8855fce69b0
Date: Sat, 5 May 2012 12:58:14 +0200
Message-ID: <20120505125814.7fbd4312@neptune.home>
References: <20120409000306.101c3427@neptune>
	<CANq1E4S2n8betsYapPVTH5qL1czyG5Ob=ExxMSz1mSUexTkaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:42058 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab2EEK63 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 May 2012 06:58:29 -0400
In-Reply-To: <CANq1E4S2n8betsYapPVTH5qL1czyG5Ob=ExxMSz1mSUexTkaYw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi David,

On Mon, 09 April 2012 David Herrmann wrote:
> > What would be the proper approach to fix this chicken-egg problem?
> > Semaphore introduced by above patch is only being released after
> > driver probe function has returned but prevents and incoming reports
> > from being delivered.
> >
> > Touching the semaphore inside driver looks like a bad idea to me...
> 
> The initial idea of the semaphore was to avoid that during probe() and
> remove() other HID callbacks are called. Otherwise, other drivers will
> fail (the commit message explains this in more detail). Therefore, the
> design of picolcd seems broken with respect to the semaphore.
> The only idea I currently have is adding a flag that releases the
> semaphore during driver->probe() and driver->remove() callbacks. I
> think the driver-core uses its own locks so we will not get races
> here. However, other HID drivers probably require proper
> synchronization during probe() and remove() (which is totally
> reasonable) as their internal structure might not be initialized, yet.
> picolcd has several races here, too. hid_set_drvdata() is not
> thread-safe or atomic so the raw-callback might get invalid "data"
> pointers if we remove the semaphore again.

Yes, there are a few races around in picolcd driver, I'm looking at how
I can improve one those, the toughest part being proper handling of
"unplug" events where the device is gone such that multi-report
transmissions get stopped right ahead...

> The nicest solution probably is releasing the semaphore during
> hid_hw_start(). That way every driver is prepared to receive data.
> However, it's an ugly solution because we release the lock not in the
> same function as we acquire it. We also need to catch cases where
> probe() actually did never call hid_hw_start().

On probe side:

Maybe instead of doing it within hid_hw_start() it could also be done
in hid_connect() in combination of a flag on hdev->claimed.


On remove side:

Let the semaphore be taken in hid_disconnect() (instead of hid_hw_stop(),
yet again in combination with flag on hdev->claimed.


This way probe and remove could WARN_ON() case where hdev->claim does
not show the flag as expected (that is, assuming probe() and remove()
can't be interlaced for the same device)

Otherwise it would require one more lock or doing some of the probe
initialization in a work queue (but that second option would make race
conditions much more of a problem)...

Thanks,
Bruno
