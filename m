From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: keyboard problem on linux
Date: Tue, 19 Jan 2016 16:13:40 -0800
Message-ID: <20160120001340.GC31589@dtor-ws>
References: <569E3B62.6050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34790 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbcATANo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 19:13:44 -0500
Received: by mail-pf0-f175.google.com with SMTP id q63so189260734pfb.1
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2016 16:13:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <569E3B62.6050407@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrea <andrea.deangelis93@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Andera,

On Tue, Jan 19, 2016 at 02:34:26PM +0100, Andrea wrote:
> [1.] i've a problem with keyboard of my notebook HP Pavilion 15
> ab062nl; CTRL SHIFT and ALT buttons not works as they should. in
> particular, it is as if these keys are pressed and released alone.
> isn't an hardware problem, because on windows 10 and windows 8.1 i
> haven't these problems, is only a linux problem (all distro).
> 
> [2.] the bug is always active, every time i start a linux Distro
> (also from live, and also without DE/WM) i've this problem with
> keyboard, the only way to fix temporarily the bug, is pressing the
> only Left SHIFT key for some seconds, then all problems disappear
> indefinitely, and in any case, if i shutdown or if i reboot the PC,
> the problem recurs.
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1532746

Hmm, this is weird. Do you observe the same issue in text console (not
in X)? It would be nice to see events as emitted by the kernel - you can
use evtest utility for that.

Is sounds like some accessibility feature, is there anything in BIOS to
that effect?

Thanks.

-- 
Dmitry
