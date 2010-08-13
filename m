From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] serio: support multiple child devices per single
 parent
Date: Thu, 12 Aug 2010 20:26:42 -0700
Message-ID: <20100813032642.GB2661@core.coreip.homeip.net>
References: <1281605513-11586-1-git-send-email-dbaryshkov@gmail.com>
 <1281605513-11586-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35629 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0HMD0t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 23:26:49 -0400
Received: by gxk23 with SMTP id 23so728281gxk.19
        for <linux-input@vger.kernel.org>; Thu, 12 Aug 2010 20:26:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281605513-11586-2-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Thu, Aug 12, 2010 at 01:31:50PM +0400, Dmitry Eremin-Solenikov wrote:
> Some (rare) serio devices need to have multiple serio children. One of
> the examples is PS/2 multiplexer present on several TQC STKxxx boards,
> which connect PS/2 keyboard and mouse to single tty port.
> 

I like idea of the patch, however I'd prefer if we kept recurstion out
of the serio core and instead stick to iterative algorithms. Any chance
you could rework the part that travels the [sub]trees?

Thanks.

-- 
Dmitry
