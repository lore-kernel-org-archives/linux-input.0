From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: Re: hid_apple bug: arrow keys interpreted as Fn
Date: Tue, 19 May 2009 15:31:47 -0700
Message-ID: <EF082337-EF9F-4122-8DDE-A967A965D770@freedesktop.org>
References: <3E66E0E0-3B2B-4F78-9A62-87015A842A47@freedesktop.org> <C3870FA0-209F-4D40-8923-34D594B75EB1@freedesktop.org> <4A131D41.3030305@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:57559 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZESWbz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 18:31:55 -0400
In-Reply-To: <4A131D41.3030305@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

> Didn't you crop some 'type 4 (Misc)' lines from that output?

No, I just cropped value:2 lines identical to the lines above/below  
and sync lines.

> It looks
> like the kbd controller doesn't emit hid events for the releases. It  
> all
> looks like the controller got pretty crazy after pressing those 3
> buttons at a time. Jiri, any ideas here?
>
> I don't understand 'code 464' lines as well, how they did get there? I
> would have suspected the autorepeat code if there hadn't been a 'value
> 1' entry.

There was a value:1 entry for code 464.  That occurred when I pressed  
left.  code 464 corresponds to Fn.

> But this look like we get a mess from the keyboard.
>
> What it is expected to output when you press fn+arrow?

Just to be clear, I'm NOT pressing Fn.  Pressing Fn+Left should result  
in Home... which I suspect is related to why we see the Home release  
when I eventually release left.


