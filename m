From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq key
Date: Tue, 17 Jul 2007 11:11:29 -0400
Message-ID: <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>
References: <469A5385.6030402@inwind.it>
	 <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>
	 <469A68CC.5040902@inwind.it>
	 <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>
	 <469A99ED.3090603@inwind.it>
	 <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
	 <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>
	 <469C647B.1000307@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469C647B.1000307@inwind.it>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: federico ferri <xaero@inwind.it>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, trivial@kernel.org
List-Id: linux-input@vger.kernel.org

On 7/17/07, federico ferri <xaero@inwind.it> wrote:
> Dmitry Torokhov ha scritto:
> >> Dmitry? Any reason not to do this?
> >>
> >
> > Recent kernels have the ability to remap keymap for USB keyboards via
> > EVIOCSKEYCODE ioctl (we allowed 0adjusting keymaps on PS/2 keyboards
> > for a long time). So instead of having the new parameter redefining
> > SysRq keycode Frederico can remap one of the keys on his keyboard to
> > generate KEY_SYSRQ. This way SysRq should still work if he plugs in
> > another USB keyboard that has SysRq key or a PS/2 keyboard.
>
> would setkeycodes still just work for PS2 keyboards?
> I upgraded to newer kbd-1.13 package (kernel 2.6.21), and while trying
> to change sysrq keycode still I get the old error:
>
> KDSETKEYCODE: No such device
> failed to set scancode 38b7 to keycode 84
>
> which I reported on gentoo a long time ago:
> http://bugs.gentoo.org/show_bug.cgi?id=97388
>
> (it doesn't use EVIOCSKEYCODE)
> maybe I'm not picking up the right program?
>

EVIOCSKEYCODE support for HID (USB) went in in 2.6.22-rc1.

There is keyfuzz utility you can use to play with keymaps for a
particular device:

       http://0pointer.de/lennart/projects/keyfuzz/

-- 
Dmitry
