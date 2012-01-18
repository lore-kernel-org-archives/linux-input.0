From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Wed, 18 Jan 2012 13:28:31 +0530
Message-ID: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:55673 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753023Ab2ARH6c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jan 2012 02:58:32 -0500
Received: by obcva7 with SMTP id va7so6855768obc.19
        for <linux-input@vger.kernel.org>; Tue, 17 Jan 2012 23:58:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 18 January 2012 03:58,  <simon@mungewell.org> wrote:
> Do you have the appropriate FF module built and loading in your kernel, it
> was recently moved to be enabled with 'LOGIWHEELS_FF' and is supported by
> the code in 'drivers/hid/hid-lg4ff.c'

And also, I don't have "hid-lg4ff.c" in this
"linux-dopx:/usr/src/linux-2.6.34-12/drivers/hid" path. I have
"hid-lg3ff.c" etc.
Is it responsible for the force feedback not working in the native mode?
Will I have to compile the kernel or something? :( :(

Ah, or simply download that file and put its name in the respective
Makefile? Not sure.

-Anisha
