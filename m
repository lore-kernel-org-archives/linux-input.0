From: Andy Walls <awalls@radix.net>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was:
 Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Tue, 08 Dec 2009 07:46:52 -0500
Message-ID: <1260276412.3094.17.camel@palomino.walls.org>
References: <BDRae8rZjFB@christoph>
	 <1259024037.3871.36.camel@palomino.walls.org>
	 <m3k4xe7dtz.fsf@intrepid.localdomain>  <4B0E8B32.3020509@redhat.com>
	 <1259264614.1781.47.camel@localhost>
	 <6B4C84CD-F146-4B8B-A8BB-9963E0BA4C47@wilsonet.com>
	 <1260240142.3086.14.camel@palomino.walls.org> <4B1E394A.1090807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754651AbZLHMs6@vger.kernel.org>
In-Reply-To: <4B1E394A.1090807@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Jarod Wilson <jarod@wilsonet.com>, Krzysztof Halasa <khc@pm.waw.pl>, Christoph Bartelmus <lirc@bartelmus.de>, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

On Tue, 2009-12-08 at 09:32 -0200, Mauro Carvalho Chehab wrote:
> Andy Walls wrote:
> > On Mon, 2009-12-07 at 13:19 -0500, Jarod Wilson wrote:

> > So I'll whip up an RC-6 Mode 6A decoder for cx23885-input.c before the
> > end of the month.
> 
> Good! Please, try to design the decoder as an independent module that gets
> data from a kfifo and generate scancodes for the input API.

Hmmm.  Let me see how the protoype turns out keeping that design
objective in mind.  I've already got the current RC-5 and NEC decoding
state machines in cx23885-input a bit layered, but they are taking
advantage of specific events signaled by my v4l2_subdev implementation.

Strictly speaking the state machines don't have to.  All of the remote
protocols I have played with make framing pretty easy.



> > I can setup the CX2388[58] hardware to look for both RC-5 and RC-6 with
> > a common set of parameters, so I may be able to set up the decoders to
> > handle decoding from two different remote types at once.  The HVR boards
> > can ship with either type of remote AFAIK.
> > 
> > I wonder if I can flip the keytables on the fly or if I have to create
> > two different input devices?
> 
> IMO, the better is, by default, to open just one input device per IR receiver.
> >From what I understand from our discussions, if the user wants to filter IR
> commands into several input interfaces, some userspace interface will be 
> provided to allow the creation of other input interfaces for that purpose.

Hmm. That's not what I just thought I read from Dmitry....

Oh well.  If I don'y get it done by 24 Dec, it'll be in the new year.


Regards,
Andy
