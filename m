From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [patch] add printk_ratelimit to atkbd_interrupt
Date: Wed, 20 Jun 2007 23:07:17 -0400
Message-ID: <200706202307.18565.dtor@insightbb.com>
References: <20070620011753.GA16692@virgo.fc-cn.com> <200706200013.13029.dtor@insightbb.com> <4678D882.3090606@mail.fc-cn.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <4678D882.3090606@mail.fc-cn.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Qi Yong <qiyong@mail.fc-cn.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, michal.k.k.piotrowski@gmail.com
List-Id: linux-input@vger.kernel.org

On Wednesday 20 June 2007 03:34, Qi Yong wrote:
> Dmitry Torokhov wrote:
> > On Tuesday 19 June 2007 21:17, Qi Yong wrote:
> >   
> >> Add printk_ratelimit() to atkbd_interrupt(). I get "Spurious ACK" messages flushing on my
> >> screen. This patch helps to read the screen.
> >>
> >>     
> >
> > Will apply, thank you.
> >
> > Do you have any idea why you are getting spurios ACK messages? Do you have
> > an application fiddling with keyboard port or do you have blink driver
> > enabled?
> 
> No idea. It is at boot time.
> Yes, i have CONFIG_BLINK=y.

Disable it.

-- 
Dmitry
