From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: generic: Recognize WACOM_HID_WD_PEN as a
 type of pen collection
Date: Wed, 18 Oct 2017 18:38:43 +0200
Message-ID: <20171018163843.GF24559@mail.corp.redhat.com>
References: <20171018152713.22633-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018152713.22633-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Oct 18 2017 or thereabouts, Jason Gerecke wrote:
> The WACOM_PEN_FIELD macro is used to determine if a given HID field should be
> associated with pen input. This field includes several known collection types
> that Wacom pen data is contained in, but the WACOM_HID_WD_PEN application
> collection type is notably missing. This can result in fields within this
> kind of collection being completely ignored by the `wacom_usage_mapping`
> function, preventing the later '*_event' functions from being notified about
> changes to their value.
> 
> Fixes: c9c095874a ("HID: wacom: generic: Support and use 'Custom HID' mode and usages")
> Fixes: ac2423c975 ("HID: wacom: generic: add vendor defined touch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---

Looks good:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/wacom_wac.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 8a03654048bf..feb62fd4dfc3 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -166,6 +166,7 @@
>  				 ((f)->physical == HID_DG_PEN) || \
>  				 ((f)->application == HID_DG_PEN) || \
>  				 ((f)->application == HID_DG_DIGITIZER) || \
> +				 ((f)->application == WACOM_HID_WD_PEN) || \
>  				 ((f)->application == WACOM_HID_WD_DIGITIZER) || \
>  				 ((f)->application == WACOM_HID_G9_PEN) || \
>  				 ((f)->application == WACOM_HID_G11_PEN))
> -- 
> 2.14.2
> 
