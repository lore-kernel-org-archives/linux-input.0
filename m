From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Tue, 9 Jun 2009 11:37:30 +0400
Message-ID: <78f5d6bf0906090037j7ec79074je8517b2c8c88369a@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	<78f5d6bf0903072118i19bc91a0taa4a5bda0fb19bf6@mail.gmail.com>
	<49B39B15.6060609@gmail.com> <78f5d6bf0903091208i71aadc0od7b89ab9a4037b4d@mail.gmail.com>
	<4A037290.60602@gmail.com> <4A03756C.6020703@gmail.com> <78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com>
	<4A2A5D8E.1050309@gmail.com> <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com>
	<20090609140949.78d4448a@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:43974 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953AbZFIHhx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2009 03:37:53 -0400
Received: by fxm9 with SMTP id 9so2740549fxm.37
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2009 00:37:54 -0700 (PDT)
In-Reply-To: <20090609140949.78d4448a@dxy.sh.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

As I understood, since some alpha, ubuntu packagers enabled module
versioning. I used old ubuntu alpha in virtualbox to test changes
(also I used my own built kernel there), now I tried to build module
for current running kernel.
Some discussions, I found about this error, tell that Module.symvers
is somehow causing it. Copying Module.symvers from current kernel
headers didn't help.
But I know that it is possible to build module -- dkms builds 3
modules successfully. I just didn't find out how to do this.

2009/6/9 Alek Du <alek.du@intel.com>:
> Seems your module was not compiled against your running kernel. Are you using the right tree and config?
>
> On Tue, 9 Jun 2009 13:02:45 +0800
> Dmitriy Geels <dmitriy.geels@gmail.com> wrote:
>
>> Now it built ok, but for some reason kernel doen't like new module:
>> dmig@dmig-laptop:~/workspace/linux-source-2.6.29$ sudo insmod
>> drivers/hid/usbhid/usbhid.ko
>> insmod: error inserting 'drivers/hid/usbhid/usbhid.ko': -1 Invalid module format
>>
>> Have any idea why?
