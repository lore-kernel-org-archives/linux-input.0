From: federico ferri <xaero@inwind.it>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Sun, 15 Jul 2007 20:34:52 +0200
Message-ID: <469A68CC.5040902@inwind.it>
References: <469A5385.6030402@inwind.it> <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org

Linus Torvalds ha scritto:
> On Sun, 15 Jul 2007, federico ferri wrote:
>   
>> this patch adds an entry in Kconfig after 'config MAGIC_SYSRQ' which
>> asks for a different keycode (replacing also KEY_SYSRQ with
>> CONFIG_MAGIC_SYSRQ_KEYCODE in char/keyboard.c)
>>     
>
> Quite frankly, I think that if we want to make something like this 
> configurable, it should be dynamic, not compiled-in. So that the same 
> kernel image can be used with different keyboards.
>
> 		Linus
>
>   
That's right; but let me explain: I started this as a hack, just because
I both wanted to use this Apple USB keyboard and wanted to be able to
hit SysRq.

I have no experience at all in programming kernel. Even that small patch
it was reviewed and corrected by some people on kernel and input mailing
lists.

(I can imagine it could be done via a /proc/sysrq-keycode virtual file,
but that's just one possibility)

So, this should turn into a feature request...
would you accept feature requests?  ( :

-- 
Federico Ferri
