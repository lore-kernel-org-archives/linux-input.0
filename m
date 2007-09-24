From: Thomas Rohwer <tr@tng.de>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Mon, 24 Sep 2007 15:22:16 +0200
Message-ID: <46F7BA08.6000201@tng.de>
References: <46F54D92.7000300@tng.de>	 <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com> <1190638998.12782.0.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010003070209010805050000"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1190638998.12782.0.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003070209010805050000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

> could you please re-send the patch? I for some reason have yet to see
> it ...

here it is again, adressing also the comments from Dmitry.

Sincerely,

Thomas Rohwer

--------------010003070209010805050000
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

--- linux-2.6.23-rc7/drivers/input/mouse/appletouch.c	2007-09-20 01:01:13.000000000 +0200
+++ linux/drivers/input/mouse/appletouch.c	2007-09-24 15:15:56.000000000 +0200
@@ -328,6 +328,7 @@
 {
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
+	int key;
 	struct atp *dev = urb->context;
 
 	switch (urb->status) {
@@ -469,6 +470,9 @@
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
 			      ATP_YFACT, &y_z, &y_f);
 
+	key= dev->data[dev->datalen - 1] & 1;
+	input_report_key(dev->input, BTN_LEFT, key);
+
 	if (x && y) {
 		if (dev->x_old != -1) {
 			x = (dev->x_old * 3 + x) >> 2;
@@ -505,7 +509,7 @@
 		   the first touch unless reinitialised. Do so if it's been
 		   idle for a while in order to avoid waking the kernel up
 		   several hundred times a second */
-		if (atp_is_geyser_3(dev)) {
+		if (atp_is_geyser_3(dev) && (!key)) {
 			dev->idlecount++;
 			if (dev->idlecount == 10) {
 				dev->valid = 0;
@@ -514,7 +518,6 @@
 		}
 	}
 
-	input_report_key(dev->input, BTN_LEFT, dev->data[dev->datalen - 1] & 1);
 	input_sync(dev->input);
 
 exit:

--------------010003070209010805050000--
