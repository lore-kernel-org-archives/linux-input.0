From: "=?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?="
	<sergey.belyashov@gmail.com>
Subject: Re: Force feedback in Linux
Date: Tue, 6 Jan 2009 14:10:40 +0300
Message-ID: <bb829a0b0901060310j5c364733wf3909dbdf47075a3@mail.gmail.com>
References: <bb829a0b0901020434q6ab51b86na945179c56f79e9@mail.gmail.com>
	 <alpine.LNX.1.10.0901051104390.5377@jikos.suse.cz>
	 <bb829a0b0901051155k710b0ec8w42de31da0305f9e7@mail.gmail.com>
	 <alpine.LNX.1.10.0901061102000.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:37795 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZAFLRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2009 06:17:48 -0500
Received: by bwz14 with SMTP id 14so23855631bwz.13
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2009 03:17:46 -0800 (PST)
In-Reply-To: <alpine.LNX.1.10.0901061102000.5377@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

   Yes, you right. I did not understand purpose of field 'direction'
and this one does not directly used in hid-lgff.c. I think,
theoretically (in future?) this field may cause problems with
difficult joysticks with more than 2 independent axises with feedback
(for example, X (left/right), Y (up/down) and throttle
(forward/backward)).
   Thanks.

Best regards,
Sergey Belyashov

2009/1/6 Jiri Kosina <jkosina@suse.cz>:
> On Mon, 5 Jan 2009, ?????? ??????? wrote:
>
> I don't think I fully understand, sorry. What's wrong with the 'direction'
> field of struct ff_effect?
>
> --
> Jiri Kosina
> SUSE Labs
>
