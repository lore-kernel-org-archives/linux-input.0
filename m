From: Alexander Babayants <babayants.alexander@gmail.com>
Subject: PROBLEM: atkbd: Incorrect (?) handling of BAT from laptop PS/2 keyboard
Date: Sun, 2 Jul 2017 04:37:00 +0300
Message-ID: <CAB92dJa_+rPkoRYeZqqoxKCEi68Ru6b8Q4waY=QSydqTWQEYJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35334 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbdGBBhD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Jul 2017 21:37:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id u23so14266571wma.2
        for <linux-input@vger.kernel.org>; Sat, 01 Jul 2017 18:37:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

HP Pavilion 15 keyboard controller sometimes (as far as I've found, at
least after keyboard (re-)connection and LED status change) emits 0xAA
scancode (BAT passed) and key-up events for LCtrl, LAlt, RCtrl, RAlt,
RShift. This, in turn, causes the keyboard to reconnect
(drivers/input/keyboard/atkbd.c, line 424) and to emit 0xAA scancode
again, which results in keyboard being stuck in endless loop of
reconnecting. While in this loop, keyboard is usable, but some
keystrokes are being occasionally dropped.
Is it necessary to handle BAT scancode in such particular way?
Couldn't it just be ignored?

Kernel version: Linux version 4.11.7-1-ARCH (builduser@tobias) (gcc
version 7.1.1 20170621 (GCC) ) #1 SMP PREEMPT Sat Jun 24 09:07:09 CEST
2017

