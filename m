From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] evdev: fix evdev_write return value on partial writes
Date: Thu, 27 Jan 2011 11:05:21 +0100
Message-ID: <87tyguslum.fsf@macbook.be.48ers.dk>
References: <1296121320-8946-1-git-send-email-jacmet@sunsite.dk>
	<20110127094613.GE12588@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43152 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1A0KFg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 05:05:36 -0500
Received: by wyb28 with SMTP id 28so1893875wyb.19
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 02:05:34 -0800 (PST)
In-Reply-To: <20110127094613.GE12588@jasper.tkos.co.il> (Baruch Siach's
	message of "Thu, 27 Jan 2011 11:46:13 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

>>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:

 >> Fix it by only handling each full input_event structure, similar to
 >> how it is done in evdev_read.

 Baruch> A Reporte-by here would be nice.

Sorry, forgot. Dmitry, could you add it when you commit the patch.

 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Baruch> As I said on the Busybox list, applying this results in an endless

 Baruch> write(1, "test\n", 5)                   = 0
 Baruch> write(1, "test\n", 5)                   = 0
 Baruch> write(1, "test\n", 5)                   = 0
 Baruch> write(1, "test\n", 5)                   = 0
 Baruch> write(1, "test\n", 5)                   = 0
 Baruch> write(1, "test\n", 5)                   = 0
 Baruch> write(1, "test\n", 5)                   = 0

 Baruch> from the command

 Baruch> echo test > /dev/input/event0

 Baruch> write() should probably return -EINVAL here.

Indeed, like we do in evdev_read. Updated patch sent.

-- 
Bye, Peter Korsgaard
