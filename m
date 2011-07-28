From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 06/16] HID: wiimote: Enable accelerometer on request
Date: Thu, 28 Jul 2011 21:01:34 +0200
Message-ID: <CANq1E4SL1JVLw4F2pffoZtZSaskNbNkhW-1cVGgnPr02--J+uw@mail.gmail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
	<1311869316-17128-7-git-send-email-dh.herrmann@googlemail.com>
	<201107282008.55404.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55820 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab1G1TBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 15:01:35 -0400
Received: by vxh35 with SMTP id 35so2136374vxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 12:01:35 -0700 (PDT)
In-Reply-To: <201107282008.55404.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

On Thu, Jul 28, 2011 at 8:08 PM, Oliver Neukum <oneukum@suse.de> wrote:
> Am Donnerstag, 28. Juli 2011, 18:08:26 schrieb David Herrmann:
>> The wiimote has an internal accelerometer which can report data to t=
he host.
>> Userspace may now write to a new sysfs file to make the driver enabl=
e
>> accelerometer reporting. This is not enabled by default to reduce po=
wer
>> consumption of the wiimote. Accelerometer data is reported every few
>> milliseconds and thus consumes much bluetooth bandwidth which costs =
much energy
>> of the wiimote.
>> By writing 0 to the sysfs file, accelerometer reporting is disabled =
again.
>
> This is an odd interface. Why can't you request the accelerometer dat=
a when
> a device file dedicated to the accelerometer is opened?

The API consists of sysfs and an input device. There is no way to be
able to see when accelerometer data is requested. Of course, I could
use ->open() callback on the input-layer. However, many use cases do
not require accelerometer data and bluetooth traffic is increased
heavily when accelerometer reports are enabled.
=46or instance if you only need button-reports, then one package per
button press is transmitted. With accelerometer reports, every 5ms a
package is transmitted. And the battery of the wiimote is quite
small...

I could create multiple input interfaces, one for button data, one for
accelerometer, one for IR etc. however, how can userspace know which
one is for which interface BEFORE opening it? It could open all of
them and close the ones it doesn't need, but is that better than
having a sysfs attribute?

I can see the problem with my approach. If multiple applications use
the wiimote and one disables the accelerometer, then the other
application has it also disabled. However, what other API would be
more appropriate here?

A char-dev would make the interface very easy but I tried to avoid
cdevs and ioctl()s since I was told so.

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
