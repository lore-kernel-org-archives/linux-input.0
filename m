From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hidraw: enforce minors_lock locking via lockdep
Date: Mon, 12 Nov 2018 12:45:53 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811121244070.27368@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1811082237460.21975@cbobk.fhfr.pm> <CAO-hwJJehHLJfgrQvbrW0_bOTTeH-v1qhZK0p0WZCuVDR1wsKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJehHLJfgrQvbrW0_bOTTeH-v1qhZK0p0WZCuVDR1wsKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 9 Nov 2018, Benjamin Tissoires wrote:

> On Thu, Nov 8, 2018 at 10:38 PM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > From: Jiri Kosina <jkosina@suse.cz>
> >
> > lockdep is much more powerful enforcing the locking rules than code comments,
> > so let's switch to it.
> >
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > ---
> 
> Looks good to me.
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I actually missed the comment removal for hidraw_get_report(). I've 
ammeded the patch and comitted, keeping your tag, please shout if you 
disagree :)

Thanks.

-- 
Jiri Kosina
SUSE Labs
