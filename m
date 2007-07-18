From: federico ferri <xaero@inwind.it>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Wed, 18 Jul 2007 22:55:05 +0200
Message-ID: <469E7E29.2050206@inwind.it>
References: <469A5385.6030402@inwind.it>	 <alpine.LFD.0.999.0707151102250.20061@woody.linux-foundation.org>	 <469A68CC.5040902@inwind.it>	 <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>	 <469A99ED.3090603@inwind.it>	 <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>	 <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>	 <469C647B.1000307@inwind.it> <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov ha scritto:
> EVIOCSKEYCODE support for HID (USB) went in in 2.6.22-rc1.
>
> There is keyfuzz utility you can use to play with keymaps for a
> particular device:
>
>       http://0pointer.de/lennart/projects/keyfuzz/
hi Dmitry,
I tried keyfuzz, but I'm not able to change sysrq key (I get an invalid 
argument error).
I paste some log of my tries:

# uname -r
2.6.22

# for i in /dev/input/event*; do echo -e ">>>> $i:"; keyfuzz -i -d$i; done
 >>>> /dev/input/event0:
evdev driver version 1.0.0.
device name: PC Speaker
 >>>> /dev/input/event1:
evdev driver version 1.0.0.
device name: Mitsumi Electric Apple Extended USB Keyboard
 >>>> /dev/input/event2:
evdev driver version 1.0.0.
device name: Mitsumi Electric Apple Extended USB Keyboard
 >>>> /dev/input/event3:
evdev driver version 1.0.0.
device name: Microsoft Basic Optical Mouse

# echo "84 183" | keyfuzz -s -d/dev/input/event1
EVIOCGKEYCODE: Invalid argument

# echo "84 183" | keyfuzz -s -d/dev/input/event2
EVIOCGKEYCODE: Invalid argument

# echo "0x05d 0x0b7" | keyfuzz -s -d/dev/input/event2
EVIOCGKEYCODE: Invalid argument

(strace gives me no useful info)
