From: Bastien Nocera <hadess@hadess.net>
Subject: screen auto brightness key
Date: Tue, 05 Jun 2007 18:27:11 +0100
Message-ID: <1181064431.25009.181.camel@cookie.hadess.net>
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
Cc: Richard Hughes <hughsient@gmail.com>
List-Id: linux-input@vger.kernel.org

Heya,

We've just landed some HAL software to map "unknown scancodes" to proper
input keys, as listed in linux/input.h and I can't seem to find a good
match for the "ALS" key on my Dell computer.

The "Auto Light Sensing" key turns on/off the hardware monitor for
brightness and ajusts the screen brightness in consequence.

It's similar to KEY_KBDILLUMTOGGLE, but for screens. Is there a match I
couldn't find, or should I kindly ask for the key to be added?

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 
