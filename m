From: renato <rennabh@gmail.com>
Subject: joydev bug with playstation USB adapter
Date: Sat, 2 Feb 2013 00:43:20 +0100
Message-ID: <20130202004320.408ac7c3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/jdyb/tc1HoECUB0RQ1xH+r8"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:63740 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab3BAXnb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Feb 2013 18:43:31 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so2334127eek.4
        for <linux-input@vger.kernel.org>; Fri, 01 Feb 2013 15:43:30 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz

--Sig_/jdyb/tc1HoECUB0RQ1xH+r8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi, I have two playstation USB adpters, one of them with this [1] "lsusb
-v" (the other I don't have access to ATM) and they both give me the
following buggy behaviour: the range of the sticks is limited - i.e.
value 32767 is reached when the stick is only about half-way through
its run, leaving a big dead zone after that. This happens on all axes
and recalibrating with "jscal -c" didn't help.

I'm on an up-to-date Archlinux, kernel 3.7.5, and have tried various
kernel versions down to 3.0.1 with same results.

Is there any other info I can provide?

thanks,
renato


[1]
Bus 002 Device 002: ID 0810:0001 Personal Communication Systems, Inc.
Dual PSX A daptor
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0810 Personal Communication Systems, Inc.
  idProduct          0x0001 Dual PSX Adaptor
  bcdDevice            1.06
  iManufacturer           0
  iProduct                2 Twin USB Joystick
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode           33 US
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     202
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
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

--Sig_/jdyb/tc1HoECUB0RQ1xH+r8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRDFMbAAoJEBz6xFdttjrf8R4IAIr2zCas6cq4r1ttTsRmptjX
1dIuIEa6UVdvvcW+SnTPGxfhm+fJtipv7jOtLOkSzEDEDTJPOCYW9C8eBDVYMDKM
rHFTg++QZJhzyFCxLfKP9P5UkwlWOjLiaFm2l9g+L9Q8wzDm4yteHHoehEFCXHfM
EyIWiVvmW560cJ0i4sS4rwxYznY0qsIoZFLsoqjyQP3cAeQXV0kfoufNreXiDHh+
pQsibnoEG9oTHQEJGuWXMLgWxAyg8SZ1i4fbQP/70HBEs6ATeBpDJ+GX81h3YoI+
cpvDqF+fEBFpTbCL5p4hnxmZCP9xWCH4MNlG5mQGt2vXcqrIGAwDVx/qIgBfMmQ=
=Vwgg
-----END PGP SIGNATURE-----

--Sig_/jdyb/tc1HoECUB0RQ1xH+r8--
