From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [patch] HID: picoLCD: off by one in dump_buff_as_hex()
Date: Mon, 17 Sep 2012 22:54:37 +0200
Message-ID: <20120917225437.6f2847ee@neptune.home>
References: <20120914110414.GA1152@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:60103 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab2IQUzc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 16:55:32 -0400
In-Reply-To: <20120914110414.GA1152@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

On Fri, 14 September 2012 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We're placing the NUL terminator one character beyond the end of the
> buffer here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This change obviously don't make the code worse, but I'm not positive
> it's the right fix.  I'm not sure the lines before are doing the right
> thing either, if we had two chars of remaining space then wouldn't it be
> better to put the new line and NUL in the unused space?

The output buffer full should not happen as the 256 bytes buffer can hold
more than the max expected report size of 64 bytes.

An option would be to convert to hex_dump_to_buffer(), but as this happens
partially under IRQ context - even though for debugging purposes - the
switch may be a bit too expensive, especially as one still has to append
linefeed after it.


I think I will extend your fix slightly in order to cover "too much input"
in a way visible to /sys/kernel/hid/*/events reader (for the case that
reports would grow in size).

Though no need to check for minimal output buffer size as callers are local
and feed in #defined sized buffer.


More on Wednesday evening, too late today and no time tomorrow.

Bruno

> If you decide to do it differently, then please feel to sent a patch for
> that and give me a Reported-by cookie.
> 
> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
> index eec85b5..ff271ff0 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -390,7 +390,7 @@ static void dump_buff_as_hex(char *dst, size_t dst_sz, const u8 *data,
>  		dst[j--] = '\0';
>  		dst[j] = '\n';
>  	} else
> -		dst[j] = '\0';
> +		dst[dst_sz - 1] = '\0';
>  }
>  
>  void picolcd_debug_out_report(struct picolcd_data *data,
