From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] HID: debug: improve hid_debug_event()
Date: Thu, 26 Nov 2015 22:03:35 +0100
Message-ID: <87a8q0eamw.fsf@rasmusvillemoes.dk>
References: <1448368427-1669-1-git-send-email-linux@rasmusvillemoes.dk>
	<1448483516.20113.61.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36311 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbbKZVDi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 16:03:38 -0500
Received: by wmww144 with SMTP id w144so34221117wmw.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2015 13:03:37 -0800 (PST)
In-Reply-To: <1448483516.20113.61.camel@perches.com> (Joe Perches's message of
	"Wed, 25 Nov 2015 12:31:56 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 25 2015, Joe Perches <joe@perches.com> wrote:

>>  	spin_lock_irqsave(&hdev->debug_list_lock, flags);
>>  	list_for_each_entry(list, &hdev->debug_list, node) {
>> -		for (i = 0; i < strlen(buf); i++)
>> +		for (i = 0; buf[i]; i++)
>>  			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
>>  				buf[i];
>>  		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
>
> trivia:
>
> The code might look nicer if (list->tail + i) % HID_DEBUG_BUFSIZE
> was stored into a temporary.

Maybe.

> Maybe use an if >= BUFSIZE to avoid a %

Nah, that would likely be worse; both a cmov and a conditional jump are
probably more expensive than a simple '& 0x1ff' which the % should compile to
(provided the expression is unsigned).

Rasmus
