From: Stefan Sauer <ensonic@google.com>
Subject: udev timeout for mma8450 unless the accelerometer is shaken
Date: Thu, 26 Feb 2015 14:05:31 +0100
Message-ID: <CAGX7z0yi5JbTUsDEZRO1EffDBi4Co6YX=NyOZ9m2uJfyPh8o_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:63305 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbBZNFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 08:05:31 -0500
Received: by mail-qa0-f52.google.com with SMTP id v10so7491778qac.11
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2015 05:05:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

hi,

on my beaglebone-black I get these lines during bootup

[   71.745951] udevd[105]: worker [113]
/devices/ocp.2/4819c000.i2c/i2c-2/2-001d/input/input2/event1 timeout;
kill it
[   71.771991] udevd[105]: seq 1243
'/devices/ocp.2/4819c000.i2c/i2c-2/2-001d/input/input2/event1' killed
[   71.799611] udevd[105]: worker [113] terminated by signal 9 (Killed)

The device is an accelerometer connected via i2c. When I shake it
during bootup I don't get these warnings. Alternative repro:
udevadm trigger --action=3Dadd --subsystem-match=3D"input" --subsystem-=
match=3D"misc"
udevadm settle

The 'udevadm settle' will block until the device is moved. Is that expe=
cted?

Stefan
--
Stefan Sauer | Software Engineer | ensonic@google.com

Google Germany GmbH | Maximilianstrasse 11-15 | 80539 M=C3=BCnchen | Ge=
rmany
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Graham Law, Christine Elizabeth Flores
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
