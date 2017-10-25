From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: RE: [PATCH v2 0/4] Quirks cleanup and hid-generic niceness
Date: Wed, 25 Oct 2017 11:15:45 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710251115040.9294@jbgna.fhfr.qr>
References: <20171003145729.3135-1-benjamin.tissoires@redhat.com>  <VI1PR0701MB2991B256AEAD1B643B4A7527DA440@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <VI1PR0701MB2991B256AEAD1B643B4A7527DA440-unnVr81DUEGzB3qckAdg/TMcllmSiLMWnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Niels Skou Olsen <nolsen-qGsLMUQfN6MAvxtiuMwx3w@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 25 Oct 2017, Niels Skou Olsen wrote:

> > > Niels found an issue with v1 of the series, while compiling the usbhid
> > > module as a separate .ko.
> > >
> > > Sending a v2 with the proper From: field fixed now.
> > >
> >
> > I have built it on for-next and tested it with no apparent issues. Also, I have
> > Rebased/simplified my 2 pending patches on top of it, and will submit v2s shortly.
> 
> Tested-by: Niels Skou Olsen <nolsen-qGsLMUQfN6MAvxtiuMwx3w@public.gmane.org>
> 
> Sorry for pinging this. I know the patch is touching core HID, so the 
> reviewer candidates are probably few.
> 
> Has anyone had time to look at this?

It's one the first things I'd like to process once kernel summit is over.

Thanks for patience,

-- 
Jiri Kosina
SUSE Labs
