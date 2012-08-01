From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Problems with a Zytronic touchscreen on kernel 3.5 (USB ID 0x14c8:0x0005) - regression from kernel 3.0
Date: Wed, 01 Aug 2012 09:20:06 +0100
Message-ID: <1514977.1uDfr8LPn9@f17simon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1592850.WdSkjvLqpM"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp01.uk.clara.net ([195.8.89.34]:40778 "EHLO
	claranet-outbound-smtp01.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754289Ab2HAJhZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Aug 2012 05:37:25 -0400
Received: from 110.100.155.90.in-addr.arpa ([90.155.100.110]:38534 helo=f17simon.localnet)
	by relay01.mail.eu.clara.net (relay.clara.net [213.253.3.41]:1025)
	with esmtpsa (authdaemon_plain:simon.farnsworth@onelan.com) (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1SwUA7-00077r-4J  for linux-input@vger.kernel.org
	(return-path <simon.farnsworth@onelan.co.uk>); Wed, 01 Aug 2012 08:20:11 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--nextPart1592850.WdSkjvLqpM
Content-Type: multipart/mixed; boundary="nextPart2943450.YmARa03nvj"
Content-Transfer-Encoding: 7Bit


--nextPart2943450.YmARa03nvj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

Greg K-H pointed me this way from linux-usb; I've had no replies there, but if 
you've already seen the message on linux-usb, nothing's changed in the text 
below or the attachments.

I'm trying to get a Zytronic single-touch touchscreen to work with Linux 
kernel 3.5; it previously worked on a 3.0 kernel. I'm happy to try git kernels 
and patches, even if they're just intended to gather more information.

hid-multitouch is picking up the device because it has multitouch report 
descriptors as well as the single-touch descriptors. There's a quirk to make 
it use MT_CLS_SERIAL, but that seems to be insufficient for my needs.

I've got as far as determining that it's mt_event in hid-multitouch.c that 
consumes the events, but as the screen never sends the events hid-multitouch.c 
expects to see, mt_event nevers sends an input event.

evtest on 3.0 shows touch events as expected. evtest on 3.5 shows no touch 
events.

I've attached /sys/kernel/debug/hid/0003:14C8:0005.0001/rdesc as 
zyntronic.rdesc and /sys/kernel/debug/hid/0003:14C8:0005.0001/events while I 
touch the screen as zytronic.events.

I had evtest /dev/input/event5 running while I captured zytronic.events, and 
got the following output:

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x14c8 product 0x5 version 0x101
Input device name: "Zytronic Displays Limited Zytronic Touchscreen Controller"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min        0
      Max     4096
    Event code 1 (ABS_Y)
      Value      0
      Min        0
      Max     4096
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        9
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     4096
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     4096
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
Testing ... (interrupt to exit)
^C

Any ideas, or instructions for gathering more debug information will be 
gratefully received.
-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com

--nextPart2943450.YmARa03nvj
Content-Disposition: attachment; filename="zytronic.rdesc"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="zytronic.rdesc"

05 0d 09 04 a1 01 85 01 09 22 a1 02 09 42 15 00 25 01 75 01 95 01 81 02 09 32 95 01 81 02 95 06 81 01 05 01 26 00 10 75 10 95 01 65 00 09 30 81 02 09 31 46 00 10 81 02 05 0d 09 51 26 ff 00 75 08 95 01 81 02 c0 85 02 09 55 15 00 25 08 75 08 95 01 b1 02 c0 05 0d 09 0e a1 01 85 03 a1 02 09 23 09 52 09 53 15 00 25 08 75 08 95 02 b1 02 c0 c0 05 01 09 02 a1 01 09 01 a1 00 85 04 05 09 19 01 29 02 15 00 25 01 95 02 75 01 81 02 95 01 75 06 81 01 05 01 09 30 09 31 15 00 26 00 10 35 00 46 00 10 65 00 75 10 95 02 81 62 c0 c0 06 00 ff 09 01 a1 01 85 05 09 00 15 00 26 ff 00 75 08 95 3f b1 02 c0 06 00 ff 09 01 a1 01 85 06 09 00 15 00 26 ff 00 75 08 95 3f 81 02 c0 

  INPUT(1)[INPUT]
    Field(0)
      Logical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.TipSwitch
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Logical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.InRange
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(1)
      Report Offset(1)
      Flags( Variable Absolute )
    Field(2)
      Logical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        GenericDesktop.X
      Logical Minimum(0)
      Logical Maximum(4096)
      Report Size(16)
      Report Count(1)
      Report Offset(8)
      Flags( Variable Absolute )
    Field(3)
      Logical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        GenericDesktop.Y
      Logical Minimum(0)
      Logical Maximum(4096)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(16)
      Report Count(1)
      Report Offset(24)
      Flags( Variable Absolute )
    Field(4)
      Logical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.ContactID
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(8)
      Report Count(1)
      Report Offset(40)
      Flags( Variable Absolute )
  INPUT(4)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        Button.0001
        Button.0002
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(1)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        GenericDesktop.X
        GenericDesktop.Y
      Logical Minimum(0)
      Logical Maximum(4096)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(16)
      Report Count(2)
      Report Offset(8)
      Flags( Variable Absolute NoPreferredState NullState )
  INPUT(6)[INPUT]
    Field(0)
      Application(ff00.0001)
      Usage(63)
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(8)
      Report Count(63)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(2)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.ContactMaximumNumber
      Logical Minimum(0)
      Logical Maximum(8)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(3)[FEATURE]
    Field(0)
      Application(Digitizers.000e)
      Usage(3)
        Digitizers.0023
        Digitizers.InputMode
        Digitizers.DeviceIndex
      Logical Minimum(0)
      Logical Maximum(8)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(5)[FEATURE]
    Field(0)
      Application(ff00.0001)
      Usage(63)
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
        ff00.0000
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(4096)
      Report Size(8)
      Report Count(63)
      Report Offset(0)
      Flags( Variable Absolute )

Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Sync.Report
GenericDesktop.X ---> Absolute.MTPositionX
GenericDesktop.Y ---> Absolute.MTPositionY
Digitizers.ContactID ---> Sync.Report
Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
GenericDesktop.X ---> Absolute.X
GenericDesktop.Y ---> Absolute.Y
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
ff00.0000 ---> Sync.Report
--nextPart2943450.YmARa03nvj
Content-Disposition: attachment; filename="zytronic.events"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="zytronic.events"


report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 0f 0a c7 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 00 0f 0a c7 04
Button.0001 = 0
Button.0002 = 0
GenericDesktop.X = 2575
GenericDesktop.Y = 1223

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 13 0a cc 03
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 00 13 0a cc 03
Button.0001 = 0
Button.0002 = 0
GenericDesktop.X = 2579
GenericDesktop.Y = 972

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 01 2b 09 10 04
Button.0001 = 1
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040

report (size 6) (numbered) =  04 00 2b 09 10 04
Button.0001 = 0
Button.0002 = 0
GenericDesktop.X = 2347
GenericDesktop.Y = 1040
--nextPart2943450.YmARa03nvj--

--nextPart1592850.WdSkjvLqpM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAABAgAGBQJQGOa6AAoJEIKsye9/dtRWmHkH/0y8gxxaYv0YzW7S/bN2PyH5
9FevEM08g3CWQkNnYGMSIjLb8SDNCTqE2+ROSzzw+tkBynwtz/l7cL22INYuB5xU
JKy7K3Z0ZHxWKW6O6kYS5y5okdSCUQOBAeZFEZmVVK+JdFF179amUeiJQCAB8m9e
ZWYw6SrQAti0+rVyWxfRJYuS7d9O+L/c8IvIgP1IZCe0PnR1gBDRuwj7tg5pUWFz
uPIvOPCQ5GtcJSKxoB/M2Q40OPXsxw11laC8oal45844ahzlgJaOb7Y73ayYw+MD
nExQvl9KNrSMtiijVHin6gMhwcWsi4gyimXaiMSFycsscqECZIG+QTcrT8lrs1Q=
=pdpB
-----END PGP SIGNATURE-----

--nextPart1592850.WdSkjvLqpM--

