From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gamepad - use independent axes for analog D-Pad
 buttons
Date: Sun, 29 Dec 2013 16:52:09 -0800
Message-ID: <20131230005209.GC11528@core.coreip.homeip.net>
References: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61397 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3L3AwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Dec 2013 19:52:12 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so10797404pdj.4
        for <linux-input@vger.kernel.org>; Sun, 29 Dec 2013 16:52:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387815463-29345-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi Antonio,

On Mon, Dec 23, 2013 at 05:17:43PM +0100, Antonio Ospite wrote:
> Model this part of the API after the Sony PlayStation 3 Controller which
> exposes independent analog values for each one of the D-Pad buttons.
> 
> The PS3 programming API psl1ght also maps the analog D-Pad buttons
> individually.

Hmm, even though the hardware is capable of producing independent analog
values does are they really useful? Looking at my PS3 controller I do
not think users will be pressing up/down and left/right dpad buttons at
the same time.

I'd rather keep using ABS_HAT0X/Y unless there is really good reason for
introducing new events.

Thanks.

-- 
Dmitry
