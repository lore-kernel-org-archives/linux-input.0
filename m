From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] input: keyboard: introduce lm8323 driver
Date: Sat, 21 Feb 2009 00:52:48 +0200
Message-ID: <20090220225247.GY32564@gandalf>
References: <1235046677-29959-1-git-send-email-me@felipebalbi.com> <20090220141505.d1d53e4b.akpm@linux-foundation.org> <20090220222911.GV32564@gandalf>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38314 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbZBTWwy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2009 17:52:54 -0500
Content-Disposition: inline
In-Reply-To: <20090220222911.GV32564@gandalf>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, felipe.balbi@nokia.com

On Sat, Feb 21, 2009 at 12:29:12AM +0200, Felipe Balbi wrote:
> On Fri, Feb 20, 2009 at 02:15:05PM -0800, Andrew Morton wrote:
> > On Thu, 19 Feb 2009 14:31:17 +0200
> > Felipe Balbi <me@felipebalbi.com> wrote:
> > 
> > > +struct lm8323_platform_data {
> > > +	int debounce_time; /* Time to watch for key bouncing, in ms. */
> > > +	int active_time; /* Idle time until sleep, in ms. */
> > > +
> > > +	int size_x;
> > > +	int size_y;
> > > +	int repeat : 1;
> > 
> > lm8323_platform_data.repeat appears to be never-written-to?
> 
> Nobody is using that yet, still it's used in the driver:
> 	if (pdata->repeat)
> 		__set_bit(EV_REP, idev->evbit);
> 
> Also, those spaces around : should vanish. Want me to resend the whole
> patch or just a patch on top of it ?

well, I'm stopping for today (almost 1am), here's an update patch. If
you need me to resend the patch, I can do it when I wake up, just bug me
;-)

diff --git a/include/linux/i2c/lm8323.h b/include/linux/i2c/lm8323.h
index 37f819b..67e82bc 100644
--- a/include/linux/i2c/lm8323.h
+++ b/include/linux/i2c/lm8323.h
@@ -33,7 +33,7 @@ struct lm8323_platform_data {
 
        int size_x;
        int size_y;
-       int repeat : 1;
+       int repeat:1;
        const s16 *keymap;
 
        char *pwm1_name; /* Device name for PWM1. */

-- 
balbi
