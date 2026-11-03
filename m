Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671803;
	b=YC1EaC9ToBTHnHzb5MRJHfvPB0w4pvlEfvfWuEWVlMCfXqoj8AScCdSrbdRfxfGxz/4l
	 WWC08SN1k29Ds4j2Y+IKma8vx2sSNOFVY1mGVxXTMn1g81Dcf58nfb+Q4zXefKgBhB4Iw
	 4bDeVNWO7hjlspeTV1qbbCmvMFSAoYhMA3KxbV5auyBYkJCMg6vJRjOu2yyeNQqCxWfZO
	 5pCd2BgRRsJjH6RS/A2h8omaBb1ZHDhaU9IV3AOhjPhY2DvGZX8uYoYgWlg4ikwWzfjh+
	 6Lhmfvkmn57hHaecJE3uV2FXexF+piAyYOKXp9hwaqdpk2q4KE2GsnTPjL2ThmmjzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eQyd1wB33z8QNs5KXVh+zUW98Oo8J5d0CgkSSg6bj2o=;
	b=hTppAcblOd002cAYNNYig3Fdw4fb3QbqRz7ePgy3RcIGQKhnlhUBEist6w/DjBpJZkP2
	 0ArJlgeNe8BNHCIeYDyk9VvGhCTo1IaJw8w0/PiI+qw0mMhApc8e10m7F+aU/s9EqN5LW
	 wahU6Rcey7BTfyRvH99qGcRXcaRL6ytAn4iRSrimhAGwTCvERUxi5sxlCu7TXDIjn1+mH
	 vjeURpl8V1piXB3WU3d8pZ7c+TLR2URGX49ofdTf5YACwtikMTPAqJ20eOq2iOkKMXbQt
	 nNHHc3vVQrY7LOHfl7Pe4q4TeEPe8REwRfeOuL4uVbEadYVVZr2bc9zNlYeJZ78lESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8vf0uvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188D606A327
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8vf0uvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4A41F000C1;
	Tue,  3 Nov 2026 02:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793671802;
	bh=eQyd1wB33z8QNs5KXVh+zUW98Oo8J5d0CgkSSg6bj2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8vf0uvJuK9zYs9bbq3Wq54QyjVXPFAV7xP2JdTyg729ZL58UCLb8aoedXnqKl0T3
	 0qoqoAwUtDWViymdG6ouCnCQ4UNlde/Ah6bi34AiV+Pr6z3DhSBnYeiJQw9dSaZIcp
	 ki4vJwm+ssD9Cjgnvi/p7L58OAp8NQII6z/jxCt2i231Tm6kKKlfWpNTpV4r103qfR
	 /Ru4iq3j55X/lZNV6o/NZ745T+o23F5ROAfwmNIxu3w0Sxtpan+GF/tfUXcJqunKCo
	 YCAOAdBRO+lFLeaFQsH/wWZcC7Jm5o+w7QqNEOBNh6nDqup4n3rfEFCk9CSLxA+RHm
	 uoAi5K4Lqm3oA==
Message-ID: <sashiko-outbox-194448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sensor-custom: Synchronize misc-device teardown
 with file lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>
References: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:10:02 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] HID: sensor-custom: race in hid_sensor_custom_open() on remova=
l causes UAF
- [Critical] HID: sensor-custom: UAF on remove_wait in hid_sensor_custom_re=
lease()
- [High] HID: sensor-custom: uninterruptible wait in remove() hangs device =
teardown
--

commit 675e46b087ebefd9837f6bd3d07f849dbaf943f6
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

HID: sensor-custom: Synchronize misc-device teardown with file lifetime

This commit synchronizes the HID sensor custom misc-device teardown with
open file descriptors by adding a removing flag and a remove_wait waitqueue
so that removal waits for the file to close before deregistering the misc
device and freeing the FIFO.

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index c2b425afd951b..c9338ae47050a 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c

[ ... ]

> @@ -684,6 +698,7 @@ static int hid_sensor_custom_release(struct inode *in=
ode, struct file *file)
>  				   struct hid_sensor_custom, custom_dev);
> =20
>  	clear_bit(0, &sensor_inst->misc_opened);
> +	wake_up_all(&sensor_inst->remove_wait);

[Severity: Critical]
Can this trigger a use-after-free on sensor_inst->remove_wait in
hid_sensor_custom_release() in drivers/hid/hid-sensor-custom.c when
userspace closes the file descriptor concurrently with device removal?

As soon as hid_sensor_custom_release() executes clear_bit() on
sensor_inst->misc_opened, another CPU in hid_sensor_custom_dev_if_remove()
can observe !test_bit(0, &sensor_inst->misc_opened) in wait_event(), finish
misc_deregister() and kfifo_free(), and return from
hid_sensor_custom_remove(), which allows devres to free sensor_inst:

