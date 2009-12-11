From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Subject: Re: Duplicated driver for LIS302-like device.
Date: Fri, 11 Dec 2009 14:16:49 +0100
Message-ID: <4B224641.8050905@tremplin-utc.net>
References: <4B21B40B.2010007@0xlab.org> <4B2241D0.3050504@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:26303 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbZLKNQs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 08:16:48 -0500
In-Reply-To: <4B2241D0.3050504@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Hsu <matt@0xlab.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Samu Onkalo <samu.p.onkalo@nokia.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>

(Thank you Jonathan for the CC!)
On 11-12-09 13:57, Jonathan Cameron wrote:
> Hi Matt
>>
>> Recently I was managed to make LIS302DL device work on Beagleboard.
>> It's almost done.
>>
>> The last thing I would like to do is to commit the driver to upstrea=
m.
>> Here comes a problem. I found there's a similar driver named lis3lv0=
2d.c.
>> which is located drivers/hwmon/. They are pretty much the same.
>> Only registers mapping is different slightly.
> Firstly that would make emailing lm-sensors more sensible than linux-=
input
> but what the heck,  some of us read both. Also for queries like this =
copy
> in the maintainer of the driver you are asking about.
>>
>> Originally, I plan to use this driver directly instead of implementi=
ng
>> another lis302dl-like driver.
>> Unfortunately, this driver is dependent on ACPI subsystem.
>> The target platform for this device is based on ARM.
>> Therefore, I could not re-use this driver for my work
>> and re-implement it based on I2C interface.
> Gah, Not again!  So far we have had two patch sets implementing just
> this.  Looking at the latest from Samu, Eric's patch has been sent on
> to Andrew Morton for the current merge window (and is listed as being=
 in
> his mm tree).  May even have merged since I last pulled mainline.
>=20
> You have my sympathies as the whole duplicating work thing happens to
> us all from time to time.  The answer is as ever, post early and post
> often to the relevant mailing lists. (though of course hardly anyone
> actually keeps to this!)
>=20
Hi Matt,

As Jonathan said, it seems most of what you look for (support of
lis302dl via I=B2C) is now present as a patch series in mmotm. Please h=
ave
a look at http://userweb.kernel.org/~akpm/mmotm/broken-out/ , where you
should find ~11 patches for lis3*. You need to check
http://userweb.kernel.org/~akpm/mmotm/series for knowing the correct
order to apply them. I expect them to be sent to Linus for 2.6.33 withi=
n
a few days.

Hopefully, what you need is already there. Well, of course it depends
also on what interface you need in userspace for the hardware. There is
currently only position reporting (via joystick interface and sysfs
file), freefall detection (via a misc device) and selftest (via sysfs
file). Let me know if you have additional features in your
implementation, or some bug fixes, and we could incorporate them in the
lis3lv02d driver.

See you,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
