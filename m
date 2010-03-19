From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: input: mt: Software finger tracking in the kernel?
Date: Fri, 19 Mar 2010 17:08:28 +0530
Message-ID: <5d5443651003190438s17330100vc1d91c9089f7e7f2@mail.gmail.com>
References: <4BA358DB.20708@enmesh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BA358DB.20708@enmesh.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@enmesh.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Henrik,

On Fri, Mar 19, 2010 at 4:28 PM, Henrik Rydberg <rydberg@enmesh.se> wrote:
> Hi Dmitry,
>
> there is an ongoing discussion about adding multitouch to X
> (http://lists.x.org/archives/xorg-devel/2010-March/006206.html), which is
> beginning to take on more solid form.
>
> One of the suggestions emerging from that discussion is to add the software
> finger tracking to the kernel. Back in summer 2009 when I thought about this, I
> disregarded it as being too experimental. I have since then reconsidered,
> starting to think it really is the right place.
>
> The MT protocol allows applications to take advantage of multi-contact hardware,
> but leaves the problems of finger tracking and filtering to the user. Arguably,
> no application can make good use of MT without these, so the problem is pushed
> forward, in this case to evdev or equivalent.
>
> The knowledge of signal-to-noise ratios and prior input states resides in the
> kernel. Because of this, the finger matching and filtering would naturally
> reside within the kernel.
>
> So, if there were to appear patches to include matching in the input core, would
> you consider them? :-)

Please post your patches for the further discussion. Last time I
referred the Android userspace code it was also not using TRACKING_ID
as defined in MT protocol even if the kernel driver emits them.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
