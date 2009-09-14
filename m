From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [PATCH] Input: bcm5974.c initialize raw_w, raw_x and raw_y
 before it get used
Date: Mon, 14 Sep 2009 14:30:53 +0530
Message-ID: <1252918853.3123.5.camel@ht.satnam>
References: <1252775770.3687.7.camel@ht.satnam>
	 <4AAC2DBE.9040303@bitmath.org> <1252830690.3440.5.camel@ht.satnam>
	 <4AACD9E9.4000702@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43140 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbZINJBC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 05:01:02 -0400
In-Reply-To: <4AACD9E9.4000702@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

Hello Henrik,

On Sun, 2009-09-13 at 13:39 +0200, Henrik Rydberg wrote:
> Jaswinder Singh Rajput wrote:
> > On Sun, 2009-09-13 at 01:24 +0200, Henrik Rydberg wrote:
> >> Jaswinder Singh Rajput wrote:
> >>> raw_w, raw_x and raw_y is used uninitialized for !raw_n
> >> Thanks for the heads up, but actually not, since !raw_n also implies
> >> !(ptest > PRESSURE_LOW).
> >>
> > 
> > Then can we move 'if (ptest > PRESSURE_LOW && origin)' stuff to 'if
> > (raw_n)'. If not then my patch is correct.
> 
> Yes, that's it, thanks. So this patch ought to solve the warning cleanly:

hmm, even then there is room for improvement and save some cpu cycles :

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 2d8fc0b..21ea2e3 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -316,8 +316,7 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 	const struct bcm5974_config *c = &dev->cfg;
 	const struct tp_finger *f;
 	struct input_dev *input = dev->input;
-	int raw_p, raw_w, raw_x, raw_y, raw_n;
-	int ptest = 0, origin = 0, ibt = 0, nmin = 0, nmax = 0;
+	int raw_n, ibt = 0, nmin = 0, nmax = 0;
 	int abs_p = 0, abs_w = 0, abs_x = 0, abs_y = 0;
 
 	if (size < c->tp_offset || (size - c->tp_offset) % SIZEOF_FINGER != 0)
@@ -329,6 +328,9 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 
 	/* always track the first finger; when detached, start over */
 	if (raw_n) {
+		int raw_p, raw_w, raw_x, raw_y;
+		int ptest, origin;
+
 		raw_p = raw2int(f->force_major);
 		raw_w = raw2int(f->size_major);
 		raw_x = raw2int(f->abs_x);


And by changing little bit programming logic you can also reduce
variable count and save some more cpu cycles.

Thanks,
--
JSR

