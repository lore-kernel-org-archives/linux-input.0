From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: How to use force feedback correctly?
Date: Wed, 18 Mar 2009 10:03:01 +0300
Message-ID: <78f5d6bf0903180003i7504f4c7r36c0554f65c82cb2@mail.gmail.com>
References: <200903161142.12123.alexander.stein@informatik.tu-chemnitz.de>
	 <49BFA283.6000307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:59202 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbZCRHDF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Mar 2009 03:03:05 -0400
Received: by fg-out-1718.google.com with SMTP id 13so52735fge.17
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2009 00:03:02 -0700 (PDT)
In-Reply-To: <49BFA283.6000307@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>, linux-input@vger.kernel.org

2009/3/17 Anssi Hannula <anssi.hannula@gmail.com>:
>> So my actual question is: How can I use force feedback of a joystick without
>> setting global read/write permissions to /dev/input/eventX?
>
> The distribution should configure joystick eventX devices to
> either have global read/write access, or read/write access for one group
> (which the user is in), or have it chown the device to logged-in user,
> depending on distribution conventions.
>
> One can identify joystick devices from other eventX devices with udev
> variable ENV{ID_CLASS}="joystick", or with existence of
> "/dev/input/by-path/*-event-joystick", which is a symlink to the eventX
> device.
Created bug report for ubuntu jaunty. https://bugs.launchpad.net/bugs/344673
This wasn't a problem for ubuntu, because kernels prior to 2.6.28 were
missing force feedback support for hid devices.
You can make this rule yourself, here is a good manual:
http://www.reactivated.net/writing_udev_rules.html
Or just wait, I will make this rule and post it to bug report.
