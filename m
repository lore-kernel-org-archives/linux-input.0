From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: HID generic-bluetooth driver
Date: Sun, 08 May 2011 13:52:33 +0200
Message-ID: <1304855553.4742.3.camel@mars>
References: <BANLkTi=tUNCMyCKVEXtv0W=8jYbK-k7HMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60109 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1EHLwi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 May 2011 07:52:38 -0400
Received: by wya21 with SMTP id 21so3299787wya.19
        for <linux-input@vger.kernel.org>; Sun, 08 May 2011 04:52:37 -0700 (PDT)
In-Reply-To: <BANLkTi=tUNCMyCKVEXtv0W=8jYbK-k7HMg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi

On Sun, 2011-05-08 at 12:16 +0200, David Herrmann wrote:
> Hi
> 
> I am currently working on a bluetooth HID device driver during GSoC
> this summer and have a small problem. My dummy HID-driver does not get
> bound on new devices. My dummy driver is available at:
> https://github.com/dvdhrm/xwiimote/blob/master/driver/src/hid-nintendo.c
> 
> If a new bluetooth device with exactly these PID/VID values connects,
> the generic-bluetooth HID driver gets bound instead of my hid-nintendo
> driver. I checked /dev/hidrawX and it returns the same PID/VID values
> as I specified in my driver so these are correct.
> Also, if I use /sys/class/hid/drivers/generic-bluetooth/unbind and
> .../nintendo/bind I can bind my driver manually to that device.
> 
> What can I do to lower the priority of generic-bluetooth or to push my
> driver in front of generic-bluetooth?

Hi David,

 you can add it to hid_have_special_driver[] (drivers/hid/hid-core.c).

Thanks,
 -- chf

