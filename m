From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: HID, driver interaction with device during probe defeated by
 4ea5454203d991ec85264f64f89ca8855fce69b0
Date: Sat, 5 May 2012 14:19:47 +0200
Message-ID: <20120505141947.1c3456cb@neptune.home>
References: <20120409000306.101c3427@neptune>
	<CANq1E4S2n8betsYapPVTH5qL1czyG5Ob=ExxMSz1mSUexTkaYw@mail.gmail.com>
	<20120505125814.7fbd4312@neptune.home>
	<CANq1E4SKYyxhxoOZezSA0+uaaxUvVxxa+vAXJdDQWRkSxes4ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:46504 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab2EEMUB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 May 2012 08:20:01 -0400
In-Reply-To: <CANq1E4SKYyxhxoOZezSA0+uaaxUvVxxa+vAXJdDQWRkSxes4ew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi David,

On Sat, 05 May 2012 David Herrmann wrote:
> On Sat, May 5, 2012 at 12:58 PM, Bruno Pr=C3=A9mont wrote:
> [snip]
> >> The nicest solution probably is releasing the semaphore during
> >> hid_hw_start(). That way every driver is prepared to receive data.
> >> However, it's an ugly solution because we release the lock not in =
the
> >> same function as we acquire it. We also need to catch cases where
> >> probe() actually did never call hid_hw_start().
> >
> > On probe side:
> >
> > Maybe instead of doing it within hid_hw_start() it could also be do=
ne
> > in hid_connect() in combination of a flag on hdev->claimed.
>=20
> Could you elaborate this? I don't understand what you mean.

I'm not sure how much of hid_connect() or hid_disconnect() should be
covered by the semaphore.
If it's all of it then there is no big preference between putting the
semaphore operations in hid_hw_start/stop or hid_(dis)connect, otherwis=
e
moving those up/down calls down into hid_(dis)connect is better.

Keeping the up/down in hid_start/stop though causes them to be repeated
everywhere as those are defined in header file.

> > On remove side:
> >
> > Let the semaphore be taken in hid_disconnect() (instead of hid_hw_s=
top(),
> > yet again in combination with flag on hdev->claimed.
> >
> >
> > This way probe and remove could WARN_ON() case where hdev->claim do=
es
> > not show the flag as expected (that is, assuming probe() and remove=
()
> > can't be interlaced for the same device)
> >
> > Otherwise it would require one more lock or doing some of the probe
> > initialization in a work queue (but that second option would make r=
ace
> > conditions much more of a problem)...
>=20
> My suggestion is to call up(&hdev->driver_lock) in hid_hw_start() if
> some quirk is set. hid_device_probe() can then check whether the
> semaphore is locked before calling up(). This way we would release th=
e
> lock before initializing a device. However, this seems ugly.

Choosing where it happens with a quirk definitely seems ugly and checki=
ng
for the semaphore would race with potential reports coming from device.

> Your idea with the work queue seems much cleaner. However, there is
> currently no way to make sure the work is executed _after_
> hid_device_probe() releases the mutex. We could, however, introduce
> some "hid_wait_until_initialized()" function that just tries to take
> the semaphore and make the work wait until the hid_device_probe
> finishes.

But then again the queued work may race with remove() call and if the
driver decides it doesn't want to handle the device it would have to
trigger unbind sequence from the queued work which looks rather more
complicated than failing inside probe!

A probe_late() driver callback would be better in that case, this callb=
ack
would be called after up()-ing the semaphore but before returning from
probe().
On failure of probe_late() the semaphore would have to be taken again
to clear ->driver

> Maybe Jiri can comment here. But I think picolcd is broken and not th=
e
> semaphore. If I have some time I will try to send a fix for that. I d=
o
> not have the hardware, though, so I cannot test it.

They can't live together in peace with current code :)

Cheers,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
