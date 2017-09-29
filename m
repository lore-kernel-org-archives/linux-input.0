From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - Disable kernel tracking on SMBus
 devices
Date: Fri, 29 Sep 2017 10:08:44 +0200
Message-ID: <20170929080844.GA14877@mail.corp.redhat.com>
References: <1506629239-5940-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506629239-5940-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kamil =?utf-8?B?UMOhcmFs?= <kparal@redhat.com>
List-Id: linux-input@vger.kernel.org

On Sep 28 2017 or thereabouts, Andrew Duggan wrote:
> In certain situations kernel tracking seems to be getting confused
> and incorrectly reporting the slot of a contact. On example is when
> the user does a three finger click or tap and then places two fingers
> on the touchpad in the same area. The kernel tracking code seems to
> continue to think that there are three contacts on the touchpad and
> incorrectly alternates the slot of one of the contacts. The result that
> is the input subsystem reports a stream of button press and release
> events as the reported slot changes.
> 
> Kernel tracking was originally enabled to prevent cursor jumps, but it
> is unclear how much of an issue kernel jumps actually are. This patch
> simply disabled kernel tracking for now.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1482640
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Tested-by: Kamil Páral <kparal@redhat.com>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Andrew for the patch!

Cheers,
Benjamin

> ---
>  drivers/input/mouse/synaptics.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 5af0b7d..ee5466a 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1709,8 +1709,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
>  		.sensor_pdata = {
>  			.sensor_type = rmi_sensor_touchpad,
>  			.axis_align.flip_y = true,
> -			/* to prevent cursors jumps: */
> -			.kernel_tracking = true,
> +			.kernel_tracking = false,
>  			.topbuttonpad = topbuttonpad,
>  		},
>  		.f30_data = {
> -- 
> 2.7.4
> 
