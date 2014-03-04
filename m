From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/4] HID: cp2112: remove the last hid_output_raw_report()
 call
Date: Tue, 4 Mar 2014 14:46:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403041445080.30402@pobox.suse.cz>
References: <1393633237-26496-1-git-send-email-benjamin.tissoires@redhat.com> <1393633237-26496-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393633237-26496-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 28 Feb 2014, Benjamin Tissoires wrote:

> I don't have access to the device, so I copied/pasted the code
> from hidraw.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-cp2112.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 860db694..c4f87bd 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -290,7 +290,21 @@ static int cp2112_hid_output(struct hid_device *hdev, u8 *data, size_t count,
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = hdev->hid_output_raw_report(hdev, buf, count, report_type);
> +	/* Fixme: test which function is actually called for output reports */

I don't completely understand this Fixme (oh, and please spell it as 
'FIXME:' so that we are consistent with all the other instances), could 
you please elaborate?

Thanks,

-- 
Jiri Kosina
SUSE Labs
