From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] HID: multitouch: fix a corner case of some Win 8
 devices
Date: Fri, 23 Jun 2017 10:17:39 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706231017120.30709@cbobk.fhfr.pm>
References: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Arek Burdach <arek.burdach@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 15 Jun 2017, Benjamin Tissoires wrote:

> It looks like the Microsft certification misses one case of released fingers.
> 
> The (only) solution we can have against that is to wait for a hundred of ms,
> and if no input report comes in, consider that the touches should have been
> released. The spec, as I read it, enforces that.
> 
> Arek, can you please give a test to this new series?
> I managed to find out a way to have the IRQ and the timeout exclusive, and
> also added a few optimizations.
> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (3):
>   HID: multitouch: use BIT macro
>   HID: multitouch: fix rare Win 8 cases when the touch up event gets
>     missing
>   HID: multitouch: optimize the sticky fingers timer
> 
>  drivers/hid/hid-multitouch.c | 149 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 39 deletions(-)

I've applied the series with Arek's 'Tested-by' to for-4.13/multitouch.

-- 
Jiri Kosina
SUSE Labs
