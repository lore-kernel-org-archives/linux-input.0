From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 3/3] HID: asus: change mapping from KEY_WLAN to
 KEY_RFKILL
Date: Mon, 13 Mar 2017 14:17:38 +0100
Message-ID: <20170313131738.GJ4378@mail.corp.redhat.com>
References: <1489015875-3558-1-git-send-email-matjaz.hegedic@gmail.com>
 <1489015875-3558-3-git-send-email-matjaz.hegedic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbdCMNRn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 09:17:43 -0400
Content-Disposition: inline
In-Reply-To: <1489015875-3558-3-git-send-email-matjaz.hegedic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matjaz Hegedic <matjaz.hegedic@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org

On Mar 09 2017 or thereabouts, Matjaz Hegedic wrote:
> The input mapping code incorrectly maps the Airplane Mode button to
> KEY_WLAN, which stands for WiFi toggle, but doesn't affect Bluetooth
> (and other active radios) which is expected behavior for Airplane
> Mode.
> 
> The fix replaces KEY_WLAN with the more appropriate KEY_RFKILL.
> 
> The declared usage code 0x88 corresponds to Airplane Mode button on
> all keyboards handled by hid-asus (I2C netbook keyboards and USB
> RoG series keyboards), so the fix doesn't introduce any
> inconsistencies across different models.
> 
> Signed-off-by: Matjaz Hegedic <matjaz.hegedic@gmail.com>
> ---

The series is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-asus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e0de54b..bacba97 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -226,7 +226,7 @@ static int asus_input_mapping(struct hid_device *hdev,
>  		case 0x35: asus_map_key_clear(KEY_DISPLAY_OFF);		break;
>  		case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
>  		case 0x82: asus_map_key_clear(KEY_CAMERA);		break;
> -		case 0x88: asus_map_key_clear(KEY_WLAN);			break;
> +		case 0x88: asus_map_key_clear(KEY_RFKILL);			break;
>  		case 0xb5: asus_map_key_clear(KEY_CALC);			break;
>  		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
>  		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
> -- 
> 2.7.4
> 