- evtest output:
Input driver version is 1.0.1
Input device ID: bus 0x11 vendor 0x1 product 0x1 version 0xab41
Input device name: "AT Translated Set 2 keyboard"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
    Event code 5 (KEY_4)
    Event code 6 (KEY_5)
    Event code 7 (KEY_6)
    Event code 8 (KEY_7)
    Event code 9 (KEY_8)
    Event code 10 (KEY_9)
    Event code 11 (KEY_0)
    Event code 12 (KEY_MINUS)
    Event code 13 (KEY_EQUAL)
    Event code 14 (KEY_BACKSPACE)
    Event code 15 (KEY_TAB)
    Event code 16 (KEY_Q)
    Event code 17 (KEY_W)
    Event code 18 (KEY_E)
    Event code 19 (KEY_R)
    Event code 20 (KEY_T)
    Event code 21 (KEY_Y)
    Event code 22 (KEY_U)
    Event code 23 (KEY_I)
    Event code 24 (KEY_O)
    Event code 25 (KEY_P)
    Event code 26 (KEY_LEFTBRACE)
    Event code 27 (KEY_RIGHTBRACE)
    Event code 28 (KEY_ENTER)
    Event code 29 (KEY_LEFTCTRL)
    Event code 30 (KEY_A)
    Event code 31 (KEY_S)
    Event code 32 (KEY_D)
    Event code 33 (KEY_F)
    Event code 34 (KEY_G)
    Event code 35 (KEY_H)
    Event code 36 (KEY_J)
    Event code 37 (KEY_K)
    Event code 38 (KEY_L)
    Event code 39 (KEY_SEMICOLON)
    Event code 40 (KEY_APOSTROPHE)
    Event code 41 (KEY_GRAVE)
    Event code 42 (KEY_LEFTSHIFT)
    Event code 43 (KEY_BACKSLASH)
    Event code 44 (KEY_Z)
    Event code 45 (KEY_X)
    Event code 46 (KEY_C)
    Event code 47 (KEY_V)
    Event code 48 (KEY_B)
    Event code 49 (KEY_N)
    Event code 50 (KEY_M)
    Event code 51 (KEY_COMMA)
    Event code 52 (KEY_DOT)
    Event code 53 (KEY_SLASH)
    Event code 54 (KEY_RIGHTSHIFT)
    Event code 55 (KEY_KPASTERISK)
    Event code 56 (KEY_LEFTALT)
    Event code 57 (KEY_SPACE)
    Event code 58 (KEY_CAPSLOCK)
    Event code 59 (KEY_F1)
    Event code 60 (KEY_F2)
    Event code 61 (KEY_F3)
    Event code 62 (KEY_F4)
    Event code 63 (KEY_F5)
    Event code 64 (KEY_F6)
    Event code 65 (KEY_F7)
    Event code 66 (KEY_F8)
    Event code 67 (KEY_F9)
    Event code 68 (KEY_F10)
    Event code 69 (KEY_NUMLOCK)
    Event code 70 (KEY_SCROLLLOCK)
    Event code 71 (KEY_KP7)
    Event code 72 (KEY_KP8)
    Event code 73 (KEY_KP9)
    Event code 74 (KEY_KPMINUS)
    Event code 75 (KEY_KP4)
    Event code 76 (KEY_KP5)
    Event code 77 (KEY_KP6)
    Event code 78 (KEY_KPPLUS)
    Event code 79 (KEY_KP1)
    Event code 80 (KEY_KP2)
    Event code 81 (KEY_KP3)
    Event code 82 (KEY_KP0)
    Event code 83 (KEY_KPDOT)
    Event code 85 (KEY_ZENKAKUHANKAKU)
    Event code 86 (KEY_102ND)
    Event code 87 (KEY_F11)
    Event code 88 (KEY_F12)
    Event code 89 (KEY_RO)
    Event code 90 (KEY_KATAKANA)
    Event code 91 (KEY_HIRAGANA)
    Event code 92 (KEY_HENKAN)
    Event code 93 (KEY_KATAKANAHIRAGANA)
    Event code 94 (KEY_MUHENKAN)
    Event code 95 (KEY_KPJPCOMMA)
    Event code 96 (KEY_KPENTER)
    Event code 97 (KEY_RIGHTCTRL)
    Event code 98 (KEY_KPSLASH)
    Event code 99 (KEY_SYSRQ)
    Event code 100 (KEY_RIGHTALT)
    Event code 102 (KEY_HOME)
    Event code 103 (KEY_UP)
    Event code 104 (KEY_PAGEUP)
    Event code 105 (KEY_LEFT)
    Event code 106 (KEY_RIGHT)
    Event code 107 (KEY_END)
    Event code 108 (KEY_DOWN)
    Event code 109 (KEY_PAGEDOWN)
    Event code 110 (KEY_INSERT)
    Event code 111 (KEY_DELETE)
    Event code 112 (KEY_MACRO)
    Event code 113 (KEY_MUTE)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    Event code 116 (KEY_POWER)
    Event code 117 (KEY_KPEQUAL)
    Event code 118 (KEY_KPPLUSMINUS)
    Event code 119 (KEY_PAUSE)
    Event code 121 (KEY_KPCOMMA)
    Event code 122 (KEY_HANGUEL)
    Event code 123 (KEY_HANJA)
    Event code 124 (KEY_YEN)
    Event code 125 (KEY_LEFTMETA)
    Event code 126 (KEY_RIGHTMETA)
    Event code 127 (KEY_COMPOSE)
    Event code 128 (KEY_STOP)
    Event code 138 (KEY_HELP)
    Event code 140 (KEY_CALC)
    Event code 142 (KEY_SLEEP)
    Event code 143 (KEY_WAKEUP)
    Event code 152 (KEY_SCREENLOCK)
    Event code 155 (KEY_MAIL)
    Event code 156 (KEY_BOOKMARKS)
    Event code 157 (KEY_COMPUTER)
    Event code 158 (KEY_BACK)
    Event code 159 (KEY_FORWARD)
    Event code 163 (KEY_NEXTSONG)
    Event code 164 (KEY_PLAYPAUSE)
    Event code 165 (KEY_PREVIOUSSONG)
    Event code 166 (KEY_STOPCD)
    Event code 172 (KEY_HOMEPAGE)
    Event code 173 (KEY_REFRESH)
    Event code 183 (KEY_F13)
    Event code 184 (KEY_F14)
    Event code 185 (KEY_F15)
    Event code 192 (KEY_F22)
    Event code 193 (KEY_F23)
    Event code 210 (KEY_PRINT)
    Event code 212 (KEY_CAMERA)
    Event code 217 (KEY_SEARCH)
    Event code 224 (KEY_BRIGHTNESSDOWN)
    Event code 225 (KEY_BRIGHTNESSUP)
    Event code 226 (KEY_MEDIA)
    Event code 227 (KEY_SWITCHVIDEOMODE)
    Event code 236 (KEY_BATTERY)
    Event code 238 (KEY_WLAN)
    Event code 240 (KEY_UNKNOWN)
    Event code 389 (KEY_DVD)
    Event code 465 (KEY_FN_ESC)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML) state 1
    Event code 1 (LED_CAPSL) state 0
    Event code 2 (LED_SCROLLL) state 0
