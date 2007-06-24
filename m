From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Anything against a new EV_SW SW_RADIO event ?
Date: Sun, 24 Jun 2007 07:55:14 -0300
Message-ID: <20070624105514.GA8909@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, ibm-acpi-devel@lists.sourceforge.net, Ivo van Doorn <ivdoorn@gmail.com>, Richard Hughes <hughsient@gmail.com>
List-Id: linux-input@vger.kernel.org

Dmitry,

Could you ACK the attached patch?  I am about to send in code that would
benefit a damn great deal from it (thinkpad-acpi support for the
T60/X60/newer radio-kill slider switch)...  So I thought it would be best to
check with you first if I can have an EV_SW SW_RADIO...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

commit f5752eca1ffed72ce32c42f15b16cb4d240901c1
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Sat Jun 23 23:55:22 2007 -0300

    INPUT: add a new EV_SW SW_RADIO event, for radio switches on laptops
    
    Many laptops have rf-kill physical switches that are not keys, but slider
    or rocker switches.  Often (like in all ThinkPads with a radio kill slider
    switch), they have both a slider/rocker switch and a hot key.
    
    Trying to kludge a real switch to act like a key is not a very smart thing
    to do if you can help it, and it gets specially bad when you are going to
    have both in the same machine.  So, we do the right thing and add an input
    EV_SW event for radio kill switches.
    
    The EV_SW SW_RADIO event is defined with positive logic, i.e. when the
    switch is active, the radios are to be enabled.  When the switch is
    inactive, the radios are to be disabled.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Cc: Ivo van Doorn <ivdoorn@gmail.com>
    Cc: Richard Hughes <hughsient@gmail.com>

diff --git a/include/linux/input.h b/include/linux/input.h
index bde65c8..b530678 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -602,6 +602,7 @@ struct input_absinfo {
 #define SW_LID			0x00  /* set = lid shut */
 #define SW_TABLET_MODE		0x01  /* set = tablet mode */
 #define SW_HEADPHONE_INSERT	0x02  /* set = inserted */
+#define SW_RADIO		0x03  /* set = radio enabled */
 #define SW_MAX			0x0f
 
 /*
