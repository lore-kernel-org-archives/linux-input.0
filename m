From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add model data for Dell Precision 3510 trackpad.
Date: Sun, 19 Feb 2017 14:35:21 +0100
Message-ID: <20170219133521.GA22927@pali>
References: <20170219131634.GA7453@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170219131634.GA7453@riseup.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "John L. Preston" <wcerfgba@riseup.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sunday 19 February 2017 13:16:34 John L. Preston wrote:
> ---
>  drivers/input/mouse/alps.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 328edc8c8786..c0a4edefe54d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -139,6 +139,7 @@ static const struct alps_model_info alps_model_data[] = {
>  	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tecra A11-11L */
>  	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
> +	{ { 0x73, 0x03, 0x28 }, 0x13, { ALPS_PROTO_V8, 0x18, 0x18, 0 } },			/* Dell Precision 3510 */
>  };
>  
>  static const struct alps_protocol_info alps_v3_protocol_data = {

Hi John! This is not a correct place do add new proto data. I already
proposed reducing this table to just for PROTO_V2, but Dmitry was not
happy about it.

Anyway, look at function alps_identify() where is detection for ALPS_V8:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/input/mouse/alps.c?h=v4.10-rc8#n2829

V8 is already detected when e7 is (0x73, 0x03, 0x28) and ec[1] is 0x01.
What are your ec data? Probably ec[1] is not 0x01 as otherwise it should
be already detected.

Btw, from where you got your proto data in this patch?

-- 
Pali Rohár
pali.rohar@gmail.com
