From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] hid-input: Map unknown consumer page codes to
 KEY_UNKNOWN
Date: Tue, 21 Oct 2014 14:55:39 -0700
Message-ID: <20141021215539.GF8609@dtor-ws>
References: <1413925860-3441-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53155 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458AbaJUVzo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2014 17:55:44 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so2274116pab.6
        for <linux-input@vger.kernel.org>; Tue, 21 Oct 2014 14:55:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413925860-3441-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 21, 2014 at 11:11:00PM +0200, Hans de Goede wrote:
> Currently unknown consumer page codes are ignored, which means that they
> cannot later be mapped from userspace using udev / hwdb. Map them to
> KEY_UNKNOWN, so that userspace can remap them for keyboards which
> make up their own consumer page codes.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I think this makes sense. Thanks Hans.

> 
> --
> Changes in v2: Use key_map_clear rather then key_map
> ---
>  drivers/hid/hid-input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..a6e33d3 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -856,7 +856,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
>  		case 0x28c: map_key_clear(KEY_SEND);		break;
>  
> -		default:    goto ignore;
> +		default: map_key_clear(KEY_UNKNOWN);
>  		}
>  		break;
>  
> -- 
> 2.1.0
> 

-- 
Dmitry
