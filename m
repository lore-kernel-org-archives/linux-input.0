From: Robert Munteanu <rombert@apache.org>
Subject: Re: [PATCH 1/2] HID: redragon: Fix regression in non-Redragon
 keyboard due to this new driver
Date: Mon, 30 Jul 2018 16:05:09 +0200
Message-ID: <6330995a9313ade9196cadb2e3696d53d4ef9aa8.camel@apache.org>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
         <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
         <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John S Gruber <JohnSGruber@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi John,

On Sat, 2018-07-28 at 15:53 -0400, John S Gruber wrote:
> The Redragon keyboard uses the second device being presented, but
> other
> devices with the same vendor_id/device_id pair (0x0c45:760b) use the
> first.
> Don't cause its deletion. Problem introduced in commit 85455dd906d5
> ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")
> 
> Fixes: 85455dd906d5
> Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
> ---
>  drivers/hid/hid-redragon.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
> index daf5957..85a5fbb 100644
> --- a/drivers/hid/hid-redragon.c
> +++ b/drivers/hid/hid-redragon.c
> @@ -55,10 +55,6 @@ static int redragon_probe(struct hid_device *dev,
>  		return ret;
>  	}
> 
> -	/* do not register unused input device */
> -	if (dev->maxapplication == 1)
> -		return 0;
> -
>  	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
>  	if (ret) {
>  		hid_err(dev, "hw start failed\n");

As I mentioned, this is already fixed by
dc9b8e85ed95cbe7e3ad0eabb5b48d617bbc365e, scheduled for 4.19, and I
suggest that we instead add that one to 4.18.

The explanation is that the block you deleted was the whole reason for
adding the redragon_probe function, so the changes are largely
equivalent.

Thanks,

Robert
