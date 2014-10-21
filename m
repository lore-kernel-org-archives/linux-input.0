From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] hid-input: Map unknown consumer page codes to KEY_UNKNOWN
Date: Tue, 21 Oct 2014 23:07:12 +0200
Message-ID: <5446CB00.7050004@redhat.com>
References: <1413925206-3458-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50351 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932840AbaJUVHR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2014 17:07:17 -0400
In-Reply-To: <1413925206-3458-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hoi,

On 10/21/2014 11:00 PM, Hans de Goede wrote:
> Currently unknown consumer page codes are ignored, which means that they
> cannot later be mapped from userspace using udev / hwdb. Map them to
> KEY_UNKNOWN, so that userspace can remap them for keyboards which
> make up their own consumer page codes.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/hid/hid-input.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..e25c003 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -856,7 +856,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>   		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
>   		case 0x28c: map_key_clear(KEY_SEND);		break;
>
> -		default:    goto ignore;
> +		default: map_key(KEY_UNKNOWN);

Erm, this needs to be map_key_clear, please ignore. I'll send a v2 with this fixed.

Regards,

Hans
