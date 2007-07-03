From: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Subject: [ANNOUNCE] evmapd - An input event remapping daemon
Date: Tue, 3 Jul 2007 13:47:49 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0707031321370.20943@rhama.deepcore.ngn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

I'd like to announce the first testing release of evmapd. Its homepage 
will for the foreseeable future reside at:

http://www.softlab.ece.ntua.gr/~thkala/projects/evmapd/evmapd.html

evmapd is a daemon for the remapping of input events on Linux. It uses the 
evdev interface to access an input device and then the uinput interface to 
create a virtual device to which the altered events are relayed.

It can be used to remap keys, buttons and axis, or to perform some more 
complex translations between different event types, such as remapping the 
POV switches of a joystick to sets of buttons (gamers using WINE will 
probably find this useful).

As a treat, it incorporates an auto-calibration algorithm for ABS axis 
events, which is relatively functional and may be useful for some joystick 
owners. People who used my kjscal kernel module (if any - speak up if you 
did :-) will find this functionality very familiar (probably because it's 
exactly the same algorithm).

Any comments, suggestions and bug reports are welcome. Patches and 
bugfixes even more so. I am especially interested in real life use 
examples of evmapd.


Cheers,

Theodoros Kalamatianos


PS: And, yes, kjscal is as of now an unsupported project. Deprecated. 
Terminated. Dead and buried. You get the idea...

PS2: Ummm, BTW evmapd does not do force-feedback. Can't really code that 
one without some FF hardware...
