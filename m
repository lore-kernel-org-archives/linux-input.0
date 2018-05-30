From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for v4.17-rc7
Date: Wed, 30 May 2018 11:24:58 -0700
Message-ID: <20180530182458.GA203327@dtor-ws>
References: <20180529233834.GA50727@dtor-ws>
 <CA+55aFzc_gZ15Qg3BAoSgALbgTepnQmAnzNb+1w9U8OUxjjVvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzc_gZ15Qg3BAoSgALbgTepnQmAnzNb+1w9U8OUxjjVvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 29, 2018 at 10:21:53PM -0500, Linus Torvalds wrote:
> On Tue, May 29, 2018 at 6:38 PM Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
> 
> >     We are switching a bunch of
> > Lenovo devices with Synaptics touchpads from PS/2 emulation over to
> > native RMI/SMbus.
> 
> > Given that all commits are marked for stable there is no point delaying
> > them till next release.
> 
> Hmm. The elan driver stack overrun isn't mentioned, but seems more
> fundamental fix than the other changes that just add a few new PnP ID's...

I do not think that the Elan problem is actually observable on any
hardware with 4.17 at the moment, as it only shows up when switching
some Elan devices from PS/2 to SMBus and the patches that do that are
slated for the next merge window. I included it in the pull as a
precaution. Switching Synaptics to RMI is much more user-visible...

Still should have mentioned Elan corruption fix though.

Thanks.

-- 
Dmitry
