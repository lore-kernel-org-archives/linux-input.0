From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid-led.c: remove unneccessary underscores
Date: Fri, 7 Oct 2016 18:25:56 +0200
Message-ID: <20161007162556.GH30411@mail.corp.redhat.com>
References: <20161003081626.GA18553@amd>
 <20161003094503.GC9131@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161003094503.GC9131@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: j.anaszewski@samsung.com, linux-leds@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, jikos@kernel.org, linux-input@vger.kernel.org, trivial@kernel.org
List-Id: linux-input@vger.kernel.org

On Oct 03 2016 or thereabouts, Pavel Machek wrote:
> On Mon 2016-10-03 10:16:26, Pavel Machek wrote:
> > 
> > u8 (and friends) can be used directly in kernel sources (not kernel
> > headers).
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Zero day bot warned me that this is not quiet correct.
> 
> This would be needed on top. Is there interest in fixed patch?

Having both __ and not __ in the same driver would be a little bit
weird. So I'd say we just continue with the existing code. Thanks for
the submission BTW!

Cheers,
Benjamin

> 
> diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
> index cd208ca..be659ca 100644
> --- a/drivers/hid/hid-led.c
> +++ b/drivers/hid/hid-led.c
> @@ -57,8 +57,8 @@ union delcom_packet {
>  		u8 cmd;
>  	} rx;
>  	struct {
> -		le16 family_code;
> -		le16 security_code;
> +		__le16 family_code;
> +		__le16 security_code;
>  		u8 fw_version;
>  	} fw;
>  };
> 
> 
