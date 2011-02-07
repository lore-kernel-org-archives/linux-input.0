From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Touchscreen calibration data and EEPROM
Date: Mon, 7 Feb 2011 08:31:28 +0100
Message-ID: <AANLkTi=Ryb2W5sDiUERFud9W0AvCnwO2amtCKA8SRBug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56703 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1BGHbu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Feb 2011 02:31:50 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so2726517vws.19
        for <linux-input@vger.kernel.org>; Sun, 06 Feb 2011 23:31:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I am working on an embedded x86 device, which has a touchscreen
(TSC25). We wrote a basic driver for
it. With the help of the xinput_calibrator [1] it is possible to
calibrate the evdev based device and get it working.
Now I have the requirement to store the calibration data on the
touchscreen's EEPROM and I am not
sure if there is some kind of 'framework' or ioctl available.

At the moment I am running a custom script a X startup which executes
xinput set-int-prop "TSC-10/25/40 Serial TouchScreen" "Evdev Axis
Calibration" 32 868 63 602 53

[1] http://www.freedesktop.org/wiki/Software/xinput_calibrator

Thanks,
--
Christian Gmeiner, MSc
