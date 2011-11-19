From: Cedric Sodhi <manday@gmx.net>
Subject: HID-Multitouch: eGalax Touchscreen Pressure
Date: Sat, 19 Nov 2011 08:00:59 +0100
Message-ID: <20111119070059.GA2167@slate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:48556 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750905Ab1KSHBa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Nov 2011 02:01:30 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everybody

After I finally got the touchscreen to work thanks to Benjamin, there
remains one little issue for the eGalax 0eef:a001

I'm pretty sure one could measure the pressure by which the finger(s)
touches the screeen. Currently, even coming close to the surface is
taken as a touch land. Here is the rdesc. If it is does not report such
a capability, then something is wrong, I think. I cannot recall having
had such overly responsive behaviour under windows.

How to add support for finger-pressure?

Cedric

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rdesc

05 0d 09 04 a1 01 85 04 09 22 a1 00 09 42 15 00 25 01 75 01 95 01 81 02 09 32 15 00 25 01 81 02 09 51 75 05 95 01 16 00 00 26 10 00 81 02 09 47 75 01 95 01 15 00 25 01 81 02 05 01 09 30 75 10 95 01 55 0d 65 33 35 00 46 23 28 26 ff 7f 81 02 09 31 75 10 95 01 55 0d 65 33 35 00 46 11 19 26 ff 7f 81 02 05 0d 09 55 25 08 75 08 95 01 b1 02 c0 c0 05 01 09 01 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 95 02 75 01 81 02 95 01 75 06 81 01 05 01 09 30 09 31 16 00 00 26 ff 0f 36 00 00 46 ff 0f 66 00 00 75 10 95 02 81 02 c0 c0 06 00 ff 09 01 a1 01 09 01 15 00 26 ff 00 85 03 75 08 95 3f 81 02 06 00 ff 09 01 15 00 26 ff 00 75 08 95 3f 91 02 c0 05 0d 09 0e a1 01 85 05 09 22 a1 00 09 52 09 53 15 00 25 0a 75 08 95 02 b1 02 c0 c0 

  INPUT(4)[INPUT]
    Field(0)
      Physical(Digitizers.Finger)
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
      Physical(Digitizers.Finger)
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
      Physical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.ContactID
      Logical Minimum(0)
      Logical Maximum(16)
      Report Size(5)
      Report Count(1)
      Report Offset(2)
      Flags( Variable Absolute )
    Field(3)
      Physical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.Confidence
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(1)
      Report Offset(7)
      Flags( Variable Absolute )
    Field(4)
      Physical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        GenericDesktop.X
      Logical Minimum(0)
      Logical Maximum(32767)
      Physical Minimum(0)
      Physical Maximum(10275)
      Unit Exponent(13)
      Unit(English Linear : Inch^3)
      Report Size(16)
      Report Count(1)
      Report Offset(8)
      Flags( Variable Absolute )
    Field(5)
      Physical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        GenericDesktop.Y
      Logical Minimum(0)
      Logical Maximum(32767)
      Physical Minimum(0)
      Physical Maximum(6417)
      Unit Exponent(13)
      Unit(English Linear : Inch^3)
      Report Size(16)
      Report Count(1)
      Report Offset(24)
      Flags( Variable Absolute )
  INPUT(1)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Pointer)
      Usage(2)
        Button.0001
        Button.0002
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(0)
      Physical Maximum(6417)
      Unit Exponent(13)
      Unit(English Linear : Inch^3)
      Report Size(1)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Pointer)
      Usage(2)
        GenericDesktop.X
        GenericDesktop.Y
      Logical Minimum(0)
      Logical Maximum(4095)
      Physical Minimum(0)
      Physical Maximum(4095)
      Unit Exponent(13)
      Report Size(16)
      Report Count(2)
      Report Offset(8)
      Flags( Variable Absolute )
  INPUT(3)[INPUT]
    Field(0)
      Application(ff00.0001)
      Usage(63)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(4095)
      Unit Exponent(13)
      Report Size(8)
      Report Count(63)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(3)[OUTPUT]
    Field(0)
      Application(ff00.0001)
      Usage(63)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(4095)
      Unit Exponent(13)
      Report Size(8)
      Report Count(63)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(4)[FEATURE]
    Field(0)
      Physical(Digitizers.Finger)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.ContactMaximumNumber
      Logical Minimum(0)
      Logical Maximum(8)
      Physical Minimum(0)
      Physical Maximum(6417)
      Unit Exponent(13)
      Unit(English Linear : Inch^3)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(5)[FEATURE]
    Field(0)
      Physical(Digitizers.Finger)
      Application(Digitizers.000e)
      Usage(2)
        Digitizers.InputMode
        Digitizers.DeviceIndex
      Logical Minimum(0)
      Logical Maximum(10)
      Physical Minimum(0)
      Physical Maximum(4095)
      Unit Exponent(13)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )

Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Key.ToolFinger
Digitizers.ContactID ---> Absolute.Misc
Digitizers.Confidence ---> Key.Btn0
GenericDesktop.X ---> Absolute.MTPositionX
GenericDesktop.Y ---> Absolute.MTPositionY
Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
GenericDesktop.X ---> Absolute.X
GenericDesktop.Y ---> Absolute.Y
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report

--SLDf9lqlvOQaIe6s--
