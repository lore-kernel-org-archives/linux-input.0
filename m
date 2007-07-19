From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq key
Date: Thu, 19 Jul 2007 18:32:24 -0400
Message-ID: <d120d5000707191532x34ec7baen8e0de1155a4882cb@mail.gmail.com>
References: <469A5385.6030402@inwind.it>
	 <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>
	 <469A99ED.3090603@inwind.it>
	 <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
	 <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>
	 <469C647B.1000307@inwind.it>
	 <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>
	 <469E7E29.2050206@inwind.it>
	 <d120d5000707191400w2725bbd1h64add33e3e227bdd@mail.gmail.com>
	 <469FDA19.6020702@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469FDA19.6020702@inwind.it>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: federico ferri <xaero@inwind.it>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 7/19/07, federico ferri <xaero@inwind.it> wrote:
> Dmitry Torokhov ha scritto:
> >> # echo "84 183" | keyfuzz -s -d/dev/input/event1
> >> EVIOCGKEYCODE: Invalid argument
> >>
> >> # echo "84 183" | keyfuzz -s -d/dev/input/event2
> >> EVIOCGKEYCODE: Invalid argument
> >>
> >> # echo "0x05d 0x0b7" | keyfuzz -s -d/dev/input/event2
> >> EVIOCGKEYCODE: Invalid argument
> > What is 84? For SUB you map a "usage" to a keycode and regular key
> > usages start with 0x00070000...
> 84 == 0x5d (KEY_SYSRQ)
> 183 is the code generated from my keyboard when I press F13
>

Ahh, I see. But when you press F13 hardware does not generate 183. USB
generates some big number (below), PS/2 generates sequence like 0x5d
(not sure) and keyboard connected to a serial port generates something
else. Keyfuzz needs scancode in the format that is driver-specific.

> I don't get what "usage" means here;

USB's "scancode".

> my keyboard has no fancy/multimedia
> keys (except 4 buttons_ volumeup, volume-down, mute, eject, but those
> belong to another event device)
>
> the keyfuzz manual page says:
>       The  scancode/keycode  translation  tables  as  read from STDIN
>       [...]. All other lines have to contain a scancode and a keycode
>       number separated by white space. The numbers may be specified
>       either in decimal or in hexadecimal notation. [...]
>
> I typed my commands with the above in mind.
> anyway, if I try to load the bundled translation tables (r.g. the
> default one) to my event device, I get the same error.

That is undersandable because your keyboard is difefrent and does not
use the same "scancodes" as AT keyboard.

>
> do you see some solution? perhaps can you supply an example of
> re-mapping F13 to SysRq?
>

KEY_F13 is normally assigned to usage 0x00070068. Since you want your
F13 to be used as SysRq you need map that usage to KEY_SYSRQ. Please
try doing:

echo "458856 84" | keyfuzz -s -d/dev/input/eventX

-- 
Dmitry
