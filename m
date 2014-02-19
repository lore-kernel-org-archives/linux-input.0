From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] HID: sony: Fix work queue issues.
Date: Wed, 19 Feb 2014 10:27:05 -0800
Message-ID: <20140219182705.GA6009@kroah.com>
References: <1392833362-4218-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392833362-4218-1-git-send-email-frank.praznik@oh.rr.com>
Sender: stable-owner@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, dh.herrmann@gmail.com, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

On Wed, Feb 19, 2014 at 01:09:22PM -0500, Frank Praznik wrote:
> Don't initialize force-feedback for devices that don't support it to avoid calls
> to schedule_work() with an uninitialized work_struct.
> 
> Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
> is used for the LEDs even when force-feedback is disabled.
> 
> Remove sony_destroy_ff() to avoid a compiler warning since it is no longer used.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
> 
>  This is a bugfix for 3.14.
> 
>  drivers/hid/hid-sony.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