CPU 0                                 CPU 1
hid_sensor_custom_release()           hid_sensor_custom_remove()
  clear_bit(0,                          hid_sensor_custom_dev_if_remove()
    &sensor_inst->misc_opened);           wait_event(sensor_inst->remove_wa=
it,
                                            !test_bit(0, &sensor_inst->misc=
_opened));
                                          misc_deregister(&sensor_inst->cus=
tom_dev);
                                          kfifo_free(&sensor_inst->data_fif=
o);
                                        /* devm frees sensor_inst */
  wake_up_all(&sensor_inst->remove_wait); /* UAF on sensor_inst->remove_wai=
t */

In addition, clear_bit() is a relaxed atomic operation and does not provide
a memory barrier before wake_up_all().

> =20
>  	return 0;
>  }
> @@ -694,6 +709,8 @@ static int hid_sensor_custom_open(struct inode *inode=
, struct file *file)
> =20
>  	sensor_inst =3D container_of(file->private_data,
>  				   struct hid_sensor_custom, custom_dev);
> +	if (READ_ONCE(sensor_inst->removing))
> +		return -ENODEV;
>  	/* We essentially have single reader and writer */
>  	if (test_and_set_bit(0, &sensor_inst->misc_opened))
>  		return -EBUSY;

[Severity: Critical]
What prevents hid_sensor_custom_open() in drivers/hid/hid-sensor-custom.c
from racing with hid_sensor_custom_dev_if_remove() when userspace opens the
misc device concurrently with removal?

Because misc_deregister(&sensor_inst->custom_dev) is called after
WRITE_ONCE(sensor_inst->removing, true) and wait_event(), misc_open() can
still invoke hid_sensor_custom_open() while teardown is starting. Checking
sensor_inst->removing and setting bit 0 in sensor_inst->misc_opened are not
serialized against hid_sensor_custom_dev_if_remove(), nor is
sensor_inst->removing rechecked after test_and_set_bit():

CPU 0                                 CPU 1
hid_sensor_custom_open()              hid_sensor_custom_dev_if_remove()
  if (READ_ONCE(sensor_inst->removing))
    /* sees false */
                                        WRITE_ONCE(sensor_inst->removing, t=
rue);
                                        wake_up_all(&sensor_inst->wait);
                                        wait_event(sensor_inst->remove_wait,
                                          !test_bit(0, &sensor_inst->misc_o=
pened));
                                        /* misc_opened is still 0, returns =
*/
  test_and_set_bit(0,
    &sensor_inst->misc_opened);
  stream_open(inode, file);
                                        misc_deregister(&sensor_inst->custo=
m_dev);
                                        kfifo_free(&sensor_inst->data_fifo);
                                        /* devm frees sensor_inst */

Wouldn't this leave userspace with an open file descriptor whose
file->private_data points into freed sensor_inst and freed
sensor_inst->data_fifo on subsequent hid_sensor_custom_read(),
hid_sensor_custom_poll(), or hid_sensor_custom_release() calls?

[ ... ]

> @@ -751,10 +772,12 @@ static int hid_sensor_custom_dev_if_add(struct hid_=
sensor_custom *sensor_inst)
>  static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
>  								*sensor_inst)
>  {
> -	wake_up(&sensor_inst->wait);
> +	WRITE_ONCE(sensor_inst->removing, true);
> +	wake_up_all(&sensor_inst->wait);
> +	wait_event(sensor_inst->remove_wait,
> +		   !test_bit(0, &sensor_inst->misc_opened));
>  	misc_deregister(&sensor_inst->custom_dev);

[Severity: High]
Won't waiting with wait_event() in hid_sensor_custom_dev_if_remove() in
drivers/hid/hid-sensor-custom.c hang device removal in uninterruptible sleep
if a userspace process holds an open file descriptor without immediately
closing it?

When hid_sensor_custom_remove() calls hid_sensor_custom_dev_if_remove(), the
removing thread blocks in TASK_UNINTERRUPTIBLE until userspace invokes
close() and triggers hid_sensor_custom_release(). A process holding the fd
open may be idle, sleeping on another event, stopped, or waiting for a udev
remove notification before closing the device.

Furthermore, because misc_deregister(&sensor_inst->custom_dev) is called
only after wait_event() returns, device_destroy() on the misc device and the
removal uevent are delayed until the fd is already closed, which can
deadlock a userspace daemon that relies on the remove uevent to close its
file descriptor.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103015734.5786=
13-1-srinivas.pandruvada@linux.intel.com?part=3D1
