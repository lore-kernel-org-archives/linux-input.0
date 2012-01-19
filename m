From: Anisha Kaul <born.rebel.83@gmail.com>
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Thu, 19 Jan 2012 11:57:06 +0530
Message-ID: <CAM1yFZ82ZqJ+DAh2fU+Lqijcm=r6DE_EmCR8OX7M7ubNRMxyyg@mail.gmail.com>
References: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
	<2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50504 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373Ab2ASG1H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jan 2012 01:27:07 -0500
Received: by obcva7 with SMTP id va7so8241844obc.19
        for <linux-input@vger.kernel.org>; Wed, 18 Jan 2012 22:27:06 -0800 (PST)
In-Reply-To: <2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 18 January 2012 22:09,  <simon@mungewell.org> wrote:
> 'hid-lg4ff' was improved by Michal back in August to include support for
> all Logitech wheel and run them in the native mode (to get 900' rotation
> etc).

Thanks for the reply, Simon.

So, today I installed OpenSuse 12.1 which has the kernel version 3.1.0.
Thankfully the file hid-lg4ff "is" present there in the hid directoy.

I saw the same file with extended code here:
http://lingrok.org/source/xref/linux-2.6-linus/drivers/hid/hid-lg4ff.c

The above linked 'hid-lg4ff' file does contain the function for the
native mode etc. and is lengthy too.
I was very much surprised on noticing that the 'hid-lg4ff' file
present in kernel version 3.1.0 of Suse 12.1 is quite small and does
NOT seem to have any function for native mode etc!

Sorry, I don't know how to use that git link which you gave. I'll try
to figure that out.

-Anisha
