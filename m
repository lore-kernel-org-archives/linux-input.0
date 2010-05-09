From: yoni dana <dana.yoni@gmail.com>
Subject: HID - SetFeature Response
Date: Sun, 9 May 2010 08:49:45 +0300
Message-ID: <g2y5e8196c01005082249o8ae2a0c8jaa0c2d5b59eb7cff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58830 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0EIFtq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 May 2010 01:49:46 -0400
Received: by wyf19 with SMTP id 19so167846wyf.19
        for <linux-input@vger.kernel.org>; Sat, 08 May 2010 22:49:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi
I am writing an HID driver to my Hardware .
I have a question regarding Set/Get Feature to USB device.
How to receive a reply after i send usbhid_submit_report(hid, report,
USB_DIR_OUT);

I tried using usbhid_wait_io(hid);
but i get this error: WARNING: "usbhid_wait_io"  undefined!

How can i receive the response related to the report i send.
(the response will be on the interrupt endpoint)
