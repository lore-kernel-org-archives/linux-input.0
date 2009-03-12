From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [RFC PATCH 2/2] Add virtual "idle" device
Date: Thu, 12 Mar 2009 02:08:53 +0100
Message-ID: <49B860A5.7020805@gmail.com>
References: <1236033772-20329-2-git-send-email-marcin.slusarz@gmail.com> <20090306184356.GA1311@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:46372 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZCLBJN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2009 21:09:13 -0400
In-Reply-To: <20090306184356.GA1311@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Pavel Machek wrote:
> On Mon 2009-03-02 23:42:52, Marcin Slusarz wrote:
>> This virtual device can be used to tell user space about periods of time
>> when user didn't "touch" input devices (keyboards, mice, touchpads, joysticks,
>> etc). For now it supports only keyboard events.
>>
>> Notification is done through simple select/poll + ioctl interface.
>>
>> It can be used to implement screen savers, automatic suspend,
>> autoaway/autodisconnect (e.g. in instant messangers) without
>> any help from X server and its overhead (context switches).
> 
> I don't think this is good interface; what if you have more than one
> seat?

Good point. I haven't thought about it.
Moreover it wouldn't work with remote X sessions...

It could be used on single user systems (like laptops, personal desktops,
embedded), but user space couldn't know whether it safe to use it (maybe
excluding embedded).

> And without mouse handling it is useless anyway, so....

Well, I didn't want to dig too much into input layer just to
discover after patch submission that my core functionality is broken :).

Marcin

