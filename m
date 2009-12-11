From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Fri, 11 Dec 2009 12:46:42 +0000
Message-ID: <20091211124642.GA28609@srcf.ucam.org>
References: <20091209203939.GC10138@core.coreip.homeip.net> <1260487533-4960-1-git-send-email-mjg@redhat.com> <20091211075910.GC30274@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091211075910.GC30274@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 10, 2009 at 11:59:10PM -0800, Dmitry Torokhov wrote:

> Locking is screwed (sorry, did not notice it forst time around). In fact
> it was screwed in i8042 itself as well. What do you think about the
> following 2 patchs (one prepares i8042 and the other is your vesion,
> adapted).

Looks good to me. Thanks!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
