From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: qt2160: Fix I2C write function.
Date: Tue, 16 Oct 2012 10:31:56 -0700
Message-ID: <20121016173156.GB412@core.coreip.homeip.net>
References: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54587 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab2JPRcC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Oct 2012 13:32:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so6124934pad.19
        for <linux-input@vger.kernel.org>; Tue, 16 Oct 2012 10:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1350400771-7950-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-input@vger.kernel.org, axel.lin@gmail.com

On Tue, Oct 16, 2012 at 05:19:30PM +0200, Javier Martin wrote:
> The previous implementation of qt2160_write() didn't work
> properly. Use a similar aproach as qt1070 instead.

I think your editor lost the end of the sentence: "... qt2160_write()
didn't work properly because ..." :)

Thanks!

-- 
Dmitry
