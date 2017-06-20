From: =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Subject: =?UTF-8?Q?Dell_clickpad_=e2=80=93_physical_clicks_no_longer_work_in?=
 =?UTF-8?Q?_4.11+?=
Date: Tue, 20 Jun 2017 10:35:58 +0300
Message-ID: <25650faf-0573-f239-91a0-b848fe034dfe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34176 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFTHgC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 03:36:02 -0400
Received: by mail-wr0-f177.google.com with SMTP id 77so86524356wrb.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jun 2017 00:36:02 -0700 (PDT)
Received: from ?IPv6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? (frost.nullroute.eu.org. [2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id y77sm7898543wrb.39.2017.06.20.00.35.59
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 00:36:00 -0700 (PDT)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have a Dell Inspiron 15-5547 with a Synaptics clickpad. Starting with
4.11.x kernels (and up to 4.12-rc6) the touchpad no longer reports
physical clicks, and `lsinput -vv` doesn't even show BTN_LEFT on it.

Everything else (taps, multitouch) seems to work fine. As far as I can
tell, all the kernel config options are enabled, the same modules are
loaded, it's being detected as a RMI touchpad in both cases (although
apparently a different version or something?)

[dmesg - 4.10.13 good]
> hid-rmi 0018:06CB:2934.0001: Scanning PDT...
> hid-rmi 0018:06CB:2934.0001: Found F34 on page 0x00
> hid-rmi 0018:06CB:2934.0001: Found F01 on page 0x00
> hid-rmi 0018:06CB:2934.0001: Found F11 on page 0x00
> hid-rmi 0018:06CB:2934.0001: Found F54 on page 0x01
> hid-rmi 0018:06CB:2934.0001: Found F30 on page 0x01
> hid-rmi 0018:06CB:2934.0001: Found F55 on page 0x02
> hid-rmi 0018:06CB:2934.0001: rmi_scan_pdt: Done with PDT scan.
> hid-rmi 0018:06CB:2934.0001: rmi_populate_f11: size in mm: 102 x 77
> hid-rmi 0018:06CB:2934.0001: firmware id: 1541093
> input: DLL063E:00 06CB:2934 as /devices/pci0000:00/INT33C3:00/i2c-8/i2c-DLL063E:00/0018:06CB:2934.0001/input/input14
> hid-rmi 0018:06CB:2934.0001: input,hidraw0: I2C HID v1.00 Pointer [DLL063E:00 06CB:2934] on i2c-DLL063E:00
[dmesg - 4.12-rc6 bad]
> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: s3203, fw id: 1541093
> input: Synaptics s3203 as /devices/pci0000:00/INT33C3:00/i2c-8/i2c-DLL063E:00/0018:06CB:2934.0001/input/input16
> hid-rmi 0018:06CB:2934.0001: input,hidraw0: I2C HID v1.00 Pointer [DLL063E:00 06CB:2934] on i2c-DLL063E:00

-- 
Mantas Mikulėnas <grawity@gmail.com>
