From: Bastien Nocera <hadess@hadess.net>
Subject: Annoying keys on AT keyboards
Date: Tue, 29 May 2007 23:21:08 +0100
Message-ID: <1180477268.3030.111.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Heya,

My Dell laptop has a good bunch of keys that show this behaviour:
Apr 25 11:23:10 snoogens kernel: atkbd.c: Unknown key pressed
(translated set 2,
code 0x87 on isa0060/serio0).
Apr 25 11:23:10 snoogens kernel: atkbd.c: Use 'setkeycodes e007 <keycode>' to
make it known.

Given that all Dell laptops generate this kind of behaviour, that all
the keys match on all the models (I know about), would it be
possible/sane to add some code to the AT keyboard driver to handle those
keys when the DMI matches?

I can think of a number of reasons why it would be a bad idea:
- overly complicated driver that handles a lot of "broken" hardware
cases
- slippery-slope (next it's for IBM/Sony/whatever laptops/keyboards,
etc.)

But I'd rather have this done completely in kernel space, where it
belongs (after all, that's the point of drivers to handle hardware
through common interfaces).

Any comments, ideas on how to do this as cleanly and unobtrusively?

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 
