From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Thu, 3 Oct 2019 10:45:30 -0700
Message-ID: <20191003174530.GB22365@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190930230652.GW237523@dtor-ws>
 <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 03, 2019 at 06:44:04AM +0000, Dexuan Cui wrote:
> > From: Dexuan Cui
> > Sent: Wednesday, October 2, 2019 10:35 PM
> > > ... 
> > >
> > > ¯\_(ツ)_/¯ If you do not want to implement hibernation properly in vmbus
> > > code that is totally up to you (have you read in pm.h how freeze() is
> > > different from suspend()?).
> > > Dmitry
> > 
> > I understand freeze() is different from suspend(). Here I treat suspend() as a
> > heavyweight freeze() for simplicity and IMHO the extra cost of time is
> > neglectable considering the long hibernation process, which can take
> > 5~10+ seconds.
> > 
> > Even if I implement all the pm ops, IMO the issue we're talking about
> > (i.e. the hibernation process can be aborted by user's keyboard/mouse
> > activities) still exists. Actually I think a physical Linux machine should have
> > the same issue.
> > 
> > In practice, IMO the issue is not a big concern, as the VM usually runs in
> > a remote data center, and the user has no access to the VM's
> > keyboard/mouse. :-)
> > 
> > I hope I understood your comments. I'll post a v2 without the notifier.
> > Please Ack the v2 if it looks good to you.
> > 
> > -- Dexuan
> 
> I think I understood now: it looks the vmbus driver should implement
> a prepare() or freeze(), which calls the hyperv_keyboard driver's
> prepare() or freeze(), which can set the flag or disable the keyboard
> event handling. This way we don't need the notifier.

Right. I think in practice the current suspend implementation can work
as freeze() for the HV keyboard, because in suspend you shut off vmbus
channel, so there should not be wakeup signals anymore. What you do not
want is to have the current resume to be used in place of thaw(), as
there you re-enable the vmbus channel and resume sending wakeup requests
as you are writing out the hibernation image to storage.

I think if vmbus allowed HV keyboard driver to supply empty thaw() and
poweroff() implementations, while using suspend() as freeze() and
resume() as restore(), it would solve the issue for you.

Thanks.

-- 
Dmitry
