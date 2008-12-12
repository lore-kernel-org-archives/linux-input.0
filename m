From: "Dan Streetman" <ddstreet@ieee.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated coordinate data for MicroTouch/3M touchscreens
Date: Fri, 12 Dec 2008 12:40:52 -0500
Message-ID: <3fad22b40812120940h54c28fb1o92528758ab900aa5__44816.6081020192$1229103747$gmane$org@mail.gmail.com>
References: <alpine.LNX.1.10.0811251035260.30650@floyd.root.cx>
	 <3fad22b40812021135v78410015ya0ea1bd149beeb0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:44087 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799AbYLLRkx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Dec 2008 12:40:53 -0500
In-Reply-To: <3fad22b40812021135v78410015ya0ea1bd149beeb0a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <greg@kroah.com>, daniel.ritz@gmx.ch, linux-usb@vger.kernel.org, linux-input@vger.kernel.o

Ping.  Any comments on this?  Is it ok to get it into the kernel?

On Tue, Dec 2, 2008 at 2:35 PM, Dan Streetman <ddstreet@ieee.org> wrote:
> Ping.
>
> Dmitry, does the patch look ok?
>
> On Tue, Nov 25, 2008 at 11:29 AM, Dan Streetman <ddstreet@ieee.org> wrote:
>>
>> On Tue, Nov 25, 2008 at 10:27 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>>> On Mon, 24 Nov 2008, Dan Streetman wrote:
>>>
>>>> +     // Default min/max xy are the raw values, override if using hw-calib
>>>
>>> Please use style of comments that is in compliance with kernel coding
>>> style.
>>
>> Oops, ok.  Updated patch below.
>>
>>
>>
>>
>> This patch adds a module parameter to report either the raw coordinate data or
>> the hardware-calibrated coordinate data.  The default is set to the raw
>> coordinates for backwards compatibilty.
>>
>> Signed-off-by: Dan Streetman <ddstreet@ieee.org>
>>
>>
>> --- a/drivers/input/touchscreen/usbtouchscreen.c        2008-11-17 10:51:30.000000000 -0500
>> +++ b/drivers/input/touchscreen/usbtouchscreen.c        2008-11-17 10:51:45.000000000 -0500
>> @@ -60,6 +60,10 @@ static int swap_xy;
>>  module_param(swap_xy, bool, 0644);
>>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
>>
>> +static int hwcalib_xy = 0;
>> +module_param(hwcalib_xy, bool, 0644);
>> +MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
>> +
>>  /* device specifc data/functions */
>>  struct usbtouch_usb;
>>  struct usbtouch_device_info {
>> @@ -260,8 +264,13 @@ static int panjit_read_data(struct usbto
>>
>>  static int mtouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
>>  {
>> -       dev->x = (pkt[8] << 8) | pkt[7];
>> -       dev->y = (pkt[10] << 8) | pkt[9];
>> +       if (hwcalib_xy) {
>> +               dev->x = (pkt[4] << 8) | pkt[3];
>> +               dev->y = 0xffff - ((pkt[6] << 8) | pkt[5]);
>> +       } else {
>> +               dev->x = (pkt[8] << 8) | pkt[7];
>> +               dev->y = (pkt[10] << 8) | pkt[9];
>> +       }
>>        dev->touch = (pkt[2] & 0x40) ? 1 : 0;
>>
>>        return 1;
>> @@ -294,6 +303,12 @@ static int mtouch_init(struct usbtouch_u
>>                        return ret;
>>        }
>>
>> +       /* Default min/max xy are the raw values, override if using hw-calib */
>> +       if (hwcalib_xy) {
>> +               input_set_abs_params(usbtouch->input, ABS_X, 0, 0xffff, 0, 0);
>> +               input_set_abs_params(usbtouch->input, ABS_Y, 0, 0xffff, 0, 0);
>> +       }
>> +
>>        return 0;
>>  }
>>  #endif
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
