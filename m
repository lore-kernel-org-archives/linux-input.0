From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Power button policy and mechanism
Date: Sat, 20 Oct 2007 14:42:25 -0700
Message-ID: <20071020144225.ac0f1e0c.Kristoffer.Ericson@Gmail.com>
References: <20071016134050.f7106efe.Kristoffer.Ericson@Gmail.com>
	<d120d5000710160734occe82cke989baf3d1f97130@mail.gmail.com>
	<1192787667.5714.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1192787667.5714.22.camel@localhost.localdomain>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-main <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 19 Oct 2007 10:54:27 +0100
Richard Purdie <rpurdie@rpsys.net> wrote:

> On Tue, 2007-10-16 at 10:34 -0400, Dmitry Torokhov wrote:
> > On 10/16/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > > This is mainly an embedded issue, but I feel it's quite important. 
> > > It should apply to other devices also like for example Zaurus
> > > branches (those with keyboard and designated power button).
> 
> There was a long discussion thread about this a while back. There were a
> lot of differing views but in the end no patch to fix up power.c to do
> anything was accepted. The Zaurus was the reason I raised the issue.
> 
> It seems power.c was recently removed as it was dead code.
> 
> > > So in short:
> > > 1. Does mainline policy allow static power button events inside kernel (power button == suspend/resume)?
> > >        Why/Why Not?
> > 
> > Could it be that you may want to prevent suspend from happening? Or
> > delay it until system completes some important operation? Do something
> > else, like cleanly disconnect your network connections? With actual
> > handling done in userspace it's all possible. With suspend done
> > directly in kernel it is much harder and couples input subsystem with
> > power management too tightly.
> > 
> > However if you are dead-set on doin it in kernel you coudl register an
> > input_handler in your platform PM code and it will attach to your
> > keyboard. Look for power.c module in older kernels for example.
> 
> The proposed changes to power.c were to hook it into things like APM as
> a "user" event so the power button triggered a suspend event but
> anything in userspace needing to know about (or veto) it could do so.
> 
> > > 2. Seeing as my knowledge about this area isn't the best I would 
> > > appreciate all opinions on the subject from the gurus.
> > 
> > Richard Purdie I think might have some pointers.
> 
> Currently I still patch this functionality into the Zaurus kernels
> (basically by resurrecting power.c with the patches I used to apply to
> it added in):
> 
Aha, good for reference code.

> http://www.rpsys.net/openzaurus/patches/input_power-r9.patch
> 
> This works for 2.6.23 but doesn't seem to work in 2.6.23-git9. I've not
> looked into why yet.
> 
> In the current climate, this will never make mainline kernels so I will
> be considering other options such as adding support into something like
> OHM. As yet, I've not found the time to do that and since the above
> patch works and is relatively easy to maintain...
I don't know exactly what OHM is but anything that would get this functionality (which is vital for handhelds)
would be great.

Big thanks for reply
> 
> Cheers,
> 
> Richard
> 
> 


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
