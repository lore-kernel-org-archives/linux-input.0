From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: sony: disable descriptor fixup for FutureMax
 Dance Mat
Date: Mon, 25 Jul 2016 11:15:52 +0200
Message-ID: <20160725091552.GE19383@mail.corp.redhat.com>
References: <20160721165448.14275-1-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160721165448.14275-1-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: jikos@kernel.org, ao2@ao2.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-input@vger.kernel.org

On Jul 21 2016 or thereabouts, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> The FutureMax Dance Mat claims to be a SixAxis controller
> but breaks if descriptor fixups are applied. Detect the
> device using its USB product string and disable fixups
> when it is detected.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Works for me but I'd like to get Antonio's ACK or Rev-by.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
> v2: don't use usb device properties
> 
>  drivers/hid/hid-sony.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 310436a..29a1aa9 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -51,6 +51,7 @@
>  #define NAVIGATION_CONTROLLER_USB BIT(9)
>  #define NAVIGATION_CONTROLLER_BT  BIT(10)
>  #define SINO_LITE_CONTROLLER      BIT(11)
> +#define FUTUREMAX_DANCE_MAT       BIT(12)
>  
>  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
>  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> @@ -1125,7 +1126,7 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
>  {
>  	struct sony_sc *sc = hid_get_drvdata(hdev);
>  
> -	if (sc->quirks & SINO_LITE_CONTROLLER)
> +	if (sc->quirks & (SINO_LITE_CONTROLLER | FUTUREMAX_DANCE_MAT))
>  		return rdesc;
>  
>  	/*
> @@ -2289,6 +2290,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	struct sony_sc *sc;
>  	unsigned int connect_mask = HID_CONNECT_DEFAULT;
>  
> +	if (!strcmp(hdev->name, "FutureMax Dance Mat"))
> +		quirks |= FUTUREMAX_DANCE_MAT;
> +
>  	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
>  	if (sc == NULL) {
>  		hid_err(hdev, "can't alloc sony descriptor\n");
> -- 
> 2.9.0
> 
