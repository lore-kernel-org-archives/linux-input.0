From: TJ <linux@iam.tj>
Subject: [Bug 117451] No input driver for "SYNAPTICS Synaptics Touch  Digitizer"
Date: Tue, 03 May 2016 01:47:08 +0100
Message-ID: <82c591ce613f5f4dcd301a591fb6824d@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:56662 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932445AbcECAwr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 May 2016 20:52:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=117451

Summary:

There are many hybrid 2-in-1 tablet/notebook PCs being shipped by 
companies such as Dell, Acer and Asus which have a detachable docking 
keyboard.

The display has a touchscreen digitiser which identifies as

SYNAPTICS Synaptics Touch Digitizer V{03|04}

there is often an additional:

SYNAPTICS Synaptics Touch Digitizer V{03|04} Pen

There is no support for this in the existing synaptics_usb driver. The 
usbhid driver binds to the device but only provides mouse-like support - 
there is no multitouch, gesture, or scroll support, although the 
hid_multitouch driver attaches.

