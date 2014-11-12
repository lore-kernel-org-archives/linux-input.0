From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v2] hid: sony: Use kernel allocated buffers for HID
 reports
Date: Wed, 12 Nov 2014 17:06:39 +0100
Message-ID: <20141112170639.28ddc4301f655d845a8390e3@ao2.it>
References: <1415805534-8401-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:23444 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbaKLQHC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 11:07:02 -0500
In-Reply-To: <1415805534-8401-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

On Wed, 12 Nov 2014 10:18:54 -0500
Frank Praznik <frank.praznik@oh.rr.com> wrote:

> Replace stack buffers with kernel allocated buffers for sending
> and receiving HID reports to prevent issues with DMA transfers
> on certain hardware.
> 
> Output report buffers are allocated at initialization time to avoid
> excessive calls to kmalloc and kfree.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
> 
>  v2 fixes a sizeof(pointer) mistake and corrects some cosmetic issues
>  (spacing and #defines instead of magic constants).
> 
>  The original reporter confirms that this fixes the bug reported in
>  https://bugzilla.kernel.org/show_bug.cgi?id=87991
> 
>  drivers/hid/hid-sony.c | 147 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 113 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index bc4269e..048aa6b 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -798,6 +798,12 @@ union sixaxis_output_report_01 {
>  	__u8 buf[36];
>  };
>  
> +#define DS4_REPORT_2_SIZE 37
> +#define DS4_REPORT_5_SIZE 32
> +#define DS4_REPORT_17_SIZE 78
> +#define DS4_REPORT_129_SIZE 7
> +#define SIXAXIS_REPORT_242_SIZE 18
> +

Hi Frank,

just nitpicking, what about using hex numbers in the report names?
i.e.

#define DS4_REPORT_0x02_SIZE 37
#define DS4_REPORT_0x05_SIZE 32
#define DS4_REPORT_0x11_SIZE 78
#define DS4_REPORT_0x81_SIZE 7
#define SIXAXIS_REPORT_0xF2_SIZE 18

either with or without the 0x prefix is fine by me.

That'll be a little easier on the eyes in code like the one below.

[...]
> +		ret = hid_hw_raw_request(sc->hdev, 0x81, buf,
> +				DS4_REPORT_129_SIZE, HID_FEATURE_REPORT,
> +				HID_REQ_GET_REPORT);
[...]

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
