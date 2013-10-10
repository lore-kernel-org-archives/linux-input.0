From: Rafael Brune <mail@rbrune.de>
Subject: Re: [PATCH 1/1] HID: wiimote: invert Y-Axis and add automatic calibration for Wii U Pro Controller
Date: Thu, 10 Oct 2013 17:46:27 +0200
Message-ID: <121A2CAD-9706-4A86-AF20-60B25DF00101@rbrune.de>
References: <1381085096-4511-1-git-send-email-mail@rbrune.de> <CANq1E4ToCfOCe9Fe0iDdJGJv_D4rOT6gB5g=7neTaHj9_esiLA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tyrell.rbrune.de ([83.169.16.173]:58719 "EHLO tyrell.rbrune.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab3JJPq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 11:46:29 -0400
In-Reply-To: <CANq1E4ToCfOCe9Fe0iDdJGJv_D4rOT6gB5g=7neTaHj9_esiLA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Oct 10, 2013, at 11:16 AM, David Herrmann wrote:

> Hi
> 
> On Sun, Oct 6, 2013 at 8:44 PM, Rafael Brune <mail@rbrune.de> wrote:
>> With these changes the Wii U Pro Controller fully complies
>> to the gamepad-API and with the calibration is fully usable
>> out-of-the-box without any user-space tools. This potentially
>> breaks compatibility with software that relies on the two
>> inverted Y-Axis but since current bluez 4.x and 5.x versions
>> don't even support pairing with the controller yet the amount
>> of people affected should be rather small.
> 
> Did anyone try to read the calibration values from the EEPROM? Doing
> calibration in the kernel is fine, but I'd rather have the
> hardware-calibration values instead. Even if we cannot figure it out
> now, we should try to stay as compatible to the real values as we can.
> 
> So how about keeping the min/max and neutral point as we have it know
> and instead adjusting the reported values by scaling/moving them?
> 

After googling a little bit it seems like their might actually be no
calibration data for the Classic Controller and Wii U Pro Controller. The
midpoint is supposedly just detected when the device connects.
http://wiibrew.org/wiki/Classic_Controller

My code did not change what we output as the min/max/mid values it's
still -0x800,0x000,0x800. As you suggest it scales/moves the raw values
so that the reported values fall into that range.


>> Signed-off-by: Rafael Brune <mail@rbrune.de>
>> ---
>> drivers/hid/hid-wiimote-modules.c | 45 +++++++++++++++++++++++++++++++++++----
>> 1 file changed, 41 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
>> index 2e7d644..1422b0b 100644
>> --- a/drivers/hid/hid-wiimote-modules.c
>> +++ b/drivers/hid/hid-wiimote-modules.c
>> @@ -1640,10 +1640,41 @@ static void wiimod_pro_in_ext(struct wiimote_data *wdata, const __u8 *ext)
>>        ly = (ext[4] & 0xff) | ((ext[5] & 0x0f) << 8);
>>        ry = (ext[6] & 0xff) | ((ext[7] & 0x0f) << 8);
>> 
>> -       input_report_abs(wdata->extension.input, ABS_X, lx - 0x800);
>> -       input_report_abs(wdata->extension.input, ABS_Y, ly - 0x800);
>> -       input_report_abs(wdata->extension.input, ABS_RX, rx - 0x800);
>> -       input_report_abs(wdata->extension.input, ABS_RY, ry - 0x800);
>> +       /* Calibrating the sticks by saving the global min/max per axis */
>> +       if (lx < wdata->state.calib_bboard[0][0])
>> +               wdata->state.calib_bboard[0][0] = lx;
>> +       if (lx > wdata->state.calib_bboard[0][1])
>> +               wdata->state.calib_bboard[0][1] = lx;
>> +
>> +       if (ly < wdata->state.calib_bboard[1][0])
>> +               wdata->state.calib_bboard[1][0] = ly;
>> +       if (ly > wdata->state.calib_bboard[1][1])
>> +               wdata->state.calib_bboard[1][1] = ly;
>> +
>> +       if (rx < wdata->state.calib_bboard[2][0])
>> +               wdata->state.calib_bboard[2][0] = rx;
>> +       if (rx > wdata->state.calib_bboard[2][1])
>> +               wdata->state.calib_bboard[2][1] = rx;
>> +
>> +       if (ry < wdata->state.calib_bboard[3][0])
>> +               wdata->state.calib_bboard[3][0] = ry;
>> +       if (ry > wdata->state.calib_bboard[3][1])
>> +               wdata->state.calib_bboard[3][1] = ry;
>> +
>> +       /* Normalize using int math to prevent conversion to/from float */
>> +       lx = -2048 + (((__s32)(lx - wdata->state.calib_bboard[0][0]) * 4096)/
>> +          (wdata->state.calib_bboard[0][1]-wdata->state.calib_bboard[0][0]));
>> +       ly = -2048 + (((__s32)(ly - wdata->state.calib_bboard[1][0]) * 4096)/
>> +          (wdata->state.calib_bboard[1][1]-wdata->state.calib_bboard[1][0]));
>> +       rx = -2048 + (((__s32)(rx - wdata->state.calib_bboard[2][0]) * 4096)/
>> +          (wdata->state.calib_bboard[2][1]-wdata->state.calib_bboard[2][0]));
>> +       ry = -2048 + (((__s32)(ry - wdata->state.calib_bboard[3][0]) * 4096)/
>> +          (wdata->state.calib_bboard[3][1]-wdata->state.calib_bboard[3][0]));
> 
> Don't use calib_bboard. Add a new array (or use a union). This is confusing.

I agree, will do that.


>> +
>> +       input_report_abs(wdata->extension.input, ABS_X,  lx);
>> +       input_report_abs(wdata->extension.input, ABS_Y, -ly);
>> +       input_report_abs(wdata->extension.input, ABS_RX,  rx);
>> +       input_report_abs(wdata->extension.input, ABS_RY, -ry);
>> 
>>        input_report_key(wdata->extension.input,
>>                         wiimod_pro_map[WIIMOD_PRO_KEY_RIGHT],
>> @@ -1760,6 +1791,12 @@ static int wiimod_pro_probe(const struct wiimod_ops *ops,
>>        if (!wdata->extension.input)
>>                return -ENOMEM;
>> 
>> +       /* Initialize min/max values for all Axis with reasonable values */
>> +       for (i = 0; i < 4; ++i) {
>> +               wdata->state.calib_bboard[i][0] = 0x780;
>> +               wdata->state.calib_bboard[i][1] = 0x880;
> 
> Ugh, these values look weird. We have a reported range of -0x400 to
> +0x400 but you limit it to a virtual range of 0x100. That's a loss of
> precision of 80%. Where are these values from?

I picked these values arbitrarily as starting points since they will update
during use of the gamepad as soon as lower/higher values are observed.
As soon as the sticks have been moved to their extreme positions once
everything is perfect.

We could also set those values in a similar fashion as to what Nintendo
seems to be doing. Wait for a first report of raw values, use them as the
mid point and set these min/max values as midpoint +/- ~0x800.


>> +       }
>> +
>>        set_bit(FF_RUMBLE, wdata->extension.input->ffbit);
>>        input_set_drvdata(wdata->extension.input, wdata);
> 
> Thanks for hacking this up. Could you give me some values from your
> device so I can see how big the deviation is? My device reports:
> 
> Range: 0-4095 (0x0fff)
> Neutral-Point: 2048 (0x800)
> 
> I haven't seen any big deviations from these values. I can try to take
> this over if you want, just let me know.
> 
> Thanks
> David


When I write out the observed raw min/max values of all Axis I get these:
LX: 1033 - 3326 (center~=2179 (0x883))
LY:  857 - 3211 (center~=2034 (0x7F2))
RX: 944 - 3176 (center~=2060 (0x80C))
RY: 853 - 3159 (center~=2006 (0x7D6))

So not really the whole range of 0x0FFF is actually used and offsets due
to manufacturing differences are present.


Regards,
 Rafael





