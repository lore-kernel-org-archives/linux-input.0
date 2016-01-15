From: "Allen M." <ase1592@gmail.com>
Subject: adding xpad support for PS-PC Smart Joypad
Date: Fri, 15 Jan 2016 11:42:39 -0600
Message-ID: <CAPMSj_FGPyTVtS-F-U6C-Jji8V7_yv9-nqu4=9+1_7wCNP2UnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33901 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcAORmk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 12:42:40 -0500
Received: by mail-oi0-f44.google.com with SMTP id k206so140655897oia.1
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 09:42:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, I have a Playstation 1 to USB device I'd like to request to be added
as an xpad supported device. verbose lsusb output for the device can be
found here: http://ix.io/nq3

The device currently works fine as a generic joystick. However, it needs
the MAP_DPAD_AS_BUTTONS option in order for it to be used with a dance pad.
Let me know if I need to do anything further or if I need to provide more
info for the device.
