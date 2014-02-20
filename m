From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: sony: Fix work queue issues.
Date: Thu, 20 Feb 2014 14:15:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402201415350.1192@pobox.suse.cz>
References: <1392833362-4218-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1392833362-4218-1-git-send-email-frank.praznik@oh.rr.com>
Sender: stable-owner@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, dh.herrmann@gmail.com
List-Id: linux-input@vger.kernel.org

On Wed, 19 Feb 2014, Frank Praznik wrote:

> Don't initialize force-feedback for devices that don't support it to avoid calls
> to schedule_work() with an uninitialized work_struct.
> 
> Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
> is used for the LEDs even when force-feedback is disabled.
> 
> Remove sony_destroy_ff() to avoid a compiler warning since it is no longer used.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Queued for 3.14 (without the -stable annotation), thanks.

-- 
Jiri Kosina
SUSE Labs
