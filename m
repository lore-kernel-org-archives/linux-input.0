From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: uhid: Fixes a bug with userspace bluetooth stacks,
 which causes hangs during certain operations
Date: Wed, 1 Jun 2016 16:26:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606011626060.11844@cbobk.fhfr.pm>
References: <1463602269-19844-1-git-send-email-roderick.colenbrander@sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463602269-19844-1-git-send-email-roderick.colenbrander@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: dh.herrmann@googlemail.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 May 2016, Roderick Colenbrander wrote:

> Many devices use userspace bluetooth stacks like BlueZ or Bluedroid in combination
> with uhid. If any of these stacks is used with a HID device for which the driver
> performs a HID request as part .probe (or technically another HID operation),
> this results in a deadlock situation. The deadlock results in a 5 second timeout
> for I/O operations in HID drivers, so isn't fatal, but none of the I/O operations
> have a chance of succeeding.
> 
> The root cause for the problem is that uhid only allows for one request to be
> processed at a time per uhid instance and locks out other operations. This means
> that if a user space is creating a new HID device through 'UHID_CREATE', which
> ultimately triggers '.probe' through the HID layer. Then any HID request e.g. a
> read for calibration data would trigger a HID operation on uhid again, but it
> won't go out to userspace, because it is still stuck in UHID_CREATE.
> In addition bluetooth stacks are typically single threaded, so they wouldn't be
> able to handle any requests while waiting on uhid.
> 
> Lucikly the UHID spec is somewhat flexible and allows for fixing the issue,
> without breaking user space. The idea which the patch implements as discussed
> with David Herrmann is to decouple adding of a hid device (which triggers .probe)
> from UHID_CREATE. The work will kick off roughly once UHID_CREATE completed (or
> else will wait a tiny bit of time in .probe for a lock). A HID driver has to call
> HID to call 'hid_hw_start()' as part of .probe once it is ready for I/O, which
> triggers UHID_START to user space. Any HID operations should function now within
> .probe and won't deadlock because userspace is stuck on UHID_CREATE.
> 
> We verified this patch on Bluedroid with Android 6.0 and on desktop Linux with
> BlueZ stacks. Prior to the patch they had the deadlock issue.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Thanks for the fix. I've applied it to 
hid.git#for-4.8/uhid-offload-hid-device-add

-- 
Jiri Kosina
SUSE Labs
