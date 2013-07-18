From: rydberg@euromail.se
Subject: Re: [PATCH] HID: multitouch: do not init reports for multitouch
 devices
Date: Thu, 18 Jul 2013 21:24:16 +0200
Message-ID: <20130718192416.GA526@polaris.bitmath.org>
References: <1373620101-16113-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373620101-16113-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> Some multitouch screens do not like to be polled for input reports.
> However, the Win8 spec says that all touches should be sent during
> each report, making the initialization of reports unnecessary.
> The Win7 spec is less precise, but we can safely assume that when
> the module is loaded (at boot), no one is touching the screen.
> 
> Add the quirk HID_QUIRK_NO_INIT_REPORTS so that we do not have to
> introduce a quirk for each problematic device.

I assume you have tested thoroughly for regressions? How about odd
eGalax devices, for instance? Changes affecting existing hardware
makes me nervous. Is it so bad to add this quirk on a per-device
basis? Or perhaps turned on by default for win8 devices only?

> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-multitouch.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index d99b959..197c2e6 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -957,6 +957,15 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
>  
>  	/*
> +	 * Some multitouch screens do not like to be polled for input reports.
> +	 * However, the Win8 spec says that all touches should be sent during
> +	 * each report, making the initialization of reports unnecessary.
> +	 * The Win7 spec is less precise, but we can safely assume that when
> +	 * the module is loaded (at boot), no one is touching the screen.
> +	 */
> +	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
> +
> +	/*
>  	 * This allows the driver to handle different input sensors
>  	 * that emits events through different reports on the same HID
>  	 * device.
> -- 
> 1.8.3.1
> 

Thanks,
Henrik
