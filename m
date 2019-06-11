From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] HID: wacom: Don't report anything prior to the tool
 entering range
Date: Tue, 11 Jun 2019 21:22:48 +0200
Message-ID: <20190611192248.GB19775@kroah.com>
References: <CANRwn3Ru+7FGtsY=GaDa7pAJkuagdb6nFtvrFq1qhTWJR0rF9A@mail.gmail.com>
 <20190426163531.9782-1-jason.gerecke@wacom.com>
 <CANRwn3RBK41mRJKUPDDptoq_So6_7UxR0toaauZvjT5U=OaHWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANRwn3RBK41mRJKUPDDptoq_So6_7UxR0toaauZvjT5U=OaHWw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: "# v3.17+" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 11, 2019 at 12:02:47PM -0700, Jason Gerecke wrote:
> I haven't been keeping a close eye on this and just noticed that this
> patch set doesn't seem to have been merged into stable. There's also a
> second patch series (beginning with "[PATCH 1/3] HID: wacom: Send
> BTN_TOUCH in response to INTUOSP2_BT eraser contact") that hasn't seen
> any stable activity either.
> 
> Any idea what's up?

I don't see these in my queue at all.

What is the git commit id of these patches in Linus's tree?

thanks,

greg k-h
