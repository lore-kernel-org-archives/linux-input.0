From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [v1] input/tc3589x: add tc3589x keypad support
Date: Tue, 14 Dec 2010 10:46:54 -0800
Message-ID: <20101214184654.GB11384@core.coreip.homeip.net>
References: <33A307AF30D7BF4F811B1568FE7A9B18047C8B2DFA@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56356 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534Ab0LNSrB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 13:47:01 -0500
Received: by ywl5 with SMTP id 5so555332ywl.19
        for <linux-input@vger.kernel.org>; Tue, 14 Dec 2010 10:47:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B18047C8B2DFA@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Dec 14, 2010 at 06:31:20AM +0100, Sundar R IYER wrote:
> Hi Dmitry,
> 
> >I do not see where you'd enable the keypad. What will happen if you
> >unbind/unload the driver (which will cause explicit call to disable) and
> >then try loading the module again?
> 
> A minor doubt: I enable the keypad in the open call; leaving it to the user
> space to control the input device. If I understand your question, then I
> should not be disabling the keypad in the tc3589x_keypad_remove, which
> might cause conflicts. Is my understanding correct?

Ah, I missed the fact that you have open and close. I think the best way
would be to serialize open/close/suspend/resume (you can use dev->mutex)
in suspend/resume and track device state so that you:

1. On resume do not enable the device if it hasn't been opened.
2. Can remove disable in remove().

Thanks.

-- 
Dmitry
