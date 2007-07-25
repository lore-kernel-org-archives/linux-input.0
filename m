From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH]: Add command-line option to i8042 to completely disable
 it
Date: Wed, 25 Jul 2007 00:05:04 -0700
Message-ID: <20070725000504.f8ce49c1.akpm@linux-foundation.org>
References: <46A4DFD2.2010501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46A4DFD2.2010501@redhat.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Chris Lalancette <clalance@redhat.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 23 Jul 2007 13:05:22 -0400 Chris Lalancette <clalance@redhat.com> wrote:

> (I tried to send this patch to linux-input@, but it seems to be currently having
> some problems, so I'm going directly to LKML).
> 
> Certain (broken) pieces of South Bridge hardware will respond to
> i8042_read_status() on boot with 0x0, despite there not being a real i8042
> controller hooked up in the south bridge.  This can cause the detection for the
> i8042 to return a "phantom" device, which hangs up later initialization.  Note
> that using "i8042.nokbd" and/or "i8042.noaux" do not help with this, since this
> shows up during i8042_controller_check() (before either of those options are
> checked).  This patch adds a command-line option "i8042.disable", which just
> completely disables any checking for the i8042 controller.

That's an unfortunate fix.  Is there really no way in which we
can auto-detect such a situation without requiring a manual
setting?
