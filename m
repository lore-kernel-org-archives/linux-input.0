From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Tue, 9 Jun 2009 09:02:45 +0400
Message-ID: <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	<78f5d6bf0903031035r44a9c655n2cb0408ddf10d7d1@mail.gmail.com>
	<49B286EB.8000300@gmail.com> <78f5d6bf0903072118i19bc91a0taa4a5bda0fb19bf6@mail.gmail.com>
	<49B39B15.6060609@gmail.com> <78f5d6bf0903091208i71aadc0od7b89ab9a4037b4d@mail.gmail.com>
	<4A037290.60602@gmail.com> <4A03756C.6020703@gmail.com> <78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com>
	<4A2A5D8E.1050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47112 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZFIFDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2009 01:03:07 -0400
Received: by fxm9 with SMTP id 9so2683004fxm.37
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2009 22:03:07 -0700 (PDT)
In-Reply-To: <4A2A5D8E.1050309@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

Now it built ok, but for some reason kernel doen't like new module:
dmig@dmig-laptop:~/workspace/linux-source-2.6.29$ sudo insmod
drivers/hid/usbhid/usbhid.ko
insmod: error inserting 'drivers/hid/usbhid/usbhid.ko': -1 Invalid module format

Have any idea why?

2009/6/6 Anssi Hannula <anssi.hannula@gmail.com>:
>>>> Try the attached (untested) patch. It adds a simple timeout to the hid
>>>> ctrl and out urbs, discarding the faulty urb instead of getting stuck.
>>> And of course there was an error, attached is a fixed patch :)
>> Just tried to build module with your patch. It doesn't build.
