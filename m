From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] HID: fix A4Tech horizontal scrolling
Date: Tue, 7 May 2019 15:00:29 +1000
Message-ID: <20190507050029.GA5197@jelly>
References: <AO-hwJKNH7WoJV-X+egK5cJNNtxamh0L0e1er5dkiTt6KvrmSQ@mail.gmail.com>
 <20190503202836.12127-1-spaz16@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503202836.12127-1-spaz16@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>
Cc: igorkuo@gmail.com, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, May 03, 2019 at 10:28:36PM +0200, Błażej Szczygieł wrote:
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
>  drivers/hid/hid-a4tech.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-a4tech.c b/drivers/hid/hid-a4tech.c
> index 9428ea7cdf8a..fafb9fa558e7 100644
> --- a/drivers/hid/hid-a4tech.c
> +++ b/drivers/hid/hid-a4tech.c
> @@ -38,7 +38,7 @@ static int a4_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  {
>  	struct a4tech_sc *a4 = hid_get_drvdata(hdev);
>  
> -	if (usage->type == EV_REL && usage->code == REL_WHEEL)
> +	if (usage->type == EV_REL && usage->code == REL_WHEEL_HI_RES)
>  		set_bit(REL_HWHEEL, *bit);
>  
>  	if ((a4->quirks & A4_2WHEEL_MOUSE_HACK_7) && usage->hid == 0x00090007)
> @@ -60,7 +60,7 @@ static int a4_event(struct hid_device *hdev, struct hid_field *field,
>  	input = field->hidinput->input;
>  
>  	if (a4->quirks & A4_2WHEEL_MOUSE_HACK_B8) {
> -		if (usage->type == EV_REL && usage->code == REL_WHEEL) {
> +		if (usage->type == EV_REL && usage->code == REL_WHEEL_HI_RES) {
>  			a4->delayed_value = value;
>  			return 1;
>  		}
> @@ -77,7 +77,7 @@ static int a4_event(struct hid_device *hdev, struct hid_field *field,
>  		return 1;
>  	}
>  
> -	if (usage->code == REL_WHEEL && a4->hw_wheel) {
> +	if (usage->code == REL_WHEEL_HI_RES && a4->hw_wheel) {
>  		input_event(input, usage->type, REL_HWHEEL, value);

You'll need to send both events here, so please add:
   		input_event(input, usage->type, REL_HWHEEL_HI_RES, value * 120);

assume that wheel and wheel_hi_res are two separate event streams for the
same axis, userspace may listen to either or both. if you only send the
legacy event, newer userspace won't receive any scroll events as it may only
look for the new hi-res events.

Check with evtest/evemu/libinput record after, you should see multiples of
120 on the hi-res axis for every legacy wheel event.

Cheers,
   Peter

>  		return 1;
>  	}
> -- 
> 2.21.0
> 
