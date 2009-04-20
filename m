From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Rawmode keyboard for your....
Date: Mon, 20 Apr 2009 00:04:49 -0700
Message-ID: <200904200004.49651.dmitry.torokhov@gmail.com>
References: <20090326185925.79ca6833.kristoffer.ericson@gmail.com> <BD79186B4FD85F4B8E60E381CAEE1909014E279A@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:10237 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZDTHFA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 03:05:00 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1760722rvb.1
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2009 00:04:58 -0700 (PDT)
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909014E279A@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@vger.kernel.org

On Thursday 26 March 2009 11:30:43 H Hartley Sweeten wrote:
> On Thursday, March 26, 2009 10:59 AM, Kristoffer Ericson wrote:
> > Greetings,
>
> Hello
>
> > What exactly does this build warning imply?
> > We have a fully working keyboard driver for the Jornada 700-series
> > and would really like to get rid of this.
> >
> >
> >  CC      drivers/char/keyboard.o
> > drivers/char/keyboard.c:1126:2: warning: #warning "Cannot generate
>
> rawmode keyboard for your architecture yet."
>
> > drivers/char/keyboard.c:1126:2: warning: #warning "Cannot generate
>
> rawmode keyboard for your architecture yet."
>
> It means just what it says, if you put the keyboard into VC_RAW mode you
> will not get the expected key codes.
>
> But... Hmm... Jornada 700-series is arm/mach-sa1100 (CONFIG_ARM)...
>
> Looks like if you enable CONFIG_KEYBOARD_ATKBD the build warning message
> will go away.
>

I think we should just remove the warning. It does not make much sense
anymore. I intend to apply the patch below.

-- 
Dmitry

Input: keyboard - remove warning about raw mode not supported

This warning made sense when legacy keyboard driver was preferred
driver in X, but now that evdev driver is the default we can remove
the warning.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/keyboard.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index de26a97..737be95 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1123,8 +1123,6 @@ static int emulate_raw(struct vc_data *vc, unsigned int 
keycode,
 
 #define HW_RAW(dev)	0
 
-#warning "Cannot generate rawmode keyboard for your architecture yet."
-
 static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsigned 
char up_flag)
 {
 	if (keycode > 127)



