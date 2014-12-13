From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Sat, 13 Dec 2014 23:56:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412132353500.9918@pobox.suse.cz>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com> <CANq1E4Sa=D_hvSp2SqHy4cV-oxd-kchsNVivcF54cBv8DK7gOQ@mail.gmail.com> <alpine.LNX.2.00.1411032115140.19451@pobox.suse.cz> <CALCETrVkZxc9G+B9jYYFmiE20VGcnugrB21_MRvjNhDTvP00zQ@mail.gmail.com>
 <CALCETrXf4wX5OoGJs2HWbzSLOz764XXg09mSHiTV=-GVCEUQuQ@mail.gmail.com> <CALCETrU9Nfpt0Zch5Swi+OaK=KTjJoOw7GAx4B7q1B56SqrUbA@mail.gmail.com> <CANq1E4Q8gTgMj+twRE3xjs1OfKUmbOmOatk_sDPPAW2BB4jscw@mail.gmail.com> <CALCETrXcHKwBuOA0wpFzgSe8Z9+t8LyaB7U+vdgVsR=YZc+GjQ@mail.gmail.com>
 <CANq1E4SVQAkyxJpiYsiLkjsET27QUK9PHTHTAqp4wQZVLKrMiw@mail.gmail.com> <CALCETrVfvK-BhaQMyfvLndfmX+gwAwshx3vdCFa7sOr+R1Jjpw@mail.gmail.com> <CANq1E4Q8+0_cLtwraK=gqFBovQoft9-0S4+ns_n9A7CinNTw7g@mail.gmail.com> <CALCETrW-Mt5Hqh353t3zm6Pq2kSUkw_16a2=DFHoEk=G92AU+w@mail.gmail.com>
 <CANq1E4QATOTs0ZtQF0mT645Z5u+vxYyphq8-UbqvNAc4iNz3iQ@mail.gmail.com> <CALCETrWD6w5QQSvnt=jkyHPNiBskQFxj5+LZey66LxXfyK_GcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38749 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517AbaLMW4y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Dec 2014 17:56:54 -0500
In-Reply-To: <CALCETrWD6w5QQSvnt=jkyHPNiBskQFxj5+LZey66LxXfyK_GcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Fri, 12 Dec 2014, Andy Lutomirski wrote:

> It's roughly ISO7816-3.  For the uninitiated (and the ISO7816 standard
> is amazingly vague), that means that the application sends a short
> (<64kB) binary request to the device (with a type, two "parameters",
> and a payload), and the device answers with exactly one reply packet
> that has two bytes of status and a payload.  These requests and
> replies are fragmented into multiple HID reports.

Sorry for taking one (or maybe even more) step back, but what makes this 
thing even "HID device"?

Yes, it interacts with human beings, but are the operations it's doing 
covered by HID specification (at least in a "does it have HID descriptor" 
sense)? It's not really completely clear to me at this point.

Thanks,

-- 
Jiri Kosina
SUSE Labs
