From: Vbook A1 <vbooka1maillist@gmail.com>
Subject: Silead Touchscreen i2c-MSSL1680 timeout
Date: Sun, 18 Jun 2017 05:37:23 +0700
Message-ID: <CAHsAZcCB7YWEQqXL4J5CTAWGk0XOxPNKAU5VXRx5Fisuz=1L0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34968 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753417AbdFQWhb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 18:37:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org

Hello,


I could not make Silead MSSL1680 touchscreen work on VOYO VBook A1
laptop, with all 4.11.* kernels, distro openSUSE 42.2.
I have not tried kernels 4.12-rc* yet. Default openSUSE 42.2 kernel
4.4.62 had the same issue (timeout).

Upstream kernel module:

 # modprobe silead
 # dmesg|tail
[33452.976963] silead_ts i2c-MSSL1680:00: Silead chip ID: 0x80360000
[33453.294532] i2c_designware i2c_designware.3:
i2c_dw_handle_tx_abort: lost arbitration
[33454.312683] i2c_designware i2c_designware.3: controller timed out
[33454.312709] silead_ts i2c-MSSL1680:00: Firmware load error -110
[33454.328827] silead_ts: probe of i2c-MSSL1680:00 failed with error -110


gslx680_ts_acpi module from https://github.com/onitake/gslx680-acpi :

 # insmod gslx680_ts_acpi.ko
 # dmesg|tail
[33483.932869] gslx680 i2c-MSSL1680:00: gsl_ts_probe: got a device
named MSSL1680:00 at address 0x40, IRQ 50, flags 0x0
[33483.933095] input: Silead GSLx680 Touchscreen as
/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/input/input17
[33485.000691] i2c_designware i2c_designware.3: controller timed out
[33485.000710] gslx680 i2c-MSSL1680:00: gsl_ts_reset_chip: gsl_ts_write 1 fail!
[33485.000712] gslx680 i2c-MSSL1680:00: gsl_ts_probe: chip reset failed
[33485.052822] gslx680: probe of i2c-MSSL1680:00 failed with error -110



/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# ls -la
total 0
drwxr-xr-x 2 root root    0 Jun 18 05:15 .
drwxr-xr-x 3 root root    0 Jun 18 05:15 ..
-rw-r--r-- 1 root root 4096 Jun 18 05:15 async
-rw-r--r-- 1 root root 4096 Jun 18 05:15 autosuspend_delay_ms
-rw-r--r-- 1 root root 4096 Jun 18 05:16 control
-r--r--r-- 1 root root 4096 Jun 18 05:15 runtime_active_kids
-r--r--r-- 1 root root 4096 Jun 18 05:15 runtime_active_time
-r--r--r-- 1 root root 4096 Jun 18 05:15 runtime_enabled
-r--r--r-- 1 root root 4096 Jun 18 05:15 runtime_status
-r--r--r-- 1 root root 4096 Jun 18 05:15 runtime_suspended_time
-r--r--r-- 1 root root 4096 Jun 18 05:15 runtime_usage
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# cat control
auto
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# echo 'enabled' > control
bash: echo: write error: Invalid argument
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# echo 'manual' > control
bash: echo: write error: Invalid argument
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# cat runtime_enabled
disabled
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# echo 'enabled' > runtime_enabled
bash: runtime_enabled: Permission denied
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# cat runtime_status
unsupported
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# cat runtime_usage
0
/sys/devices/pci0000:00/0000:00:16.3/i2c_designware.3/i2c-10/i2c-MSSL1680:00/power
# echo 1 > runtime_usage
bash: runtime_usage: Permission denied


Just in case, link to archive with original Windows firmware file and
binary firmware file converted from Windows' file:
https://github.com/onitake/gsl-firmware/files/1081950/firmware.zip


Is there anything I could try with 4.11.* kernels?
I can not try 4.12-rc* kernels currently because they don't have the
Secure Boot signature by openSUSE maintainers yet and I did not
succeed in signing them manually. The BIOS of this laptop requires the
Secure Boot to be enabled to boot Linux so I can't just disable it to
run the unsigned kernels.



Best regards
