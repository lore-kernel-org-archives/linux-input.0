From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 2/2] Eliminate double kfree
Date: Thu, 29 May 2008 15:05:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805291504400.26229@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756975AbYE2NFw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

The variable report is only non-NULL and non-freed in a small region of
code, so it should only be freed in error handling code that comes from
that region.

This was found using the following semantic match.
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r1@
expression E;
position p1,p2;
@@

kfree@p1(E);
...
kfree@p2(E);

@subexps@
expression E1;
position r1.p1,p;
@@

kfree@p1(<+... E1@p ...+>);

@recollect@
position subexps.p;
expression E1;
@@

E1@p

@doublekfree@
position r1.p1,r1.p2;
expression recollect.E1,E2,E;
position p;
statement S;
@@

kfree@p1(E);
<+... E1@p=E2 ...+> // the actual semantic match contains other assignments
kfree@p2(E);

@notdoublekfree@
position r1.p1,r1.p2;
position any doublekfree.p;
expression E,E1,E2;
@@

* kfree@p1(E);
... when != E1@p
    when != E1@p = E2 // needed to match a variable decl
* kfree@p2(E);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
---

diff -u -p a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
--- a/drivers/input/tablet/gtco.c	2008-05-09 16:46:57.000000000 +0200
+++ b/drivers/input/tablet/gtco.c	2008-05-29 14:12:31.000000000 +0200
@@ -926,7 +926,7 @@ static int gtco_probe(struct usb_interfa
 		err("Failed to get HID Report Descriptor of size: %d",
 		    hid_desc->wDescriptorLength);
 		error = -EIO;
-		goto err_free_urb;
+		goto err_free_report;
 	}
 
 	/* Now we parse the report */
@@ -982,13 +982,14 @@ static int gtco_probe(struct usb_interfa
 
 	return 0;
 
+ err_free_report:
+	kfree(report);
  err_free_urb:
 	usb_free_urb(gtco->urbinfo);
  err_free_buf:
 	usb_buffer_free(gtco->usbdev, REPORT_MAX_SIZE,
 			gtco->buffer, gtco->buf_dma);
  err_free_devs:
-	kfree(report);
 	input_free_device(input_dev);
 	kfree(gtco);
 	return error;
