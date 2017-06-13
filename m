From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1] HID: core: don't use negative operands when shift
Date: Tue, 13 Jun 2017 11:59:27 +0200
Message-ID: <20170613095927.GC29589@mail.corp.redhat.com>
References: <20170613092222.4073-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbdFMJ7c (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 05:59:32 -0400
Content-Disposition: inline
In-Reply-To: <20170613092222.4073-1-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

On Jun 13 2017 or thereabouts, Andy Shevchenko wrote:
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> The recent C standard in 6.5.7 paragraph 4 defines that operands for
> bitwise shift operators should be non-negative, otherwise it's an
> undefined behaviour.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> ---
>  drivers/hid/hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 5f87dbe28336..73416fef983e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1046,7 +1046,7 @@ static s32 snto32(__u32 value, unsigned n)
>  	case 16: return ((__s16)value);
>  	case 32: return ((__s32)value);
>  	}
> -	return value & (1 << (n - 1)) ? value | (-1 << n) : value;
> +	return value & (1 << (n - 1)) ? value | (~0U << n) : value;
>  }
>  
>  s32 hid_snto32(__u32 value, unsigned n)
> -- 
> 2.11.0
> 
