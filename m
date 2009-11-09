From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Mon, 9 Nov 2009 15:00:20 +0300
Message-ID: <78f5d6bf0911090400n1bee3396x1cbd9b4722f87942@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	<4A03756C.6020703@gmail.com> <78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com>
	<4A2A5D8E.1050309@gmail.com> <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com>
	<20090609140949.78d4448a@dxy.sh.intel.com> <78f5d6bf0906110238w6f90331ex3cf8c0fdd44f3354@mail.gmail.com>
	<78f5d6bf0906111311p37620e53scc5ed8a695b5be94@mail.gmail.com>
	<78f5d6bf0907091041o3f8b712cxdc674c9c553a9f4@mail.gmail.com>
	<4A562FC1.60809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33931 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbZKIMAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2009 07:00:36 -0500
Received: by fxm21 with SMTP id 21so133219fxm.21
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2009 04:00:41 -0800 (PST)
In-Reply-To: <4A562FC1.60809@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

I found, what caused kernel crash: accessing urb data in call to
dev_warn(), because pointer usbhid->urbctrl (or urbout) is NULL.
Also, found several bugreports, telling that usb_unlink_urb() is
deprecated and usb_kill_urb() should be used. Second one used in other
places of hid-core.c, so I changed usb_unlink_urb() call to
usb_kill_urb().
Now kernel doesn't crash, and device gets stuck again.

Here is how hid_urb_timeout() looks now: http://paste.org.ru/index.pl?zcx5t1
And there is also part of kern.log, which I got:
http://paste.org.ru/index.pl?iyeyg7
