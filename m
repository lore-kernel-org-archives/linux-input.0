From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/serio/hp_sdc.c: Removed duplicated include
Date: Fri, 25 Jul 2008 11:52:19 -0400
Message-ID: <20080725115152.ZZRA012@mailhub.coreip.homeip.net>
References: <20080725231334.9146.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:40094 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYGYPwY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 11:52:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so730614and.103
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2008 08:52:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080725231334.9146.WEIYI.HUANG@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 25, 2008 at 11:30:20PM +0800, Huang Weiyi wrote:
> Removed duplicated include file <linux/semaphore.h> in 
> drivers/input/serio/hp_sdc.c.
> 

What tree is it against? I don't seem to have teh duplicate.

-- 
Dmitry
