From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Polled input device: Add closing indication
Date: Mon, 12 Oct 2009 09:16:44 -0700
Message-ID: <20091012161644.GC7996@core.coreip.homeip.net>
References: <1255334981-24118-1-git-send-email-samu.p.onkalo@nokia.com> <1255334981-24118-2-git-send-email-samu.p.onkalo@nokia.com> <200910120154.42432.dmitry.torokhov@gmail.com> <62697B07E9803846BC582181BD6FB6B812F6933BBA@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:48200 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbZJLQRb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 12:17:31 -0400
Received: by bwz6 with SMTP id 6so3228026bwz.37
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2009 09:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <62697B07E9803846BC582181BD6FB6B812F6933BBA@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: linux-input@vger.kernel.org

On Mon, Oct 12, 2009 at 11:23:57AM +0200, samu.p.onkalo@nokia.com wrote:
> >
> >Hi Samu,
> >
> >On Monday 12 October 2009 01:09:41 am Samu Onkalo wrote:
> >> When closing polled input device, call optional closing 
> >method to make 
> >> it possible to turn off the HW.
> >
> >What about open? How do you re-enable the device if it was 
> >closed and then reopened?
> >
> 
> flush is called when the device is reopened. Is it ok to use that?
> 

No, please have open() method that is called when you open the device.

-- 
Dmitry
