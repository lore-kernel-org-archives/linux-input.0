From: Andrea Momesso <momesso.andrea@gmail.com>
Subject: 0930:0807 Toshiba Corp. not recognized
Date: Mon, 8 Sep 2014 21:36:25 +0200
Message-ID: <CAPeUGf2yVqamvzfe3cD+W+0WBb_iFGCGG47Pt6dA1MVw-iuqwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57186 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbaIHTg0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Sep 2014 15:36:26 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so5922292iec.22
        for <linux-input@vger.kernel.org>; Mon, 08 Sep 2014 12:36:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

 The device  0930:0807 Toshiba Corp.  is a trackpad. The kernel
doesn't recognize it and I have to add this quirk to my bootloader to
have it to work: usbhid.quirks=0x0930:0x0807:0x0040

Anyway with the quirk it is recognized but I get very limited
functionality (no scrolling, no middle click etc), and it is
recognized as a mouse input instead of an event input.

I've seen a bug for the same device has been opened for Ubuntu here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1280839

The laptop that ships this device (Toshiba Portege Z10t A) has also a
trackpad that seems to be connected to the touchpad (it only works
when I use the quirk and I don't see any other entries in lsusb
related to that device). Using the quirk trackpad buttons will work,
while touchpad buttons don't.

Thank you

-- 
Momesso Andrea
