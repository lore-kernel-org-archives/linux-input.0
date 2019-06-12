From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] HID: wacom: Don't report anything prior to the tool
 entering range
Date: Wed, 12 Jun 2019 09:10:42 +0200
Message-ID: <20190612071042.GA13698@kroah.com>
References: <CANRwn3Ru+7FGtsY=GaDa7pAJkuagdb6nFtvrFq1qhTWJR0rF9A@mail.gmail.com>
 <20190426163531.9782-1-jason.gerecke@wacom.com>
 <CANRwn3RBK41mRJKUPDDptoq_So6_7UxR0toaauZvjT5U=OaHWw@mail.gmail.com>
 <20190611192248.GB19775@kroah.com>
 <CANRwn3SNAQccFQEaw7Qg=hNojbFVkFRHLT3tzq_BtxpUNRiMUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANRwn3SNAQccFQEaw7Qg=hNojbFVkFRHLT3tzq_BtxpUNRiMUw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: "# v3.17+" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 11, 2019 at 01:45:36PM -0700, Jason Gerecke wrote:
> On Tue, Jun 11, 2019 at 12:22 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Jun 11, 2019 at 12:02:47PM -0700, Jason Gerecke wrote:
> > > I haven't been keeping a close eye on this and just noticed that this
> > > patch set doesn't seem to have been merged into stable. There's also a
> > > second patch series (beginning with "[PATCH 1/3] HID: wacom: Send
> > > BTN_TOUCH in response to INTUOSP2_BT eraser contact") that hasn't seen
> > > any stable activity either.
> > >
> > > Any idea what's up?
> >
> > I don't see these in my queue at all.
> >
> > What is the git commit id of these patches in Linus's tree?
> >
> > thanks,
> >
> > greg k-h
> 
> Ah, looks like the HID tree's "for-5.2/fixes" branch hasn't been
> pulled yet. That could explain things.
> 
> 69dbdfffef20c715df9f381b2cee4e9e0a4efd93 HID: wacom: Sync INTUOSP2_BT
> touch state after each frame if necessary
> 6441fc781c344df61402be1fde582c4491fa35fa HID: wacom: Correct button
> numbering 2nd-gen Intuos Pro over Bluetooth
> fe7f8d73d1af19b678171170e4e5384deb57833d HID: wacom: Send BTN_TOUCH in
> response to INTUOSP2_BT eraser contact
> e92a7be7fe5b2510fa60965eaf25f9e3dc08b8cc HID: wacom: Don't report
> anything prior to the tool entering range
> 2cc08800a6b9fcda7c7afbcf2da1a6e8808da725 HID: wacom: Don't set tool
> type until we're in range

There is nothing I can do until the patches are in Linus's tree, sorry.

greg k-h
