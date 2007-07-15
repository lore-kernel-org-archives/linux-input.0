From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Sun, 15 Jul 2007 11:03:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
References: <469A5385.6030402@inwind.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469A5385.6030402@inwind.it>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: federico ferri <xaero@inwind.it>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org



On Sun, 15 Jul 2007, federico ferri wrote:
>
> this patch adds an entry in Kconfig after 'config MAGIC_SYSRQ' which
> asks for a different keycode (replacing also KEY_SYSRQ with
> CONFIG_MAGIC_SYSRQ_KEYCODE in char/keyboard.c)

Quite frankly, I think that if we want to make something like this 
configurable, it should be dynamic, not compiled-in. So that the same 
kernel image can be used with different keyboards.

		Linus
