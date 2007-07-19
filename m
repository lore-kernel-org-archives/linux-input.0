From: federico ferri <xaero@inwind.it>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Fri, 20 Jul 2007 01:29:29 +0200
Message-ID: <469FF3D9.4080307@inwind.it>
References: <469A5385.6030402@inwind.it>	 <alpine.LFD.0.999.0707151156090.20061@woody.linux-foundation.org>	 <469A99ED.3090603@inwind.it>	 <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>	 <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>	 <469C647B.1000307@inwind.it>	 <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>	 <469E7E29.2050206@inwind.it>	 <d120d5000707191400w2725bbd1h64add33e3e227bdd@mail.gmail.com>	 <469FDA19.6020702@inwind.it> <d120d5000707191532x34ec7baen8e0de1155a4882cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000707191532x34ec7baen8e0de1155a4882cb@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, mzxrlshmm@0pointer.de
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov ha scritto:
>> do you see some solution? perhaps can you supply an example of
>> re-mapping F13 to SysRq?
>>
>
> KEY_F13 is normally assigned to usage 0x00070068. Since you want your
> F13 to be used as SysRq you need map that usage to KEY_SYSRQ. Please
> try doing:
>
> echo "458856 84" | keyfuzz -s -d/dev/input/eventX

oh, great! finally I got to remap F13 to SysRq (which was keycode 99).
would be nice to have some informations in the manpage about how to 
find/dump those raw scancodes, cause with showkey/evtest I only see 
translated keycodes. [I added keyfuzz's author to CC ;)]

thank you Dmitry
-- 
Federico Ferri
