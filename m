From: Yan I Li <yan.i.li@intel.com>
Subject: Re: [PATCH] Input: Lenovo S10-3t's touchpad support
Date: Mon, 29 Nov 2010 16:53:11 +0800
Message-ID: <1291020791.1338.13.camel@yli107-mobl.ccr.corp.intel.com>
References: <aefc1833eeede37ae6ea4a9ddeaa602eb7d31101.1290823698.git.yan.i.li@intel.com>
	<20101127075528.GA28667@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <meego-kernel-bounces@lists.meego.com>
In-Reply-To: <20101127075528.GA28667@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.meego.com/options/meego-kernel>,
	<mailto:meego-kernel-request@lists.meego.com?subject=unsubscribe>
List-Archive: <http://lists.meego.com/pipermail/meego-kernel>
List-Post: <mailto:meego-kernel@lists.meego.com>
List-Help: <mailto:meego-kernel-request@lists.meego.com?subject=help>
List-Subscribe: <http://lists.meego.com/listinfo/meego-kernel>,
	<mailto:meego-kernel-request@lists.meego.com?subject=subscribe>
Sender: meego-kernel-bounces@lists.meego.com
Errors-To: meego-kernel-bounces@lists.meego.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Ding, Jian-feng" <jian-feng.ding@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "meego-kernel@lists.meego.com" <meego-kernel@lists.meego.com>, Christopher Heiny <christopherheiny@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, 2010-11-27 at 15:55 +0800, Dmitry Torokhov wrote:
> Hi Yan,
> 
> On Sat, Nov 27, 2010 at 11:56:59AM +0800, Yan Li wrote:
> > This is for kernel bug #18122 and MeeGo bug #4807.
> > 
> > Current code detects Clickpad by checking the 8 and 20 bits of 0x0c
> > cap. However, the code returns true if either of those bits is 1,
> > while it should only return true when both are 1. This has lead to the
> > touchpad on Lenovo S10-3t be mistakenly recognized as Clickpad and its
> > BTN_LEFT and BTN_RIGHT blocked.
> > 
> > So far we've found that the S10-3ts are shipped with two slightly
> > different models of touchpads, of which the 0x0c cap is either
> > 0x5a0400 or 0x4a0500. They are not Clickpad and return BTN_LEFT and
> > BTN_RIGHT normally.
> 
> Hmm, this is weird. According to my data:
> 
> >> Treat it as a two-bit field.
> >>   0x00 == not a clickpad
> >>   0x01 == 1 button clickpad
> >>   0x02 == 2 button clickpad
> >>   0x03 == reserved

That's interesting.

> Moreover, Takashi's HP returns 0x5a 0x04 0x00 in response to 0x0c query
> and _is_ a clickpad.

So how do we define clickpad? The touchpad used on S10-3t does have
full-surface capacity sensor that covers the lower button area, but when
you click the lower-left corner it emits BTN_LEFT, when you click the
lower-right corner it emits BTN_RIGHT, not BTN_MIDDLE. So it should be
handled as a normal touchpad, not a ClickPad.

So how about checking the first byte of excap == 0xe4? If it is true
then we still handle it as a normal touchpad.

This is the hardware data for the touchpad used on S10-3t:
Synaptics Touchpad, model: 1, fw: 7.4, id: 0x1e0b1, caps:
0xd04771/0xe40000/0x5a0400

> In C comparison operators have higher precedence than bitwise ones. Your
> expression reduces to ((ex0c) & 1) which is not correct. The proper
> expression would be:
> 

That's definitely brain dead. I'll send out a new patch.

> #define SYN_CAP_CLICKPAD(ex0c)		(((ex0c) & 0x100100) == 0x100100)
> 
> but it really contradicts the data I have...
> 
> Thanks.

--
Yan
