From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Thu, 13 May 2010 09:01:18 -0700
Message-ID: <20100513160117.GB22238@core.coreip.homeip.net>
References: <20100513075728.GF30110@core.coreip.homeip.net>
 <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
List-Id: linux-input@vger.kernel.org

On Thu, May 13, 2010 at 07:35:02AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 13 May 2010, Dmitry Torokhov wrote:
> > 
> > Bastien Nocera (1):
> >       Input: i8042 - do not try to probe ports on Intel Apple Macs
> 
> I pulled, but I skipped the last commit, because I think this one is 
> fundamentally _wrong_.
> 
> It is _not_ maintainable to create random tables of exceptions ("DMI 
> tables"), and it's actively _wrong_ to do for something like this where we 
> not only have historically worked perfectly well, and this apparently 
> tries to hide some other bug (the commit says "could potentially lock 
> up/hang/wait for timeout for long periods of time").
> 
> We should fix the problems instead of hiding them for specific machines. 
> Does anybody really think that Apple machines are the only ones with no 
> legacy keyboard? Hello? Does anybody seriously think that it's ok to add 
> entries to DMI tables for random new machines coming out?
> 
> So I think that commit was (a) totally inappropriate to send at this point 
> in the late -rc series _anyway_ (it sure as hell isn't a refression fix), 
> and that makes me wonder about the other ones.

I will freely admit that none of the fixes would qualify as strictly regression
fixes. The cacheline issue on ad7877 was there in the very first version
of the driver being committed, iforce got 1 new product ID and a fix to another
product ID which was there for ages, psmouse changes tries to work
around issue on a laptop that is not out yet as far as I know... All of
these however are very small, with low risk of disturbing anyone, and
making users life better. That is why I thought that rather than having
them wait for another 3 months we sould get the fixes out earlier.

> But (b) I don't think I 
> want to ever see anything like that during a merge window either, because 
> it's quite seriously the wrong thing to do.
>

Sometimes we do need to resort to DMI quirks because we do not have
anything else to go on and i8042 is littered with such cases. Half of
the boxes claim to support active multiplexing but don't. HOwever when
it works it is a useful thing (on laptop both touchpad and external mice
can work independently with their full protocols instead of degrading
both to Intellimouse, like Dells do). Some BIOSes hang if you use AUX LOOP.
And so on.

Apple does proper thing in BIOS and omits keyboard and mouse PNP
devices, but because of other players we do not really trust PNP BIOS
and resort to banding on ports directly - there are cases when box has
mouse and/or keyboard but they are not present in BIOS. Damed if you do,
damned if you don't...


> What are the _actual_ problems on legacy-free machines? And keep in mind 
> that I ask that exactly because I actually _have_ two Apple Mac Mini's in 
> my household, and have never seen any problems with keyboard/mouse 
> handling. 
> 
> So if somebody saw "could potentially lock up/hang/wait" issues, then 
> dangit, say what those issues are, AND LET'S FIX THEM! And not like this, 
> trying to hide them for some particular machines, rather than fixing the 
> actual underlying detection bug.
> 
> 			Linus

-- 
Dmitry
