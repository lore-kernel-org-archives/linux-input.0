From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 5/6 v2] HID: magicmouse: enable Magic Trackpad support
Date: Tue, 31 Aug 2010 20:08:15 -0400
Message-ID: <1283299695.13785.16.camel@graviton>
References: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>
	 <1283280068-12285-5-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283280068-12285-5-git-send-email-chase.douglas@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2010-08-31 at 14:41 -0400, Chase Douglas wrote:
> The trackpad speaks a similar, but different, protocol from the magic
> mouse. However, only small code tweaks here and there are needed to make
> basic multitouch work.
> 
> Extra logic is required for single-touch emulation of the touchpad. The
> changes made here take the approach that only one finger may emulate the
> single pointer when multiple fingers have touched the screen. Once that
> finger is raised, all touches must be raised before any further single
> touch events can be sent.
> 
> Sometimes the magic trackpad sends two distinct touch reports as one big
> report. Simply splitting the packet in two and resending them through
> magicmouse_raw_event ensures they are handled properly.
> 
> I also added myself to the copyright statement.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
>  drivers/hid/hid-core.c       |    1 +
>  drivers/hid/hid-ids.h        |    1 +
>  drivers/hid/hid-magicmouse.c |  229 ++++++++++++++++++++++++++++++++----------
>  3 files changed, 176 insertions(+), 55 deletions(-)

Acked-by: Michael Poole <mdpoole@troilus.org>

One behavior that slightly surprised me -- which I believe is a quirk
due to userspace not expecting touchpads to have button switches -- is
that touches on the trackpad that do not close the switch can still be
interpreted by X as clicks.

Once the discussions about if/how to tweak this code settle down, I'll
put together a patch to change the "down" and "last_up" logic as I
suggested earlier.

Michael Poole
