From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH RESEND] HID: fix error message in hid_open_report()
Date: Tue, 20 Aug 2019 16:55:53 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908201655030.27147@cbobk.fhfr.pm>
References: <1230b0c19fd21fdc4d0eb30f3e32e67fff86fef9.1563818405.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1230b0c19fd21fdc4d0eb30f3e32e67fff86fef9.1563818405.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 22 Jul 2019, Michał Mirosław wrote:

> On HID report descriptor parsing error the code displays bogus
> pointer instead of error offset (subtracts start=NULL from end).
> Make the message more useful by displaying correct error offset
> and include total buffer size for reference.
> 
> This was carried over from ancient times - "Fixed" commit just
> promoted the message from DEBUG to ERROR.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
[ ... snip ... ]
> @@ -1230,7 +1232,8 @@ int hid_open_report(struct hid_device *device)
>  		}
>  	}
>  
> -	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
> +	hid_err(device, "item fetching failed at offset %zu/%zu\n",
> +		size - (end - start), size);

Hi Michal,

thanks for the fix.

This causes:

drivers/hid/hid-core.c: In function ‘hid_open_report’:
drivers/hid/hid-core.c:1235:2: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 4 has type ‘unsigned int’ [-Wformat=]
  hid_err(device, "item fetching failed at offset %zu/%zu\n",
  ^

could you please fix that up and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs
