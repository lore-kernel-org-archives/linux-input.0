From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: [PATCH 0/3] wistron_btns: More keymaps, take 2
Date: Sun, 18 Mar 2007 22:10:10 +0100
Message-ID: <45FDAAB2.8010208@tremplin-utc.net>
References: <45ECA23A.5010503@tremplin-utc.net> <d120d5000703060536k7743ece9hb20fa4d1f7ad7ad7@mail.gmail.com> <45ED8809.70309@tremplin-utc.net> <45F72D37.6090004@tremplin-utc.net> <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com> <20070314182559.GC5264@suse.cz> <d120d5000703141158t4d02b8b7pc4ab967722dac@mail.gmail.com> <20070314190254.GA5843@suse.cz> <45F91F73.8040200@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45F91F73.8040200@tremplin-utc.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hello,

This is a new version of my patch to add support for more laptops to the 
wistron_btns driver. Modifications from the previous version:
* sends lid close/open event as a switch event (not a key event)
* Display on/off is KEY_SCREEN and Display selection is 
KEY_SWITCHVIDEOMODE, from the discussion they seemed the "less bad" 
keycodes.
* keymaps are now declared initdata in order to save some memory


Patch 1 adds all the database of acerhk which fits this driver (about 25 
more laptops).
Patch 2 adds a generic map that should fit most users but has the 
disadvantage of not being automatic.
Patch 3 declares all the keymaps as initdata and copy the right one in 
memory.

Dmitry, I've tried to make them against your tree (tm610 already 
applied). Still, if they don't apply cleanly, just tell me and I'll try 
harder!

See you,
Eric
