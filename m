From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Input: synaptics - reject out of range position values
Date: Fri, 8 Jun 2012 11:53:13 -0500
Message-ID: <20120608165313.GA27117@thinkpad-t410>
References: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com>
 <20120606153538.GC23884@thinkpad-t410>
 <CAGS+omBQ0PLvjRFVWrSSm1v3fegO5V968s7kLT3hGj3+Bhoebg@mail.gmail.com>
 <20120607195658.GB15138@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39371 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681Ab2FHQxR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jun 2012 12:53:17 -0400
Content-Disposition: inline
In-Reply-To: <20120607195658.GB15138@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Jun 07, 2012 at 02:56:58PM -0500, Seth Forshee wrote:
> > Or, alternatively, we could actually report negative values to
> > userspace in this case:
> > 
> > y = (y <= 6143) ? y : (y - 8192);
> 
> Well, they won't be negative anymore when userspace sees them ;)
> 
> But yeah, either of these should work. I don't feel like it's necessary
> since this is apparently a one-off problem on aging hardware, and since
> Windows also doesn't seem to be using the portion of the touchpad
> reporting the out of range values (although humorously I can get the
> pointer to jump sometimes under Windows too). Between the two
> implementations you suggest I'd feel more comfortable with the latter,
> as it should leave the values reported unchanged for other hardware.
> 
> I do have one question I'd still like to clear up. Am I correct in
> interpreting the Synaptics documentation to say that the touchpads
> should never report values greater than 6143, even for models that
> report the maximum possible x/y values? That's what I think it's saying,
> but I also feel like there's a little ambiguity on the point. Especially
> since I'm already seeing values outside of the documented range :)

The following is working fine for me, if you think this would be
preferable. The only downside I see is that if there are touchpads out
there that exceed 6143 then this is likely to cause them to start
behaving oddly.


>From 2664e38cbebe7e9de652d22d9bc408dd210e6c0b Mon Sep 17 00:00:00 2001
From: Seth Forshee <seth.forshee@canonical.com>
Date: Fri, 8 Jun 2012 10:19:39 -0500
Subject: [PATCH] Input: synaptics - handle negative values on the y axis

The touchpad on the Acer Aspire One D250 will report out of range values
in the extreme lower portion of the touchpad. These appear as abrupt
changes in the values reported by the hardware from very low values to
very high values, which can cause unexpected vertical jumps in the
position of the mouse pointer.

What seems to be happening is that the value is wrapping to a negative
13-bit value, which is being truncated to the 12-bit range reported in
the touchpad packets. In order to deal with this, convert values outside
the maximum y axis value specified by synaptics to the appropriate
negative value.

BugLink: http://bugs.launchpad.net/bugs/1001251
Cc: stable@vger.kernel.org
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/input/mouse/synaptics.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index e07eb9b..7dc1bd5 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -40,6 +40,7 @@
  * Note that newer firmware allows querying device for maximum useable
  * coordinates.
  */
+#define YMAX 6143
 #define XMIN_NOMINAL 1472
 #define XMAX_NOMINAL 5472
 #define YMIN_NOMINAL 1408
@@ -555,6 +556,15 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
 	}
 
+	/*
+	 * Some Synaptics touchpads have been known to wrap negative
+	 * on the y axis. These appear to be a 13-bit negative numbers
+	 * truncated to a 12-bit value. To work around this, treat any
+	 * value above the upper limit defined by Synaptics as actually
+	 * being a negative 13-bit value.
+	 */
+	hw->y = (hw->y <= YMAX) ? hw->y : (hw->y - 8192);
+
 	return 0;
 }
 
-- 
1.7.9.5

