From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: [PATCH BlueZ 0/4] Sixaxis Plugin, almost there?
Date: Fri,  5 Aug 2011 16:09:14 +0200
Message-ID: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, Arc Riley <arcriley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

I hope we are getting there, this is another update to the sixaxis plugin.

The first patch is the same as always, removal of old cruft which I think 
could go in even right now.


The second patch is the sixaxis plugin with some updates:
  
  - Fixed various style issues (long lines, indentation)
  - Fixed some style issue pointed out by checkpatch.pl from linux, 
    namely it suggested not to initialize static variables.
  - Fixed issue pointed out by Vinicius Costa Gomez:
      * remove double newlines
      * move defines and static variables on the top
      * Add a comment about why the timeout is needed in monitor_event()
  - Use manager_get_default_adapter_id() as suggested by Bastien
  - Make return values more meaningful
  - Set the master bdaddr in the controller only when it is different 
    from the BT adapter bdaddr, this is how the PS3 does it (thanks Jim 
    for the dumps), perhaps to avoid unnecessary writes to some eeprom.

I left in the calloc() calls for now, maybe later I'll split the plugin 
in a sixaxis-specific part and a bluez-specific part, but for now I 
think we can live with that. I also left the return codes called "ret" 
because they didn't fit the "err" semantic, as I am checking for < 0.


The third patch is about linking UDEV_LIBS only when needed, embedded 
people might like this but I was not sure and I left is a separate patch 
for an easier review.


The forth patch makes the plugin wait for actual events (that is: PS button 
has been pressed) before setting the leds, this is how the PS3 behaves, and 
happens to cure the problem of setting the second led when connecting the 
controller via USB when it is working over BT already, in fact the controller 
keep sending events over BT even after it is connected via USB after 
association, and so the USB connection event will not set the second led on 
ever. The trick works with one controller, but I think this will mess up 
numbering with multiple controller connected in some mixed order. So again 
this change is sent in its own patch to be more visible.

For those of you who can't get the plugin to work, please try cleaning 
up your /var/lib/bluetooth dir.


NOTES:

  - Testing is needed with multiple BT adapters and/or multiple 
    controllers, but I haven't got the hardware for that yet.

  - Arc Riley suggested to use more generic name for the plugin if it is 
    going to support the Move too, something like "sony-controllers" 
    maybe, but I don't mind leaving it called sixaxis for historical 
    reasons (and laziness reasons too), what do you think?


Thanks,
   Antonio

Antonio Ospite (4):
  Remove input/sixpair.c
  Add sixaxis plugin: USB pairing and LEDs settings
  Link to udev only when needed
  plugins/sixaxis: Wait for the PS button before setting the LEDs

 Makefile.am       |   11 +-
 acinclude.m4      |   10 +
 input/sixpair.c   |  299 --------------------------
 plugins/sixaxis.c |  599 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 619 insertions(+), 300 deletions(-)
 delete mode 100644 input/sixpair.c
 create mode 100644 plugins/sixaxis.c

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
