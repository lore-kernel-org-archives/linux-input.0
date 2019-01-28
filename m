From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH][RESEND] HID: elan: Make array buf static, shrinks object
 size
Date: Mon, 28 Jan 2019 21:49:55 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1901282149380.6626@cbobk.fhfr.pm>
References: <20190125160546.8732-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125160546.8732-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 25 Jan 2019, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array buf on the stack but instead make it
> static. Makes the object code smaller by 43 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    7769	   1520	      0	   9289	   2449	drivers/hid/hid-elan.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    7662	   1584	      0	   9246	   241e	drivers/hid/hid-elan.o
> 
> (gcc version 8.2.0 x86_64)

Applied to for-5.1/hid-elan.

-- 
Jiri Kosina
SUSE Labs
