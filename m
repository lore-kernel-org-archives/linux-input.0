From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: touchscreen: ad7877 implement specified chip
 select behavior
Date: Fri, 15 Oct 2010 09:56:11 -0700
Message-ID: <20101015165610.GB19112@core.coreip.homeip.net>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34024 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590Ab0JOQ4V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 12:56:21 -0400
Received: by yxm8 with SMTP id 8so445681yxm.19
        for <linux-input@vger.kernel.org>; Fri, 15 Oct 2010 09:56:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com

On Fri, Oct 15, 2010 at 12:40:48PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> According to the AD7877 datasheet:
> Each transfer operation is 16-bit. If multiple read/write operations are
> to be performed, CS must be taken high after the end of each read/write
> operation before another read/write operation can be performed by
> taking CS low again.
> 
> Make sure CS toggles after each transfer in the message.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Will apply all 3, thanks Michael.

-- 
Dmitry
