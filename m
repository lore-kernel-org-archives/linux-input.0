From: Forconi <forconi@wavecomm.it>
Subject: eGalaxy Touchscreen problems
Date: Wed, 21 Nov 2012 11:28:17 +0000 (UTC)
Message-ID: <1070260799.1532465.1353497297845.JavaMail.root@zmail.sgconsulting.it>
References: <1281149537.1506726.1353426918343.JavaMail.root@zmail.sgconsulting.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zmail.sgconsulting.it ([174.143.207.116]:38545 "EHLO
	zmail.sgconsulting.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab2KULch (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 06:32:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by zmail.sgconsulting.it (Postfix) with ESMTP id 0C3A818944
	for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 11:28:24 +0000 (UTC)
Received: from zmail.sgconsulting.it ([127.0.0.1])
	by localhost (zmail.sgconsulting.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4A6h8h2Rcc8I for <linux-input@vger.kernel.org>;
	Wed, 21 Nov 2012 11:28:18 +0000 (UTC)
Received: from zmail.sgconsulting.it (zmail.sgconsulting.it [174.143.207.116])
	by zmail.sgconsulting.it (Postfix) with ESMTP id 01670188FD
	for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 11:28:18 +0000 (UTC)
In-Reply-To: <1281149537.1506726.1353426918343.JavaMail.root@zmail.sgconsulting.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input  <linux-input@vger.kernel.org>

Hi,
I'm facing some problems using an eGalax (EXC7700) USB Touch Screen Controller on my development board.
On the board I'm currently using Ubuntu Server 12.04 LTS as distribution, with kernel 3.2.0-33-generic, and no X.org.


The "Input Section" in kernel config file is configured this way:

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5520=m
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_STMPE=m
CONFIG_KEYBOARD_TC3589X=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_OLPC=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_INPORT=m
# CONFIG_MOUSE_ATIXL is not set
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_WACOM=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_HTCPEN=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_UCB1400=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMPE=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
CONFIG_INPUT_AB8500_PONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX8925_ONKEY=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_MPU3050=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_WISTRON_BTNS=m
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m


The option CONFIG_TOUCHSCREEN_USB_EGALAX is enabled in kernel (=y).

When system boot up dmesg show these lines:

[    6.238961] usbcore: registered new interface driver usbtouchscreen
[    6.268757] input: USBPS2 as /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/input/input3
[    6.269235] generic-usb 0003:0D3D:0001.0001: input,hidraw0: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:1d.1-1/input0
[    6.287461] input: USBPS2 as /devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.1/input/input4
[    6.288098] generic-usb 0003:0D3D:0001.0002: input,hidraw1: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:1d.1-1/input1
[    6.309506] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input/input5
[    6.310244] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input/input6
[    6.311000] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input/input7
[    6.311548] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input/input8
[    6.312426] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input/input9
[    6.617610] usbcore: registered new interface driver usbhid
[    6.617619] usbhid: USB HID core driver

But if I look into /sys/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0 there's no input directory and none of input6, input7, input8, input9, input10. 
Moreover in  /proc/bus/input/devices there isn't anything related to egalax touch controller.

Do I have to load some other module to make it work?

I post the output of some commands that could be useful to understand which could be the problem.

lsusb -v:
Bus 003 Device 003: ID 0eef:0001 D-WAV Scientific Co., Ltd eGalax TouchScreen
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0eef D-WAV Scientific Co., Ltd
  idProduct          0x0001 eGalax TouchScreen
  bcdDevice            1.00
  iManufacturer           1 eGalax Inc.
  iProduct                2 USB TouchController
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          1 eGalax Inc.
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               2.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     322
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               3
        ** UNRECOGNIZED:  19 ff 42 49 53 54 00 01 02 03 ff 00 00 00 00 00 01 04 b8 0b 02 05 b8 0b 00
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled


ls -l /dev/input/:
total 0
drwxr-xr-x 2 root root    100 nov 21 11:56 by-id
drwxr-xr-x 2 root root    100 nov 21 11:56 by-path
crw-r----- 1 root root 13, 64 nov 21 11:56 event0
crw-r----- 1 root root 13, 65 nov 21 11:56 event1
crw-r----- 1 root root 13, 66 nov 21 11:56 event2
crw-r----- 1 root root 13, 67 nov 21 11:56 event3
crw-r----- 1 root root 13, 68 nov 21 11:56 event4
crw-r----- 1 root root 13, 69 nov 21 11:56 event5
crw-r----- 1 root root 13, 70 nov 21 11:56 event6
crw-r----- 1 root root 13, 71 nov 21 11:56 event7
crw-r----- 1 root root 13, 72 nov 21 11:56 event8
crw-r----- 1 root root 13, 73 nov 21 11:56 event9
crw-r----- 1 root root 13, 63 nov 21 11:56 mice
crw-r----- 1 root root 13, 32 nov 21 11:56 mouse0

ls -l /dev/input/by-id/:
total 0
lrwxrwxrwx 1 root root 9 nov 21 11:56 usb-0d3d_USBPS2-event-kbd -> ../event3
lrwxrwxrwx 1 root root 9 nov 21 11:56 usb-0d3d_USBPS2-if01-event-mouse -> ../event4
lrwxrwxrwx 1 root root 9 nov 21 11:56 usb-0d3d_USBPS2-if01-mouse -> ../mouse0

lsmod:
Module                  Size  Used by
snd_hda_codec_realtek   174313  1
snd_hda_codec_hdmi     31775  1
psmouse                96684  0
serio_raw              13027  0
cedarview_gfx         381339  1
snd_hda_intel          32765  0
snd_hda_codec         109562  3 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel
ttm                    64734  1 cedarview_gfx
drm_kms_helper         32561  1 cedarview_gfx
snd_hwdep              13276  1 snd_hda_codec
snd_pcm                80845  3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
e1000e                139997  0
snd_timer              28931  1 snd_pcm
snd                    62064  7 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
drm                   196349  3 cedarview_gfx,ttm,drm_kms_helper
i2c_algo_bit           13199  1 cedarview_gfx
soundcore              14635  1 snd
snd_page_alloc         14115  2 snd_hda_intel,snd_pcm
video                  19068  1 cedarview_gfx
binfmt_misc            17292  1
joydev                 17393  0
usbhid                 41906  0
hid                    77392  1 usbhid
usbtouchscreen         18128  0
mac_hid                13077  0
lp                     17455  0
parport                40930  1 lp
usb_storage            39646  0
ext2                   67987  1



Regards,
Samuele Forconi.
