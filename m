From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 2/7] Input: psmouse - clean up code
Date: Mon, 25 Jun 2018 20:35:14 +0200
Message-ID: <e8ad7e61-342a-8d53-7de1-f30a58c91975@suse.cz>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
 <20180119230629.49428-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119230629.49428-3-dmitry.torokhov@gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/20/2018, 12:06 AM, Dmitry Torokhov wrote:
> - switch to using BIT() macros
> - use u8 instead of unsigned char for byte data
> - use input_set_capability() instead of manipulating capabilities bits
>   directly
> - use sign_extend32() when extracting wheel data.
> - do not abuse -1 as error code, propagate errors from various calls.
…
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
…
> @@ -157,39 +159,42 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
…
>  		case 0x00:
>  		case 0xC0:
> -			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
> -			input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
> -			input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
> +			input_report_rel(dev, REL_WHEEL,
> +					 -sign_extend32(packet[3], 3));
> +			input_report_key(dev, BTN_SIDE,  BIT(4));
> +			input_report_key(dev, BTN_EXTRA, BIT(5));
>  			break;
>  		}
>  		break;
>  
>  	case PSMOUSE_GENPS:
>  		/* Report scroll buttons on NetMice */
> -		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
> +		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
>  
>  		/* Extra buttons on Genius NewNet 3D */
> -		input_report_key(dev, BTN_SIDE, (packet[0] >> 6) & 1);
> -		input_report_key(dev, BTN_EXTRA, (packet[0] >> 7) & 1);
> +		input_report_key(dev, BTN_SIDE,  BIT(6));
> +		input_report_key(dev, BTN_EXTRA, BIT(7));
>  		break;
>  
>  	case PSMOUSE_THINKPS:
>  		/* Extra button on ThinkingMouse */
> -		input_report_key(dev, BTN_EXTRA, (packet[0] >> 3) & 1);
> +		input_report_key(dev, BTN_EXTRA, BIT(3));

While hunting a 4.17 bug where some openSUSE users lost their ability to
mouse-click, I came across this commit. Putting aside it's a total mess
of multiple changes, were these changes above intentional at all? I mean
changing
  (packet[0] >> 3) & 1
to hardwired
  BIT(3)
does not look quite right. And if it is for some to me unknown reason,
it should have been properly documented in the commit log. I believe
your intent was:
  packet[0] & BIT(3)
?

thanks,
-- 
js
suse labs
