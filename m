From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: RFC: Wacom Bluetooth HID driver, first pass
Date: Mon, 16 Mar 2009 15:00:55 +0100
Message-ID: <93531296-64B0-4D4B-A4A9-26F3D67DF579@holtmann.org>
References: <1236988799.32264.6310.camel@cookie.hadess.net> <1237200912.32264.9867.camel@cookie.hadess.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237200912.32264.9867.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mjg <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Hutterer <peter.hutterer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, zap-ez6wqqBRKvoox3rIn2DAYQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Bastien,

>> This is a first pass at a driver for the Wacom Graphire Bluetooth
>> tablet, based on work by Andrew Zabolotny[1]. It's mildly tested  
>> (eg. it
>> works in my very few tests).
>>
>> I was looking for guidance for the code itself, possibly making it
>> easier to merge in the input/tablet/wacom* drivers into it in the
>> future, as well as some explanations as to how I'm supposed to reset
>> tools, etc. so the user-space drivers (the X.org linuxwacom driver)
>> doesn't need special-casing for the device.
>>
>> Note that it requires a user-space activation to switch to Mode 2,  
>> using
>> bluetoothd (as the Bluetooth HID doesn't support  
>> hid_output_raw_event).
>> Patch at:
>> http://cvs.fedoraproject.org/viewvc/rpms/bluez/devel/bluez-activate-wacom-mode2.patch?view=markup
>
> A couple of notes:
> - the wheel action is reversed, it's a simple fix, done locally
> - hidp and the Bluetooth sub-system says it can't probe the device  
> with
> error "-14" when hid-wacom.ko isn't already loaded

what was the reason for not forcing HID to load the generic driver? I  
lost track on how HID is suppose to handle these. You could also  
introduce a phony export like we do with L2CAP to ensure it is loaded  
even if userspace isn't ready to handle this dependency.

> - I'm getting oopses in hci_conn_del() when the device goes away  
> (eg. I
> turn it off).

Try to run a net-next-2.6 or bluetooth-next-2.6 kernel. Kyle should  
have merged these patches into the latest rawhide kernel.

> I'd appreciate any help making this just a tad more stable.
>
> Any comments about the code itself?

The main parsing function looks highly complicated and could either  
use more comments or break into two.

	if ((wdata->tool = tool)) {
		input_report_key(input, tool, 1);
		need_sync = 1;
	}

Don't do the assignment in the if clause test. Did you run  
checkpatch.pl on it?

Regards

Marcel
