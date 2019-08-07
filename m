From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] HID: wacom: Correct distance scale for 2nd-gen Intuos
 devices
Date: Wed, 7 Aug 2019 07:18:39 +0200
Message-ID: <20190807051839.GA26833@kroah.com>
References: <20190806205805.21168-1-jason.gerecke@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190806205805.21168-1-jason.gerecke@wacom.com>
Sender: stable-owner@vger.kernel.org
To: "Gerecke, Jason" <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 06, 2019 at 01:58:05PM -0700, Gerecke, Jason wrote:
> From: Jason Gerecke <jason.gerecke@wacom.com>
> 
> Distance values reported by 2nd-gen Intuos tablets are on an inveted scale
> (0 == far, 63 == near). We need to change them over to a normal scale before
> reporting to userspace or else userspace drivers and applications can get
> confused.
> 
> Ref: https://github.com/linuxwacom/input-wacom/issues/98
> Fixes: eda01dab53 ("HID: wacom: Add four new Intuos devices")
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Cc: <stable@vger.kernel.org> # v4.4+
> ---
>  drivers/hid/wacom_wac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 7a8ddc999a8e..879e41fbf604 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -846,6 +846,9 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
>  		y >>= 1;
>  		distance >>= 1;
>  	}
> +	if (features->type == INTUOSHT2) {
> +		distance = features->distance_max - distance;
> +	}

{ } not needed, always run checkpatch.pl before sending stuff out :(
