From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq key
Date: Mon, 16 Jul 2007 08:41:31 -0400
Message-ID: <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>
References: <469A5385.6030402@inwind.it>
	 <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
	 <469A68CC.5040902@inwind.it>
	 <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>
	 <469A99ED.3090603@inwind.it>
	 <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: federico ferri <xaero@inwind.it>, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

On 7/15/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 16 Jul 2007, federico ferri wrote:
>
> > Linus Torvalds ha scritto:
> > > Well, this is totally untested, and I won't guarantee that this works
> > > at all, but this is how to generally do these kinds of things..
> >
> > YAY! it works great.
> > tried with:
> > # echo 183 > /sys/module/keyboard/parameters/sysrq_key
> > but also keyboard.sys_rq=183 on the command line should work; I'll
> > discover that on next reboot.
>
> Yes, please do verify.
>
> > thank you, Linus!
>
> You're welcome.
>
> > (now that this has done in the proper way, is this patch going to be
> > merged in the tree?)
>
> I'm certainly ok with it, but I guess it's more up to Dmitry. If he ack's
> it, I can just commit it.
>
> Dmitry? Any reason not to do this?
>

Recent kernels have the ability to remap keymap for USB keyboards via
EVIOCSKEYCODE ioctl (we allowed 0adjusting keymaps on PS/2 keyboards
for a long time). So instead of having the new parameter redefining
SysRq keycode Frederico can remap one of the keys on his keyboard to
generate KEY_SYSRQ. This way SysRq should still work if he plugs in
another USB keyboard that has SysRq key or a PS/2 keyboard.

-- 
Dmitry
