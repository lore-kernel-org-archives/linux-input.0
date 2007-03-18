From: Adrian Bunk <bunk@stusta.de>
Subject: appletouch quirk doesn't run at resume
Date: Sun, 18 Mar 2007 01:42:40 +0100
Message-ID: <20070318004240.GO752@stusta.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703162134.14265.rjw@sisk.pl> <1174078066.13341.279.camel@localhost.localdomain> <1174087552.13341.332.camel@localhost.localdomain> <45FBBDEA.9060708@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <45FBBDEA.9060708@m3y3r.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Soeren Sonnenburg <kernel@nn7.de>, Sergey Vlasov <vsu@altlinux.ru>, Jiri Kosina <jkosina@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sat, Mar 17, 2007 at 11:07:38AM +0100, Thomas Meyer wrote:
> Thomas Gleixner schrieb:
> > I finally found a dual core box, which survives suspend/resume without
> > crashing in the middle of nowhere. Sigh, I never figured out from the
> > code and the bug reports what's going on.
> >
> > The observed hangs are caused by a stale state transition of the clock
> > event devices, which keeps the RCU synchronization away from completion,
> > when the non boot CPU is brought back up.
> >
> > The suspend/resume in oneshot mode needs the similar care as the
> > periodic mode during suspend to RAM. My assumption that the state
> > transitions during the different shutdown/bringups of s2disk would go
> > through the periodic boot phase and then switch over to highres resp.
> > nohz mode were simply wrong.
> >
> > Add the appropriate suspend / resume handling for the non periodic
> > modes.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >   
> 
> Excellent work. Now suspend to disk is working again. But:
> 
> 1.) The quirk added in commit a417a21e10831bca695b4ba9c74f4ddf5a95ac06
> for the appletouch driver doesn't seem to work after resume.
>...

Not a regression, but still a bug.
Appropriate people added to the Cc.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
