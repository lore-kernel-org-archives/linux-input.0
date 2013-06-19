From: Jan Kandziora <jjj@gmx.de>
Subject: Posiflex 0d3a:a000 touchscreen press not recognized in kernel 3.9.4
Date: Wed, 19 Jun 2013 09:12:05 +0200
Message-ID: <51C159C5.7070702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:53608 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336Ab3FSHMH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 03:12:07 -0400
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MVGca-1Uob840vN8-00YjhQ for
 <linux-input@vger.kernel.org>; Wed, 19 Jun 2013 09:12:06 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I have a Posiflex 7215 POS system which has a USB touchscreen controller
onboard. I've done a kernel update from 2.6.35.4 to 3.9.4 and the touch
stopped working correctly. I tried with the generic usb hid driver, the
usbtouchscreen driver doesn't support this usb id. Evtest says:


# evtest /dev/input/event4
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xd3a product 0xa000 version 0x110
Input device name: "Posiflex Inc. USB TOUCH V390"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
    Event code 272 (LeftBtn)
    Event code 273 (RightBtn)
    Event code 274 (MiddleBtn)
  Event type 3 (Absolute)
    Event code 0 (X)
      Value   2184
      Min        0
      Max     4095
    Event code 1 (Y)
      Value   3801
      Min        0
      Max     4095
  Event type 4 (Misc)
    Event code 4 (ScanCode)
Testing ... (interrupt to exit)

Event: time 1371798299.337455, type 3 (Absolute), code 0 (X), value 1596
Event: time 1371798299.337455, type 3 (Absolute), code 1 (Y), value 1969
Event: time 1371798299.337455, -------------- Report Sync ------------


There is no indication of pressure, so X is moving the cursor, but not
reporting anything pressed. With 2.6.35.4, there was a LeftBtn event
sent with each report block. Now it's gone.

What to do to make it work again?


Kind regards

	Jan
