From: <samu.p.onkalo@nokia.com>
Subject: RE: [PATCH] input: polldev can cause crash in case of polling
	disabled
Date: Thu, 18 Feb 2010 07:46:51 +0100
Message-ID: <62697B07E9803846BC582181BD6FB6B82661DE37D4@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
 <20100216175047.GB15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
 <20100216214309.GC15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
 <20100217170315.GB10249@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47749 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab0BRGrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 01:47:24 -0500
In-Reply-To: <20100217170315.GB10249@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: oleg@redhat.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

>Of course, I don't understand input-polldev.c, but shouldn't the trivial
>patch below fix the problem? Although, most likely I do not really
>understand what the problem is ;)
>
>Oleg.
>
>the patch assumes INIT can't race with queue, I don't know if this
>is true.
>
>--- drivers/input/input-polldev.c
>+++ drivers/input/input-polldev.c
>@@ -100,6 +100,7 @@ static void input_close_polled_device(st
> 	struct input_polled_dev *dev = input_get_drvdata(input);
>
> 	cancel_delayed_work_sync(&dev->work);
>+	INIT_DELAYED_WORK(&dev->work, dev->work->func);
> 	input_polldev_stop_workqueue();
>
> 	if (dev->close)

Yes that should fix the problem. This way references to the old workqueue are cleaned up.
I proposed similar thing but to the opening phase. Both should work. 

I'll test this. 

-Samu

