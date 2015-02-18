From: simon@mungewell.org
Subject: Re: [PATCH] HID: hid-sony: Prevent LED overrun
Date: Wed, 18 Feb 2015 00:32:22 -0500
Message-ID: <8852fc05431a5ac60b02cfb5bea480d3.squirrel@mungewell.org>
References: <1424229290-32089-1-git-send-email-simon@mungewell.org>
    <54E41BA3.7060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41207 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbBRFcX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 00:32:23 -0500
In-Reply-To: <54E41BA3.7060107@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>


> I think this was a bug in the LED system itself fixed by this commit:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/leds/leds.h?id=56d06fdee534124f79b51ff92232373b783cddc2
>
> In kernel 3.19 the brightness values are clamped correctly and I can't
> replicate your bug.

I guess it's possible, I am running 3.19.0rc5. I'll build 3.19 and see if
it's showing the bug.

Simon


