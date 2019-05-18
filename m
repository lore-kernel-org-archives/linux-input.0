From: Igor Kushnir <igorkuo@gmail.com>
Subject: Re: [PATCH v3] HID: fix A4Tech horizontal scrolling
Date: Sat, 18 May 2019 12:08:57 +0300
Message-ID: <858498ef-b43a-f382-bfbc-e3a2ac9935e4@gmail.com>
References: <20190507050029.GA5197@jelly>
 <20190512203313.18756-1-spaz16@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512203313.18756-1-spaz16@wp.pl>
Content-Language: uk-UA
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>
Cc: peter.hutterer@who-t.net, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

I have verified that the PATCH v3 applied to kernel 5.0.15 fixes 
horizontal scrolling for my A4Tech WOP-49Z mouse just as well as the 
previous patch did.

Thank you,
Igor

On 5/12/19 11:33 PM, Błażej Szczygieł wrote:
> Since recent high resolution scrolling changes the A4Tech driver must
> check for the "REL_WHEEL_HI_RES" usage code.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203369
> Fixes: 2dc702c991e3774af9d7ce410eef410ca9e2357e ("HID: input: use the
> Resolution Multiplier for high-resolution scrolling")
> 
> Signed-off-by: Błażej Szczygieł <spaz16@wp.pl>
> ---
> Changes in v2:
> - changed commit message
> 
> Changes in v3:
> - send also high resolution events
> 
>   drivers/hid/hid-a4tech.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-a4tech.c b/drivers/hid/hid-a4tech.c
> index 9428ea7cdf8a..c3a6ce3613fe 100644
> --- a/drivers/hid/hid-a4tech.c
> +++ b/drivers/hid/hid-a4tech.c
> @@ -38,8 +38,10 @@ static int a4_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>   {
>   	struct a4tech_sc *a4 = hid_get_drvdata(hdev);
>   
> -	if (usage->type == EV_REL && usage->code == REL_WHEEL)
> +	if (usage->type == EV_REL && usage->code == REL_WHEEL_HI_RES) {
>   		set_bit(REL_HWHEEL, *bit);
> +		set_bit(REL_HWHEEL_HI_RES, *bit);
> +	}
>   
>   	if ((a4->quirks & A4_2WHEEL_MOUSE_HACK_7) && usage->hid == 0x00090007)
>   		return -1;
> @@ -60,7 +62,7 @@ static int a4_event(struct hid_device *hdev, struct hid_field *field,
>   	input = field->hidinput->input;
>   
>   	if (a4->quirks & A4_2WHEEL_MOUSE_HACK_B8) {
> -		if (usage->type == EV_REL && usage->code == REL_WHEEL) {
> +		if (usage->type == EV_REL && usage->code == REL_WHEEL_HI_RES) {
>   			a4->delayed_value = value;
>   			return 1;
>   		}
> @@ -68,6 +70,8 @@ static int a4_event(struct hid_device *hdev, struct hid_field *field,
>   		if (usage->hid == 0x000100b8) {
>   			input_event(input, EV_REL, value ? REL_HWHEEL :
>   					REL_WHEEL, a4->delayed_value);
> +			input_event(input, EV_REL, value ? REL_HWHEEL_HI_RES :
> +					REL_WHEEL_HI_RES, a4->delayed_value * 120);
>   			return 1;
>   		}
>   	}
> @@ -77,8 +81,9 @@ static int a4_event(struct hid_device *hdev, struct hid_field *field,
>   		return 1;
>   	}
>   
> -	if (usage->code == REL_WHEEL && a4->hw_wheel) {
> +	if (usage->code == REL_WHEEL_HI_RES && a4->hw_wheel) {
>   		input_event(input, usage->type, REL_HWHEEL, value);
> +		input_event(input, usage->type, REL_HWHEEL_HI_RES, value * 120);
>   		return 1;
>   	}
>   
> 
