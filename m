From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3] HID: core: move Usage Page concatenation to Main item
Date: Wed, 27 Mar 2019 10:35:02 +0100
Message-ID: <1553679302.14990.0.camel@suse.com>
References: <20190326200331.25934-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326200331.25934-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Terry.Junge@plantronics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Di, 2019-03-26 at 21:03 +0100, Nicolas Saenz Julienne wrote:
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
>   * Add a usage to the temporary parser table.
>   */
>  
> -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> +static int hid_add_usage(struct hid_parser *parser, unsigned usage, __u8 size)

No need to use the __u8 style inside the kernel. u8 will do.

	Regards
		Oliver
