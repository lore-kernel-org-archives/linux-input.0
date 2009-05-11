From: "Jussi Kivilinna" <jussi.kivilinna-E01nCVcF24I@public.gmane.org>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS
	PS2/USB adapter
Date: Mon, 11 May 2009 19:05:11 +0300
Message-ID: <20090511190511.48674pgab3lh4p0w@hayate.sektori.org>
References: <20090508074636.16912.55839.stgit@fate.lan>
	<alpine.LNX.2.00.0905111712410.22712@wotan.suse.de>
	<4A0848E7.9080301@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A0848E7.9080301-AlSwsSmVLrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Quoting "Jiri Slaby" <jslaby-AlSwsSmVLrQ@public.gmane.org>:

> On 05/11/2009 05:17 PM, Jiri Kosina wrote:
>> On Fri, 8 May 2009, Jussi Kivilinna wrote:
>>
>>> This driver adds force feedback support for SmartJoy PLUS PS2/USB
>>> adapter. I made this driver one device spesific instead of making
>>> generic 'wisegroup-ff' because I have another Wisegroup PS2/USB adapter
>>> that doesn't work same way as SmartJoy PLUS. If another device that is
>>> compatible pops up, this driver could be then renamed to something more
>>> generic.
>>
>> Thanks for writing the driver!
>>
>>> --- a/drivers/hid/hid-core.c
>>> +++ b/drivers/hid/hid-core.c
>>> @@ -1312,6 +1312,9 @@ static const struct hid_device_id hid_blacklist[] = {
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED,  
>>> USB_DEVICE_ID_TOPSEED_CYBERLINK) },
>>> +#if defined(CONFIG_SMARTJOYPLUS_FF) ||  
>>> defined(CONFIG_SMARTJOYPLUS_FF_MODULE)
>>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
>>> +#endif
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
>>
>> Hmm, this isn't really compatible with what we have for other drivers, we
>> require the config option to be turned on in order to have support (i.e.
>> we include them into hid_blacklist unconditionally).
>
> Strictly speaking, it depends on whether the device is able to be
> managed by the generic layer or not. And it seems it can; this driver
> adds only a FF support. If we disabled the FF support in the config and
> the #if macro wasn't there, we would lose the device completely even
> though it can be handled by the core, without FF though.
>

Yes, it works with generic layer. This problem exists with some other  
FF drivers as well, devices would work without FF support.

> So I think, in this particular case, it is OK to have the conditional
> line in there.
>
> Or maybe better, to not taint the core code by such a bloat, leave
> conditonal only the part of the driver which takes care of FF. The rest
> of the driver (only the init/deinit) would be left as unable-to-disable
> if !EMBEDDED, like other drivers.
>
> I mean, two Kconfig entries, driver and FF support, driver is built
> always if !EMBEDDED, FF is optional and dependent on the driver.
> CONFIG_SMARTJOYPLUS_FF is then around sjoyff_init and *_play.
>

Ok, the same way as hid-pl.c?

I think hid-gaff.c/drff.c/tmff.c should do this as well.

>
>
> Here comes some of my comments to the rest:
>
> +#define debug(format, arg...) pr_debug("hid-sjoyff: " format "\n" , ## arg)
>
> Define pr_fmt instead of this.
>
> +static int hid_sjoyff_play(struct input_dev *dev, void *data,
> +			 struct ff_effect *effect)
> +{
> +	struct hid_device *hid = input_get_drvdata(dev);
> +	struct sjoyff_device *sjoyff = data;
> +	u32 left, right;
> +
> +	left = effect->u.rumble.strong_magnitude;
> +	right = effect->u.rumble.weak_magnitude;
> +	debug("called with 0x%08x 0x%08x", left, right);
> +
> +	left = left * 0xff / 0xffff;
>
> Confused here, * ff / ffff, what's the point? Is there any difference
> with left /= 0xff?

It would actually be "left /= 0x101", and not as informative as "0xff  
/ 0xffff".

>
> Thanks for the driver.
>
>


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
