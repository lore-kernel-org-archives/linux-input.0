From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
Date: Wed, 23 May 2012 15:55:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205231554450.30445@pobox.suse.cz>
References: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com> <CAAngNMabAxO9fVN2DM=5xPJAVk_is3QoS1=+TGZPJAbY3TYHMQ@mail.gmail.com> <CANq1E4QaRHtGxt3d=Z2mvqAFhTY2zid20GGNZ2ZzHjStGepc+A@mail.gmail.com> <alpine.LNX.2.00.1205101218030.31253@pobox.suse.cz>
 <CANq1E4R_6ByuBALh0z9gxQzy5ZrT4-MY=6RqrcaVFgK0owjtxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANq1E4R_6ByuBALh0z9gxQzy5ZrT4-MY=6RqrcaVFgK0owjtxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Joao Paulo Rechi Vita <jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 20 May 2012, David Herrmann wrote:

> >> > Thanks for your work, David. I'll test and review this new version.
> >> > Did you find out the what is the problem when passing BUS_BLUETOOTH on
> >> > the 'bus' field of the create request?
> >>
> >> I've spent some time looking into that but I haven't found the
> >> problem, yet. Maybe Jiri can comment here.
> >
> > This should now all be handled correctly using the hid-generic mechanism.
> > If you still see any problems with this (currently in linux-next, more
> > precisely 'device-groups' branch in hid.git), please let me know.
> 
> That is working correctly now. 

Thanks for checking.

> Do you have any update on this patch? There is no time pressure in 
> merging it but I would like to get some feedback what you are thinking 
> about it so I can continue working on it.
> 
> If you like I can resend it split into multiple patches. Let me know
> of any problems with it.

Yes, that would be very much preferred on my side -- huge condensed 
patches are much harder to review (if the split is done properly). Thanks!

-- 
Jiri Kosina
SUSE Labs
