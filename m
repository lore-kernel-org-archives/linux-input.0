From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: HID, driver interaction with device during probe defeated by 4ea5454203d991ec85264f64f89ca8855fce69b0
Date: Sat, 5 May 2012 13:56:00 +0200
Message-ID: <CANq1E4SKYyxhxoOZezSA0+uaaxUvVxxa+vAXJdDQWRkSxes4ew@mail.gmail.com>
References: <20120409000306.101c3427@neptune>
	<CANq1E4S2n8betsYapPVTH5qL1czyG5Ob=ExxMSz1mSUexTkaYw@mail.gmail.com>
	<20120505125814.7fbd4312@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60340 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab2EEL4C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 May 2012 07:56:02 -0400
Received: by wgbdr13 with SMTP id dr13so3480308wgb.1
        for <linux-input@vger.kernel.org>; Sat, 05 May 2012 04:56:00 -0700 (PDT)
In-Reply-To: <20120505125814.7fbd4312@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Bruno

On Sat, May 5, 2012 at 12:58 PM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
[snip]
>> The nicest solution probably is releasing the semaphore during
>> hid_hw_start(). That way every driver is prepared to receive data.
>> However, it's an ugly solution because we release the lock not in th=
e
>> same function as we acquire it. We also need to catch cases where
>> probe() actually did never call hid_hw_start().
>
> On probe side:
>
> Maybe instead of doing it within hid_hw_start() it could also be done
> in hid_connect() in combination of a flag on hdev->claimed.

Could you elaborate this? I don't understand what you mean.

> On remove side:
>
> Let the semaphore be taken in hid_disconnect() (instead of hid_hw_sto=
p(),
> yet again in combination with flag on hdev->claimed.
>
>
> This way probe and remove could WARN_ON() case where hdev->claim does
> not show the flag as expected (that is, assuming probe() and remove()
> can't be interlaced for the same device)
>
> Otherwise it would require one more lock or doing some of the probe
> initialization in a work queue (but that second option would make rac=
e
> conditions much more of a problem)...

My suggestion is to call up(&hdev->driver_lock) in hid_hw_start() if
some quirk is set. hid_device_probe() can then check whether the
semaphore is locked before calling up(). This way we would release the
lock before initializing a device. However, this seems ugly.

Your idea with the work queue seems much cleaner. However, there is
currently no way to make sure the work is executed _after_
hid_device_probe() releases the mutex. We could, however, introduce
some "hid_wait_until_initialized()" function that just tries to take
the semaphore and make the work wait until the hid_device_probe
finishes.

Maybe Jiri can comment here. But I think picolcd is broken and not the
semaphore. If I have some time I will try to send a fix for that. I do
not have the hardware, though, so I cannot test it.

> Thanks,
> Bruno

Cheers
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
