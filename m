From: Atri Bhattacharya <badshah400@aim.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Wed, 01 Jun 2016 15:36:44 +0200
Message-ID: <1464788204.3917.9.camel@aim.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50629 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbcFANkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jun 2016 09:40:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1b86NR-0006r8-AT
	for linux-input@vger.kernel.org; Wed, 01 Jun 2016 15:40:05 +0200
Received: from 91.178.106.13 ([91.178.106.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 01 Jun 2016 15:40:05 +0200
Received: from badshah400 by 91.178.106.13 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 01 Jun 2016 15:40:05 +0200
In-Reply-To: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi!

On Mon, 2016-05-30 at 21:27 -0700, Srinivas Pandruvada wrote:
> Starting from Cherrytrail, multiple generation of Intel processors
> offers
> on package sensor hub. Several recent tablets, 2-in-1 convertible
> laptops
> are using ISH instead of external sensor hubs. This resulted in lack
> of
> support of sensor function like device rotation and auto backlight
> adjustment. In addition, depending on the OEM implementation, support
> of ISH
> is required to support low power sleep states.
>=20
> The support of ISH on Linux platforms is not new. Android platforms
> with
> Intel SoCs had this support for a while submitted by Daniel Drubin.=C2=
=A0
> This patcheset is reusing most of those changes with=C2=A0=C2=A0clean=
 up and
> removing Android platform specific changes.
>=20
> This series is tested on:
> - Lenovo Yoga 260 with Skylake processor
> - HP Pavilion x2 detachable with Cherrytrail=C2=A0
>=20
> The user mode ABI is still same as external sensor hubs using Linux
> IIO. So existing user mode software should still work without change.
> This series primarily brings in new HID transport used in ISH.
>=20
> This series submitted as a RFC to try on several devices. We have=C2=A0
> received request from Linux users who wanted this support. So I hope
> all
> those users try and give feedback.
>=20

Thanks a lot for adding support for this. I have a Lenovo Thinkpad Yoga
260, so I decided to give it a try. I used your patches on kernel 4.6.0
and installed the patched kernel. Now, I see that the device is
recognised immediately. I use the iio-sensor-proxy application from
[1], and it now recognises the sensors. But changing orientation
doesn't seem to do anything, and moreover upon a wakeup from suspend I
see the following messages on the journal:

Jun 01 15:15:09 tp-yoga260 kernel: [drm] RC6 on
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0001:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub 0044:8086:22D8.0002:
timeout waiting for response from ISHTP device
Jun 01 15:15:09 tp-yoga260 kernel: PM: resume of devices complete after
37095.288 msecs

Also suspend and wakeup seems to be really slow now. Please let me know
if there is any other info I can provide.

Thanks and best wishes.

[1]=C2=A0https://github.com/hadess/iio-sensor-proxy

--=20
Atri Bhattacharya
Wed  1 Jun 15:22:32 CEST 2016

Sent from openSUSE Tumbleweed (20160529) (x86_64) on my laptop.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
