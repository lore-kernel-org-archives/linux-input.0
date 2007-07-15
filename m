From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Sun, 15 Jul 2007 15:15:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
References: <469A5385.6030402@inwind.it> <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
 <469A68CC.5040902@inwind.it> <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>
 <469A99ED.3090603@inwind.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469A99ED.3090603@inwind.it>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: federico ferri <xaero@inwind.it>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org



On Mon, 16 Jul 2007, federico ferri wrote:

> Linus Torvalds ha scritto:
> > Well, this is totally untested, and I won't guarantee that this works 
> > at all, but this is how to generally do these kinds of things..
>   
> YAY! it works great.
> tried with:
> # echo 183 > /sys/module/keyboard/parameters/sysrq_key
> but also keyboard.sys_rq=183 on the command line should work; I'll
> discover that on next reboot.

Yes, please do verify. 

> thank you, Linus!

You're welcome.

> (now that this has done in the proper way, is this patch going to be
> merged in the tree?)

I'm certainly ok with it, but I guess it's more up to Dmitry. If he ack's 
it, I can just commit it.

Dmitry? Any reason not to do this?

		Linus
