From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: zforce - swap reset and interrupt GPIO
Date: Mon, 27 Jul 2015 14:18:19 -0700
Message-ID: <20150727211819.GC5144@dtor-ws>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
 <1437396997-3182-3-git-send-email-dirk.behme@de.bosch.com>
 <20150724213223.GD33241@dtor-ws>
 <55B31C48.6070903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35124 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbbG0VS2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 17:18:28 -0400
Received: by pabkd10 with SMTP id kd10so57393404pab.2
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2015 14:18:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55B31C48.6070903@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

On Sat, Jul 25, 2015 at 07:19:04AM +0200, Dirk Behme wrote:
> 
> Btw, what does 'attn' stand for?

"attention"

> I'd name it int-gpio.

Works as well.

Thanks.

-- 
Dmitry
