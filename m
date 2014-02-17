From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big
 enough
Date: Mon, 17 Feb 2014 15:07:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171506450.1192@pobox.suse.cz>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com> <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org> <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com> <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
 <CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com> <alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz> <alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz> <CANq1E4TW+GU=oaW0tXb=Tun9HMtr26u-PC3H6BsLot560ANgog@mail.gmail.com>
 <alpine.LNX.2.00.1402031107310.14066@pobox.suse.cz> <CANq1E4S++uqMzQue_0jC3N=Lm8Os5V-48Hw5M4vWvM+2Vx91yA@mail.gmail.com> <alpine.LNX.2.00.1402041446130.14066@pobox.suse.cz> <20573666-E2A0-4D6B-986A-09DAFC0FB64B@holtmann.org>
 <alpine.LNX.2.00.1402051648470.8614@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1402051648470.8614-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Cc: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:HID CORE LAYER" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org development" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 5 Feb 2014, Jiri Kosina wrote:

> > >>>>> just got back to this, finally ... did you have time to work on this at
> > >>>>> all, or should I just start from scratch?
> > >>>> 
> > >>>> Sorry, no. Fosdem is this weekend and I needed to get my code ready
> > >>>> for that. But I'll finally have time again next week.
> > >>> 
> > >>> Okay, thanks. I then guess we should proceed with this bandaid (double
> > >>> allocation) for 3.14
> > >> 
> > >> It would be really nice if we could get the HIDP patch into 3.14-rc2
> > >> and backported to stable. There have been quite a bunch of reports now
> > >> and I dislike adding a GFP_ATOMIC allocation in HID core. 
> > > 
> > > I agree with David; Gustavo, what is your take on this, please?
> > 
> > I leave this up to Gustavo to get this into wireless tree for 3.14-rc2.
> > 
> > Acked-by: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
> 
> Thanks a lot.
> 
> Gustavo, what is your take on this please? I can take it through hid.git 
> in case you don't have anything else queued for -rc2.

... ping?

In case this doesn't get reacted upon by the end of the week, I am 
inclined to take it through hid.git.

Thanks,

-- 
Jiri Kosina
SUSE Labs