Key repeat handling:
  Repeat type 20 (EV_REP)
    Repeat code 0 (REP_DELAY)
      Value    250
    Repeat code 1 (REP_PERIOD)
      Value     33
Properties:
Testing ... (interrupt to exit)
Event: time 1498956516.640301, type 17 (EV_LED), code 0 (LED_NUML), value 0
Event: time 1498956516.640301, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1c
Event: time 1498956516.640301, type 1 (EV_KEY), code 28 (KEY_ENTER), value 0
Event: time 1498956516.640301, -------------- SYN_REPORT ------------
Event: time 1498956518.123129, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1498956518.123129, -------------- SYN_REPORT ------------
Event: time 1498956518.125400, type 4 (EV_MSC), code 4 (MSC_SCAN), value 38
Event: time 1498956518.125400, -------------- SYN_REPORT ------------
Event: time 1498956518.128593, type 4 (EV_MSC), code 4 (MSC_SCAN), value 9d
Event: time 1498956518.128593, -------------- SYN_REPORT ------------
Event: time 1498956518.130724, type 4 (EV_MSC), code 4 (MSC_SCAN), value 36
Event: time 1498956518.130724, -------------- SYN_REPORT ------------
Event: time 1498956518.133846, type 4 (EV_MSC), code 4 (MSC_SCAN), value b8
Event: time 1498956518.133846, -------------- SYN_REPORT ------------
Event: time 1498956519.687889, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1498956519.687889, -------------- SYN_REPORT ------------
Event: time 1498956519.689500, type 4 (EV_MSC), code 4 (MSC_SCAN), value 38
Event: time 1498956519.689500, -------------- SYN_REPORT ------------
Event: time 1498956519.692882, type 4 (EV_MSC), code 4 (MSC_SCAN), value 9d
Event: time 1498956519.692882, -------------- SYN_REPORT ------------
Event: time 1498956519.694584, type 4 (EV_MSC), code 4 (MSC_SCAN), value 36
Event: time 1498956519.694584, -------------- SYN_REPORT ------------
Event: time 1498956519.697751, type 4 (EV_MSC), code 4 (MSC_SCAN), value b8
Event: time 1498956519.697751, -------------- SYN_REPORT ------------
Event: time 1498956521.252371, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1498956521.252371, -------------- SYN_REPORT ------------
Event: time 1498956521.254247, type 4 (EV_MSC), code 4 (MSC_SCAN), value 38
Event: time 1498956521.254247, -------------- SYN_REPORT ------------
Event: time 1498956521.257690, type 4 (EV_MSC), code 4 (MSC_SCAN), value 9d
Event: time 1498956521.257690, -------------- SYN_REPORT ------------
Event: time 1498956521.259385, type 4 (EV_MSC), code 4 (MSC_SCAN), value 36
Event: time 1498956521.259385, -------------- SYN_REPORT ------------
Event: time 1498956521.262827, type 4 (EV_MSC), code 4 (MSC_SCAN), value b8
Event: time 1498956521.262827, -------------- SYN_REPORT ------------
Event: time 1498956521.538460, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1498956521.538460, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL), value 1
Event: time 1498956521.538460, -------------- SYN_REPORT ------------
Event: time 1498956521.622548, type 4 (EV_MSC), code 4 (MSC_SCAN), value 2e
Event: time 1498956521.622548, type 1 (EV_KEY), code 46 (KEY_C), value 1
Event: time 1498956521.622548, -------------- SYN_REPORT ------------

