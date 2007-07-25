From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH]: Add command-line option to i8042 to completely disable it
Date: Wed, 25 Jul 2007 10:03:55 +0200
Message-ID: <20070725080355.GA14726@suse.cz>
References: <46A4DFD2.2010501@redhat.com> <20070725000504.f8ce49c1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070725000504.f8ce49c1.akpm@linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Lalancette <clalance@redhat.com>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, Jul 25, 2007 at 12:05:04AM -0700, Andrew Morton wrote:
> On Mon, 23 Jul 2007 13:05:22 -0400 Chris Lalancette <clalance@redhat.com> wrote:
> 
> > (I tried to send this patch to linux-input@, but it seems to be currently having
> > some problems, so I'm going directly to LKML).
> > 
> > Certain (broken) pieces of South Bridge hardware will respond to
> > i8042_read_status() on boot with 0x0, despite there not being a real i8042
> > controller hooked up in the south bridge.  This can cause the detection for the
> > i8042 to return a "phantom" device, which hangs up later initialization.  Note
> > that using "i8042.nokbd" and/or "i8042.noaux" do not help with this, since this
> > shows up during i8042_controller_check() (before either of those options are
> > checked).  This patch adds a command-line option "i8042.disable", which just
> > completely disables any checking for the i8042 controller.
> 
> That's an unfortunate fix.  Is there really no way in which we
> can auto-detect such a situation without requiring a manual
> setting?

The fact that the current detection hangs suggests that the scenario is
possible to detect.

-- 
Vojtech Pavlik
Director SuSE Labs
