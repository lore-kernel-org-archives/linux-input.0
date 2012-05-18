From: =?ISO-8859-1?Q?=C9ric_Piel?= <e.a.b.piel@tudelft.nl>
Subject: Re: Rotation Sensor in EEE Slate
Date: Fri, 18 May 2012 18:04:39 +0200
Message-ID: <4FB67317.1060404@tudelft.nl>
References: <20120518094959.GB10073@engine.Speedport_W723_V_Typ_A_1_00_092>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:60897 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab2ERQes (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 May 2012 12:34:48 -0400
In-Reply-To: <20120518094959.GB10073@engine.Speedport_W723_V_Typ_A_1_00_092>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: linux-input@vger.kernel.org

On 18/05/12 11:49, Cedric Sodhi wrote:
> Hello everyone,
>
> my EEE Slate Tablet PC just returned from repairs where it had Window=
s
> reinstalled. This enables me to verify that it actually *does* have a
> rotation sensor - something, of which I had not been so certain since=
 I
> installed Linux, because I found no trace of any such device on the P=
CI
> Bus(ses).
>
> Windows Shows "Asus G Sensor", Location "Unknown". Before I go about
> uninstalling Windows, is there any more information I could try to
> obtain? Do you have any idea how to get this sensor working in Linux?
Hi,
This is a bit a shot in the dark, but I've seen that there are some x86=
=20
Asus tablets which got android support. Apparently the accelerometer=20
support is done via an extension to the "asus-laptop" module (which=20
work via special ACPI interfaces). See:
https://github.com/rbraken/wetab-ICS-device-tree/blob/master/kernel_mod=
s/asus-laptop/asus-laptop.c

Maybe your hardware has the same/similar interface to the accelerometer=
=2E=20
=46or a quick look, you could try to strings/disassemble the ACPI table=
s=20
and look for a method like "XLRX".

Well, all said, none of this requires Windows, sorry ;-)

Good luck!
=C9ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
