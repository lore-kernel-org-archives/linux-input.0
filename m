From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Potential bugs found in psmouse
Date: Wed, 17 Dec 2014 15:21:28 -0800
Message-ID: <2262075.hjB9hShQFG@dtor-glaptop>
References: <000401d01812$91496a50$b3dc3ef0$@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:48439 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLQXVb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 18:21:31 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so96195ier.0
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 15:21:30 -0800 (PST)
In-Reply-To: <000401d01812$91496a50$b3dc3ef0$@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@163.com>
Cc: linux-input@vger.kernel.org

[ Reposting what I replied in bugzilla... ] 

Hi Jia-Ju,

On Monday, December 15, 2014 10:55:21 AM Jia-Ju Bai wrote:
> Recently I test linux device drivers 3.17.2, and find some potential bugs.
> 
> The target file is drivers/input/mouse/psmouse-base.c, which is used to
> build psmouse.ko. I hope you can help me check my findings:
> [1] psmouse_switch_protocol is called by psmouse_connect when initializing
> the driver. However, psmouse_switch_protocol may be failed and return -1,
> but its return value is not checked in psmouse_connect. In my experiment of
> running the driver, when psmouse_switch_protocol in psmouse_connect is
> failed, the system crash will occur.

psmouse_connect() calls psmouse_switch_protocol with NULL as protocol 
argument. When psmouse_switch_protocol() gets NULL as protocol it will not 
fail. Do you actually have a crash trace?

Thanks.

-- 
Dmitry
