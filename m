From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Current git: no keyboard when booting in verbose mode
Date: Wed, 23 Sep 2009 11:09:55 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0909231108100.27145@twin.jikos.cz>
References: <6041d2000909221754n2ee1982xe08f938a35358c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752716AbZIWJJz@vger.kernel.org>
In-Reply-To: <6041d2000909221754n2ee1982xe08f938a35358c00@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org


[ adding some CCs ]

On Tue, 22 Sep 2009, Marc Dionne wrote:

> I'm having issues with the current kernel in git, and wondering if this 
> will ring a bell for anyone. The main symptom is that on most boots the 
> keyboard is not detected - the system gets to the console login prompt 
> but input is not recognized.  Sometimes (rarely) the keyboard will be ok 
> at the console, but the keyboard and mouse are non functional once in X. 

Are both keyboard and mouse in question PS/2?

> Other times the system will hang before getting to the console login 
> prompt.
> 
> I made a few attempts to bisect this but with no success - I assume
> that I'm led astray at some point by a bad kernel that happens to boot
> normally a few times.
> 
> Things to note:
> - The problem only occurs in verbose mode - if I boot with "quiet"
>   everything is fine
> - 2.6.31 has no issues on the same machine
> - On a failed boot with no keyboard, this line is missing from dmesg:
>     AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2

Could you please provide output from kernel booted with 'i8042.debug' from 
the failing case?

> - Otherwise there are no obvious differences with dmesg from a successful boot.
> 
> config is attached

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
