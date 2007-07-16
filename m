From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Keyboard problem
Date: Mon, 16 Jul 2007 09:29:57 -0400
Message-ID: <d120d5000707160629y2c866d1enb2af1e2f89f5f00f@mail.gmail.com>
References: <32209efe0707152028h69b507b1j6ecd6c8e358ead62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <32209efe0707152028h69b507b1j6ecd6c8e358ead62@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Natalie Protasevich <protasnb@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

Hi Natalie,

On 7/15/07, Natalie Protasevich <protasnb@gmail.com> wrote:
> Hello,
> We have a problem with keybords here. It only hits several systems out
> of many, and really impossible to reproduce because it happens on
> different combinations of hardware/software and no one managed to find
> out what triggers it. I had it on my workstation for a while, then it
> was gone (was as of Friday when I hit it again).
> Keyboard stops responding while mouse is still functional, if you hold
> a key for a few seconds it reacts and displays a key (several of
> them). If I hold down well ctrl-alt-F1 then I'm able to switch to text
> screen and keyboard is just fine there. So it happens while X is
> running, seems more likely when memory intensive apps are running
> (firefox, kernel builds). Doesn't depend on type of videocard, whether
> it is double or single monitor configuration, type of mouse (USB or
> PS2 - but our HW guys said the systems have PS2 connector through the
> USB bridge) - nothing seems to matter only presence of X. Restarting X
> fixes a problem, but it is still very disruptive to everyone affected.
> It seems like Linux input driver, USB and X may be involved. What can
> be done to diagnose this problem? There is nothing in the logs, only
> couple messages in X log which tell that screen saver was run a couple
> times and mysterious message about Screen 0 and 1 now "sharing
> resources". Do we need USB sniffer to trace traffic? Anything we can
> do to get information from the kernel? Maybe instrumenting keyboard
> driver and Xorg keyboard library somehow, use kprobes.
> Any recommendations?

What keyboard driver are you using in X? Isit the standard keyboard
driver or xf86-input-evdev? If the former you can try loading evbug
module (which will dump all input events into syslog) and wait for the
condition to appear. Then connect to the box remotely (ssh/telnet) and
see if keypresses still make to syslog. If they do that means that
USB/HID and input core work fine and the propblem lies in the upper
layers.


-- 
Dmitry
