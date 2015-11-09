From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 1/2] hid: sony: Refactor output report sending functions
Date: Mon, 9 Nov 2015 15:02:41 +0100
Message-ID: <20151109150241.e8c09e8f6b5a319be38f604c@ao2.it>
References: <1446909130-9168-1-git-send-email-frank.praznik@gmail.com>
	<1446909130-9168-2-git-send-email-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:12905 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbbKIOIm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Nov 2015 09:08:42 -0500
In-Reply-To: <1446909130-9168-2-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Sat,  7 Nov 2015 10:12:09 -0500
Frank Praznik <frank.praznik@gmail.com> wrote:

> Refactor output report sending functions to allow for the sending of
> output reports without enqueing a work item.  Output reports for any device
                         ^
                         enqueuing or enqueueing :)

> can now be sent by calling the sony_send_output_report function which will
> automatically dispatch the request to the appropriate output function.  The
> individual state worker functions have been replaced with a universal
> sony_state_worker function which calls sony_send_output_report.
> 
> Signed-off-by: Frank Praznik <frank.praznik@gmail.com>

Looks good to me, just one comment below.

> ---
>  drivers/hid/hid-sony.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 661f94f..b84b2ce 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1782,7 +1782,7 @@ error_leds:
>  	return ret;
>  }
>  
> -static void sixaxis_state_worker(struct work_struct *work)
> +static void sixaxis_send_output_report(struct sony_sc *sc)
>  {
>  	static const union sixaxis_output_report_01 default_report = {
>  		.buf = {
> @@ -1796,7 +1796,6 @@ static void sixaxis_state_worker(struct work_struct *work)
>  			0x00, 0x00, 0x00, 0x00, 0x00
>  		}
>  	};
> -	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>  	struct sixaxis_output_report *report =
>  		(struct sixaxis_output_report *)sc->output_report_dmabuf;
>  	int n;
> @@ -1839,9 +1838,8 @@ static void sixaxis_state_worker(struct work_struct *work)
>  			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>  }
>  
> -static void dualshock4_state_worker(struct work_struct *work)
> +static void dualshock4_send_output_report(struct sony_sc *sc)
>  {
> -	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>  	struct hid_device *hdev = sc->hdev;
>  	__u8 *buf = sc->output_report_dmabuf;
>  	int offset;
> @@ -1886,9 +1884,8 @@ static void dualshock4_state_worker(struct work_struct *work)
>  				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>  }
>  
> -static void motion_state_worker(struct work_struct *work)
> +static void motion_send_output_report(struct sony_sc *sc)
>  {
> -	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>  	struct hid_device *hdev = sc->hdev;
>  	struct motion_output_report_02 *report =
>  		(struct motion_output_report_02 *)sc->output_report_dmabuf;
> @@ -1907,6 +1904,23 @@ static void motion_state_worker(struct work_struct *work)
>  	hid_hw_output_report(hdev, (__u8 *)report, MOTION_REPORT_0x02_SIZE);
>  }
>  
> +static void sony_send_output_report(struct sony_sc *sc)
> +{
> +	if (sc->quirks & DUALSHOCK4_CONTROLLER)
> +		dualshock4_send_output_report(sc);
> +	else if ((sc->quirks & SIXAXIS_CONTROLLER) ||
> +			(sc->quirks & NAVIGATION_CONTROLLER))
> +		sixaxis_send_output_report(sc);
> +	else if (sc->quirks & MOTION_CONTROLLER)
> +		motion_send_output_report(sc);
> +}

We could have have a function pointer to a send_output_report callback
in struct sony_sc, set the appropriate call back in sony_probe() once
and for all and drop sony_send_output_report() which is identifying
again the device, something we already did in sony_probe().
Just an idea for a more declarative approach, but this way is OK too.

> +
> +static void sony_state_worker(struct work_struct *work)
> +{
> +	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
> +	sony_send_output_report(sc);

this would become:

	sc->send_output_report(sc);

same as in patch 2/2.

> +}
> +
>  static int sony_allocate_output_report(struct sony_sc *sc)
>  {
>  	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
> @@ -2234,11 +2248,10 @@ static void sony_release_device_id(struct sony_sc *sc)
>  	}
>  }
>  
> -static inline void sony_init_work(struct sony_sc *sc,
> -					void (*worker)(struct work_struct *))
> +static inline void sony_init_work(struct sony_sc *sc)
>  {
>  	if (!sc->worker_initialized)
> -		INIT_WORK(&sc->state_worker, worker);
> +		INIT_WORK(&sc->state_worker, sony_state_worker);
>  
>  	sc->worker_initialized = 1;
>  }
> @@ -2312,7 +2325,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
>  		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
>  		ret = sixaxis_set_operational_usb(hdev);
> -		sony_init_work(sc, sixaxis_state_worker);
> +		sony_init_work(sc);
>  	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
>  			(sc->quirks & NAVIGATION_CONTROLLER_BT)) {
>  		/*
> @@ -2321,7 +2334,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		 */
>  		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
>  		ret = sixaxis_set_operational_bt(hdev);
> -		sony_init_work(sc, sixaxis_state_worker);
> +		sony_init_work(sc);
>  	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
>  		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
>  			/*
> @@ -2336,9 +2349,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  			}
>  		}
>  
> -		sony_init_work(sc, dualshock4_state_worker);
> +		sony_init_work(sc);
>  	} else if (sc->quirks & MOTION_CONTROLLER) {
> -		sony_init_work(sc, motion_state_worker);
> +		sony_init_work(sc);
>  	} else {
>  		ret = 0;
>  	}
> -- 

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
