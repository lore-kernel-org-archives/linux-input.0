From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: Reading keys
Date: Mon, 10 May 2010 18:55:47 +0200
Message-ID: <1273510547.10849.10.camel@lovely>
References: <1273507273.2199.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60050 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0EJQtn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 12:49:43 -0400
Received: by fxm7 with SMTP id 7so294108fxm.19
        for <linux-input@vger.kernel.org>; Mon, 10 May 2010 09:49:41 -0700 (PDT)
In-Reply-To: <1273507273.2199.13.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niko Rosvall <niko@fograven.net>
Cc: Linux input <linux-input@vger.kernel.org>

On Mon, 2010-05-10 at 19:01 +0300, Niko Rosvall wrote:
> Hi All,
> 
> I'm new to Linux kernel and actually subscribed to this list today.
> So, i'm not even sure is this the right place to ask this, but:
> 
> I want to make a kernel module which detects a keypress and then
> disables it. E.g someone presses F1 and my module would just "eat" it.

Interesting usecase, is it for a kiosk? And why don't you disable the
keys in X or your application?

> Any examples and/or hints where to start? Some nice, small peace of code
> would be very very nice.

You could hack input_event() in drivers/input/input.c

Thanks,
 Christoph


