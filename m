From: simon@mungewell.org
Subject: Re: [PATCH] Input: clarify gamepad API ABS values
Date: Thu, 14 Nov 2013 12:43:13 -0500
Message-ID: <e091a1b22849424e827b818f91ff9ede.squirrel@mungewell.org>
References: <1380806829-11824-1-git-send-email-dh.herrmann@gmail.com>
    <20131114180720.fece45888942c29d5865073e@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41347 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab3KNRo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Nov 2013 12:44:26 -0500
In-Reply-To: <20131114180720.fece45888942c29d5865073e@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


>> ... Unfortunately, this means I screwed up the Wii U ProController
>> ABI. Anyhow, this just means we continue to have 0 compatible gamepad
>> drivers in the kernel. User-space needs to fix them up, anyway, as all
>> other gamepads are also incompatible.
>>
>
> I know it is not really relevant and you won't fix the kernel interface
> anyway, but I was just curios: is there any known userspace using the
> gamepad API?

SDL are talking about 'fixing things'.... just in-case we're breaking it
(again) for them
http://lists.libsdl.org/pipermail/sdl-libsdl.org/2013-November/091850.html

Simon

