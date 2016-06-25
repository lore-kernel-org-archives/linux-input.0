From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix effect aborting in ff-memless
Date: Sat, 25 Jun 2016 08:31:18 -0700
Message-ID: <20160625153118.GB17812@dtor-ws>
References: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
 <20160620173303.GA22426@dtor-ws>
 <20160621032410.GA35864@dtor-ws>
 <8aa55974-2d18-511d-d876-2c408307d965@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34979 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbcFYPbW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 11:31:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id c2so48115028pfa.2
        for <linux-input@vger.kernel.org>; Sat, 25 Jun 2016 08:31:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8aa55974-2d18-511d-d876-2c408307d965@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>, Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org

On Sat, Jun 25, 2016 at 02:23:44PM +0200, Manuel Reimer wrote:
> On 06/21/2016 05:24 AM, Dmitry Torokhov wrote:
> >Actually, I wonder if the patch below will fix the issue you are seeing.
> 
> At first: Thank you for helping with fixing this issue.
> 
> And sorry for the late answer.
> 
> I did a complete kernel rebuild with your patch and now I can say,
> that your patch doesn't make any difference. The problem still
> exists.

I see. I suspect my patch is still needed to ensure that dev->close() is
called when we forcibly remove input device but I'll need to experiment
a bit with it.

Thanks.

-- 
Dmitry