EV_MSC with value 0xAA is not shown here, because it has code MSC_RAW,
which is ignored in the output. Keystrokes with values 1d, 38, 9d, 36,
b8 are repeated indefinitely.

- ver_linux output:
Linux summer 4.11.7-1-ARCH #1 SMP PREEMPT Sat Jun 24 09:07:09 CEST
2017 x86_64 GNU/Linux
GNU C                   7.1.1
GNU Make                4.2.1
Binutils                2.28.0.20170506
Util-linux              2.29.2
Mount                   2.29.2
Module-init-tools       24
E2fsprogs               1.43.4
Jfsutils                1.1.15
Reiserfsprogs           3.6.25
Xfsprogs                4.11.0
Pcmciautils             018
Quota-tools             4.03
PPP                     2.4.7
Linux C Library         2.25
Dynamic linker (ldd)    2.25
Linux C++ Library       6.0.23
Procps                  3.3.12
Kbd                     2.0.4
Console-tools           2.0.4
Sh-utils                8.27
Udev                    232
Modules Loaded          ac acpi_cpufreq aesni_intel aes_x86_64 ahci
amdgpu arc4 atkbd battery button ccm ccp cdrom cfg80211 crc16
crc32c_intel crc32_pclmul crct10dif_pclmul cryptd crypto_simd ctr drm
drm_kms_helper edac_core edac_mce_amd ehci_hcd ehci_pci evdev ext4
fam15h_power fat fb_sys_fops fscrypto ghash_clmulni_intel glue_helper
hid hid_generic hp_accel hp_wireless hp_wmi i2c_algo_bit i2c_piix4
i8042 input_leds input_polldev ip_tables irqbypass jbd2 joydev k10temp
kvm kvm_amd led_class libahci libata libps2 lis3lv02d mac80211 mac_hid
mbcache media memstick mii mmc_core mousedev nls_cp437 nls_iso8859_1
pcbc pcspkr psmouse r8169 radeon rfkill rng_core rtl8188ee rtl_pci
rtlwifi rtsx_pci rtsx_pci_ms rtsx_pci_sdmmc sch_fq_codel scsi_mod
sd_mod serio serio_raw shpchp snd snd_hda_codec snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel
snd_hwdep snd_pcm snd_timer soundcore sp5100_tco sparse_keymap sr_mod
syscopyarea sysfillrect sysimgblt thermal tpm tpm_tis tpm_tis_core ttm
usb_common usbcore usbhid uvcvideo vfat video videobuf2_core
videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi
xhci_hcd xhci_pci x_tables

- dmesg (the only line about keyboard):
[    6.061648] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0

I've made this quick patch and it fixed the problem for me:
--- atkbd.c.old 2017-07-02 03:43:23.962306545 +0300
+++ atkbd.c     2017-07-01 20:01:49.063264594 +0300
@@ -422,8 +422,9 @@

        switch (code) {
        case ATKBD_RET_BAT:
-               atkbd->enabled = false;
-               serio_reconnect(atkbd->ps2dev.serio);
+               // atkbd->enabled = false;
+               // serio_reconnect(atkbd->ps2dev.serio);
+               dev_warn(&serio->dev, "Got BAT on %s.\n", serio->phys);
                goto out;
        case ATKBD_RET_EMUL0:
                atkbd->emul = 1;
Though I'm not sure, is it a quirk to bypass shitty laptop PS/2
controller or is the handling of BAT in atkbd driver done wrong (why
should it reconnect the keyboard on BAT?).

Regards,
Alexander Babayants.
