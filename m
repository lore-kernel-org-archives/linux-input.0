From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: USB reset xhci_hcd for ELAN touchscreen
Date: Thu, 21 Aug 2014 13:38:26 -0500 (CDT)
Message-ID: <alpine.LNX.2.00.1408211337050.23162@pobox.suse.cz>
References: <874n047rre.fsf@nemi.mork.no> <Pine.LNX.4.44L0.1406011203140.16904-100000@netrider.rowland.org> <20140601174321.GA29188@kroah.com> <20140707092442.GF29098@localhost> <20140708053430.GA840@kroah.com> <20140709130733.GA10078@localhost>
 <20140714182526.GA12963@localhost> <alpine.LNX.2.00.1408200817330.23162@pobox.suse.cz> <20140821105407.GF24090@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46930 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbaHUSib (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 14:38:31 -0400
In-Reply-To: <20140821105407.GF24090@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, =?ISO-8859-15?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Drew Von Spreecken <drewvs@gmail.com>, linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>, linux-input@vger.kernel.org

On Thu, 21 Aug 2014, Johan Hovold wrote:

> > It's not really super-nice, but if no other way around it has been found 
> > to be possible in USB core, I am willing to take this.
> 
> Agreed, it's not that nice, but I'm not aware of any other way to
> prevent the device firmware from disconnecting.
> 
> Autosuspend still seems to work, so it would not cause much overhead
> for people not actually using the touchscreen (as long as autosuspend
> is enabled) either.

Okay, good. Will be waiting for your polished patch for this.

[ ... snip ... ]
> > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > index 77632cf..13f81ae 100644
> > > --- a/include/linux/hid.h
> > > +++ b/include/linux/hid.h
> > > @@ -286,6 +286,7 @@ struct hid_item {
> > >  #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
> > >  #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
> > >  #define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
> > > +#define HID_QUIRK_IN				0x00000400
> > 
> > 0x00000400 has been removed before dynamic quirks started to be possible, 
> > so there is no potential clash, that's fine.
> > 
> > I'd just propose some more descriptive name for the quirk ... how about 
> > something like HID_QUIRK_EARLY_INTERRUPT?
> 
> Yeah, IN was just a working name. How about HID_QUIRK_ALWAYS_POLL or
> similar as it is not just about disconnect before the device is opened,
> but also if there's an event after the device has been closed (e.g.
> stopping X)?

HID_QUIRK_ALWAYS_POLL sounds good.

Thanks,

-- 
Jiri Kosina
SUSE Labs
