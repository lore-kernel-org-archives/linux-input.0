From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: asus: Stop underlying hardware on remove
Date: Fri, 2 Jun 2017 09:31:00 +0200
Message-ID: <20170602073100.GL1293@mail.corp.redhat.com>
References: <20170530203946.9346-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530203946.9346-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Carlo Caione <carlo@endlessm.com>
List-Id: linux-input@vger.kernel.org

On May 30 2017 or thereabouts, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> We are missing a call to hid_hw_stop() on the remove hook.
> Among other things this is causing an Oops when (re-)starting GNOME /
> upowerd / ... after the module has been already rmmod-ed.

Good catch:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/hid/hid-asus.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 16df6cc..2e9642d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -536,6 +536,8 @@ static void asus_remove(struct hid_device *hdev)
>  		drvdata->kbd_backlight->removed = true;
>  		cancel_work_sync(&drvdata->kbd_backlight->work);
>  	}
> +
> +	hid_hw_stop(hdev);
>  }
>  
>  static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> -- 
> 2.9.3
> 
