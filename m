From: =?UTF-8?B?VHVvbWFzIFLDpHPDpG5lbg==?= <tuomasjjrasanen@opinsys.fi>
Subject: Re: uinput: How to use force feedback?
Date: Mon, 18 Jan 2016 19:39:58 +0200
Message-ID: <CALTn+wqst8LUUZghX04X1zmqgEdbkYLB_fo+8YdFzJ9ePa_vDQ@mail.gmail.com>
References: <n7g4s1$i1l$1@ger.gmane.org>
	<CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37897 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbcARRj7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 12:39:59 -0500
Received: by mail-ig0-f174.google.com with SMTP id mw1so52517200igb.1
        for <linux-input@vger.kernel.org>; Mon, 18 Jan 2016 09:39:59 -0800 (PST)
In-Reply-To: <CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Manuel Reimer <Manuel.Spam@nurfuerspam.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Sun, Jan 17, 2016 at 5:46 PM, Elias Vanderstuyft <elias.vds@gmail.com> wrote:
>
> A good while ago I started working on FF support for
> the uinput user-space library libsuinput, (and also for python-uinput,)
> but I have to clean up some things before I can merge it to:
> https://github.com/xboxdrv/xboxdrv/blob/8e9fb6b40df568d4e4af63e80518366ee4aa5fd3/src/linux_uinput.cpp#L341
>

Patches are more than welcome! (I'm the author of libsuinput, happy to
see someone actually uses it without python-uinput, but I welcome
patches to python-uinput as well).

-- 
Tuomas
