From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Sat, 6 Nov 2010 10:16:18 -0500
Message-ID: <AANLkTi=uyOC2vL-kUoMvNm44gdKth4mt2mtdsnJbVDYP@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45973 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab0KFPQT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 11:16:19 -0400
Received: by gyh4 with SMTP id 4so2714681gyh.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 08:16:18 -0700 (PDT)
In-Reply-To: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Fri, Nov 5, 2010 at 1:47 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Recent changes and discussion about MT support at LKML, UDS, and
> xorg-devel encouraged me to migrate Wacom MT devices to the slot-base=
d
> MT protocol (introduced in kernel 2.6.36). Since Wacom supports both
> digitizer and touch devices, I need to decide how to report touch dat=
a
> when the pen is in proximity.
>
> My goal is to understand how X server would like the MT data to be
> reported from the kernel. I hope to keep kernel and X server driver M=
T
> support in sync so we can avoid unnecessary confusion or extra work i=
n
> the userland.
>
> The existing solution for single touch events is to arbitrate touch
> when pen is in prox. This is based on the assumption that we do not
> want to have two cursors competing on the screen.
>
> With the introduction of MT, the touch data are most likely translate=
d
> into something other than pointer events. So, reporting both pen and
> touch data makes sense now. However, I want to assure a smooth
> tansition from single touch to MT for end users so they still get the
> single touch behavior as they used to be. I gathered the following
> approaches:
>
> 1. =A0 =A0 Arbitrate all touch data in the kernel.
>
> This is the simplest solution for device driver developers. But I do
> not feel it is end user and userland client friendly.
>
> 2. =A0 =A0 Report first finger touch as ABS_X/Y events when pen is no=
t in
> prox. =A0Arbitrating single touch data when pen is in prox. Pen data =
is
> reported as ABS_X/Y events. Both ABS_X/Y for pen or the first finger
> and ABS_MT_* for MT data are reported.
>
> This approach reduces the overhead in dealing with two cursors in use=
rland.
>
> 3. =A0 =A0Report first finger touch as ABS_X/Y events when pen is not=
 in prox;
> =A0 =A0 =A0 Report pen data as ABS_X/Y events when there is no finger=
 touch;
> =A0 =A0 =A0 Report touch data as MT_TOOL_TOUCH and pen data as MT_TOO=
L_PEN
> events when both pen and touch data are received. No ABS_X/Y are
> reported when pen and tocuh or multi-touch data are received.
>
> I feel this one makes sense to userland since pen can be considered a=
s
> another touch.
>
> 4. =A0 =A0Report first finger touch as ABS_X/Y events when pen is not=
 in prox;
> =A0 =A0 =A0 Report pen data as ABS_X/Y events when there is no finger=
 touch;
> =A0 =A0 =A0 Report touch data as MT_TOOL_TOUCH and pen data as MT_TOO=
L_PEN
> events when both pen and touch data are received. ABS_X/Y are also
> reported for pen when both pen and tocuh data are received.
>
> This one makes sense to userland too. It eases the backward
> compatibility support for those clients that don't support MT at all.
>
> Which approach do you like? Or do you have other suggestions share?
>
> Ping

Here is my input on topic.  I'll summarize that I'm leaning towards
your option #1 right now.

=46irst, I think we need to decide if non-MT aware apps/X drivers are t=
o
be supported or if we require them to be "fixed" to work reliably with
devices such as Wacom Bamboo that split device into two inputs yet
need coordination across inputs.

I prefer that non-MT aware are supported and so we should continue the
current arbitration in kernel over the ST events.  Sending
un-arbitrated MT events to userland I think is mostly OK.

Next, you bring up an interesting point on tablet side.  Currently, it
doesn't send MT events because it only tracks 1 stylus tool at a time.
 Should it send MT events anyways for single tool to help userland
because its events are meant to be associated with another inputs MT
events?  Thats a good question for MT people to consider.

Thinking about that issue though makes we think of option #5 to
consider.  We could combine these 2 input devices into single input
device and send all events as MT events.  I assume userland has easier
time arbitrating within single input device.  I'm not sure what it
would take to combine these in kernel though... and there is some
value in 2 inputs since  just the touchpad can currently be re-routed
to xf86-input-synaptics.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
