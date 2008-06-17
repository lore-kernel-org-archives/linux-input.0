From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] [RESEND] fix HID quirks for aluminium apple wireless
 keyboards
Date: Tue, 17 Jun 2008 15:54:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806171553490.10085@jikos.suse.cz>
References: <87iqweltzo.fsf@burly.wgtn.ondioline.org>
 <874p7ylsj0.fsf@burly.wgtn.ondioline.org>  <1213301289.17870.72.camel@violet.holtmann.net>
  <87tzfwiguc.fsf@burly.wgtn.ondioline.org> <1213446160.17870.145.camel@violet.holtmann.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38527 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752862AbYFQNy5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Jun 2008 09:54:57 -0400
In-Reply-To: <1213446160.17870.145.camel@violet.holtmann.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Paul Collins <paul@burly.ondioline.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, 14 Jun 2008, Marcel Holtmann wrote:

> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > index 519cdb9..62f174a 100644
> > --- a/net/bluetooth/hidp/core.c
> > +++ b/net/bluetooth/hidp/core.c
> > @@ -676,6 +676,12 @@ static const struct {
> >  	__u16 idProduct;
> >  	unsigned quirks;
> >  } hidp_blacklist[] = {
> > +	/* Apple Wireless Keyboard, ANSI layout */
> > +	{ 0x05ac, 0x022c, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> > +	/* Apple Wireless Keyboard, ISO layout */
> > +	{ 0x05ac, 0x022d, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
> > +	/* Apple Wireless Keyboard, JIS layout */
> > +	{ 0x05ac, 0x022e, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
> >  	/* Apple wireless Mighty Mouse */
> >  	{ 0x05ac, 0x030c, HID_QUIRK_MIGHTYMOUSE | HID_QUIRK_INVERT_HWHEEL },
> However depending on if Jiri's changes for the HID bus are ready, this
> patch might become obsolete.

This is however still not merged yet -- there is still some minor work to 
do. So I am now merging the incoming stuff as it comes, and hidbus patches 
will then be easily rebased.

So please, proceed with this patch through your/DaveM's tree, if you like 
to.

Thanks,

-- 
Jiri Kosina
SUSE Labs
