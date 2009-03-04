From: Pantelis Koukousoulas <pktoss@gmail.com>
Subject: Re: [patch] HID: add support for another version of 0e8f:0003 device
	in hid-pl
Date: Wed, 4 Mar 2009 19:09:16 +0200
Message-ID: <1295ed070903040909l3c3d94aey182c973cf24d3fd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:43023 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbZCDRJT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 12:09:19 -0500
Received: by ewy25 with SMTP id 25so2760986ewy.37
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2009 09:09:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Given that this code is trivial enough to incur practically zero risk
for serious regressions
it would be nice if it were nominated for 2.6.29 (i.e., about 15 days)
instead of 2.6.30
(several months).

After reading today's announcement that -rc7 contains 2 new drivers
(less trivial than this
code for sure), I believe linus would be ok with it.

It should also be noted that adding this code saves users from a "wtf
moment" because
the way things are now in mainline it *looks* like their device is
supported (a driver is
loaded, prints the right VID:PID) yet it doesn't work. So it is
"almost" a bugfix.

In any case, thanks a lot for merging,
one less broken device for me :-)

Pantelis
