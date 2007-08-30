From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] input: Silence 'unused variable' warning in iforce joystick driver
Date: Fri, 31 Aug 2007 00:50:03 +0200
Message-ID: <200708310050.03786.jesper.juhl@gmail.com>
References: <200708310013.12347.jesper.juhl@gmail.com> <alpine.LFD.0.999.0708310422200.31519@enigma.security.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LFD.0.999.0708310422200.31519@enigma.security.iitk.ac.in>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Satyam Sharma <satyam@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>, dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 31/08/2007, Satyam Sharma <satyam@infradead.org> wrote:
...
> 
> Hmm, would this not still give a warning when JOYSTICK_IFORCE_USB=y?

Arrgh, I messed that one up real good...  Thank you for your keen eye Satyam :-)


> [ I didn't know mixing code and declarations (not at top of statement
>   block) was accepted style in the kernel ... ]
> 
It's not the common case, but this is certainly not the only place in the kernel where we do it.


> IMHO either you should at least wrap that case inside a {} of its
> own (so that the int status; is at top of a statement block), or else,

Yeah, I should...

> preferably, just add "__maybe_unused" to the first declaration that you
> removed just now.
> 

Here's an updated patch that actually works as intended.



In the iforce driver we currently get this warning

  drivers/input/joystick/iforce/iforce-packets.c: In function 'iforce_get_id_packet':
  drivers/input/joystick/iforce/iforce-packets.c:249: warning: unused variable 'status'

if CONFIG_JOYSTICK_IFORCE_USB is not defined.

The warning is easy to avoid by simply moving the variable inside
the only case in the switch that actually use it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 3154ccd..2731057 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -246,13 +246,12 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 
 int iforce_get_id_packet(struct iforce *iforce, char *packet)
 {
-	int status;
-
 	switch (iforce->bus) {
 
-	case IFORCE_USB:
-
+	case IFORCE_USB: {
 #ifdef CONFIG_JOYSTICK_IFORCE_USB
+		int status;
+
 		iforce->cr.bRequest = packet[0];
 		iforce->ctrl->dev = iforce->usbdev;
 
@@ -270,6 +269,7 @@ int iforce_get_id_packet(struct iforce *iforce, char *packet)
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
+	}
 #else
 		dbg("iforce_get_id_packet: iforce->bus = USB!");
 #endif
