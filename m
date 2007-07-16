From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: Keyboard problem
Date: Sun, 15 Jul 2007 21:28:37 -0600
Message-ID: <32209efe0707152028h69b507b1j6ecd6c8e358ead62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dtor@mail.ru>, Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

Hello,
We have a problem with keybords here. It only hits several systems out
of many, and really impossible to reproduce because it happens on
different combinations of hardware/software and no one managed to find
out what triggers it. I had it on my workstation for a while, then it
was gone (was as of Friday when I hit it again).
Keyboard stops responding while mouse is still functional, if you hold
a key for a few seconds it reacts and displays a key (several of
them). If I hold down well ctrl-alt-F1 then I'm able to switch to text
screen and keyboard is just fine there. So it happens while X is
running, seems more likely when memory intensive apps are running
(firefox, kernel builds). Doesn't depend on type of videocard, whether
it is double or single monitor configuration, type of mouse (USB or
PS2 - but our HW guys said the systems have PS2 connector through the
USB bridge) - nothing seems to matter only presence of X. Restarting X
fixes a problem, but it is still very disruptive to everyone affected.
It seems like Linux input driver, USB and X may be involved. What can
be done to diagnose this problem? There is nothing in the logs, only
couple messages in X log which tell that screen saver was run a couple
times and mysterious message about Screen 0 and 1 now "sharing
resources". Do we need USB sniffer to trace traffic? Anything we can
do to get information from the kernel? Maybe instrumenting keyboard
driver and Xorg keyboard library somehow, use kprobes.
Any recommendations?
Thanks,
--Natalie
