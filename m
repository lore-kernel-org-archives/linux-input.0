From: Vbook A1 <vbooka1maillist@gmail.com>
Subject: Re: Silead Touchscreen i2c-MSSL1680 timeout
Date: Sun, 18 Jun 2017 16:34:38 +0700
Message-ID: <CAHsAZcB20FY2z2RV8eEJ6fcD1xk8e7v9aSk0YcLA1FWEy9UJxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:36258 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdFRJej (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Jun 2017 05:34:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org

Update: the touchscreen actually works - I have used the wrong
firmware format for the kernel module. So timeout occurs because of
the wrong firmware.

However there are two problems with the touchscreen:

1. The input is inverted (X and Y axis are swapped) - if I press the
right side of the screen (x:1920) the mouse cursor moves to the left
side (x:0), and if I press the botton of the screen (y:1080) the
cursor moves to the top (y:0).

2. But if I press the top of the screen (y:0) the cursor moves down to
about y:410 position while it should be at y:1080, and if I press the
left side of the screen (x:0) the cursor moves right to about x:930
position while it should be at x:1920. So the cursor remains on about
1/4 of the screen size, at the top-left corner.



If that helps: I have converted the Windows firmware file to the
correct format using "fwtool" from
https://github.com/onitake/gsl-firmware and here is the link to
working firmware for VOYO VBook A1 laptop:
https://github.com/onitake/gsl-firmware/files/1082972/vbook_a1_firmware.zip
Now dmesg looks like this:

 # modprobe silead
 # dmesg|tail
[99809.031393] silead_ts i2c-MSSL1680:00: Silead chip ID: 0x80360000
[99810.263633] input: silead_ts as
/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/input/input22
