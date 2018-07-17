From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: roccat: Mark expected switch fall-through
Date: Tue, 17 Jul 2018 15:53:27 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1807171553020.997@cbobk.fhfr.pm>
References: <20180702182907.GA22465@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702182907.GA22465@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2 Jul 2018, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/hid/hid-roccat-kone.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index bf4675a..c4dd616 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -783,6 +783,7 @@ static void kone_keep_values_up_to_date(struct kone_device *kone,
>  	case kone_mouse_event_switch_profile:
>  		kone->actual_dpi = kone->profiles[event->value - 1].
>  				startup_dpi;
> +		/* fall through */
>  	case kone_mouse_event_osd_profile:
>  		kone->actual_profile = event->value;
>  		break;

I *think* the fall-through is correct thing to do here, but I'd like to 
get explicit Ack from Stefan. Stefan, please?

-- 
Jiri Kosina
SUSE Labs
