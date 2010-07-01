From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Thu, 1 Jul 2010 09:16:05 -0400
Message-ID: <16645BD8-07BB-4189-8A69-18E5EC76E670@signal11.us>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com> <4C2A1FA0.6020704@signal11.us> <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz> <AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com> <alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz> <AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com> <4C2B3E6B.7060703@signal11.us> <AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Xiaofan Chen <xiaofanc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


On Jun 30, 2010, at 12:40 PM, Amit Nagal wrote:

> Hi  ,
>
> ok i explain my requirements again .
>
>
> (1)
>
> the hid device  i am  dealing with does not tell in its payload
> protocol specifications
> how many input and output reports it will support and what will be the
> their respective size . the only thing it tells is payload data will
> be in the format
> <Report ID> <Payload > .
>
>> If you know what type of device you are talking to, then you  
>> shouldn't
>> really need to parse the descriptor in software, because you'll  
>> know what
>> the device supports, right?
>>
>
> No , this information is not available to me in advance .
> the application should parse the report descriptor currently
> and identify the no of input and output reports currently available
> along with their sizes .
>
> infact in my view , it does make sense to get <Report ID> <Report  
> Len >
> from report descriptor only , as a device protocol specification may  
> change
> for its  future releases . and no of reports may increase .
> so its better to get this information from report descriptor only sent
> by the device .

So let me see if I understand correctly (let me know yes or no on each):
1. You do not have documentation which tells what reports are  
available on the device.
2. The number and size of reports is listed in the HID descriptor,  
which you do not want to parse in userspace. You want the kernel to do  
it for you (which is a reasonable request, as modules like hiddev  
already do this kind of parsing).
3. You want to be able to support the future releases where the report  
sizes may change.


> (2)
>
> now lets consider the case for sending report to device .
>
> different output reports have different sizes .
>
> so depending upon application payload length ,
>
> i have to select which < output report ID > should be used .
>
> so hid_write should be
>
> buff[0] =  < Output Report ID having Report Len >= application  
> payload >
> buff[1....n] = <payload data > .
>
> since i need to know dynamically which output report id should be used
> i stressed the need for ioctl which can fetch  the basic information
> <Report ID ><Report Len> parsed from report descriptor send by the  
> device .
>
> i agree hidraw interface sends / receives raw events and
> this functionalty indeed is required by my application ,
> but still to send report , i need to choose report id depending
> upon application payload size .
> Also report id and report length information supported is not
> described in device protocol specs .
>

I think I'm finally getting the picture. Again, tell me yes or no on  
each:
0. You're using HID device with User-Defined data.
1. Your device has lots of reports, which all take the same type of  
data.
2. Each report differs _only_ in its length, but the data is the same.  
For example:
	1. If you want to send 5 bytes to the device, you use report 1, which  
is 5 bytes long
	2. If you want to send 10 bytes to the device, you use report 2,  
which is 10 bytes long.
	3. if you want to send 20 bytes to the device, you use report 3,  
which is 20 bytes long.
	etc.
4. You want to know dynamically, which report you need to use, based  
on the payload length, because
4a. the only difference in your reports is the payload length.

Might I ask what kind of device this is that behaves this way?


> i think hidraw interface should provide support for
> <report id > <report len > information as application needs to
> dynamically provides information
> to buff[0] = <Report ID> ( we cannot hardcode this value )
>
> (3)
>
> now lets consider the case for hid device read .
>
> the syntax is read( fd , buff , count );
>
> what i want is
>
> buff[0]  = <Input Report ID>
> buff[1...n] = <Report Payload >
>
> Yes i agree the < Report type > information is not required .
>

For a device which uses numbered reports, the input report ID is  
always returned to read(). It's already doing what you're asking for.

> as i explained previously one application payload can be split across
> multiple reports using same <Report Id >
>

read() is going to return one report per call to read(). It's not a  
stream interface. If your data is split across multiple reports,  
you'll need to stitch it back together on your end.


> so if Report ID information also comes in buff[0]
> it becomes easy to identify one application payload spilt across  
> multiple
> reports using same <Report ID>.
>

Again, it already does this, for devices which use numbered reports.


>
> (4)
>
> Regarding libusb / libhid usage ,
> the usb device i am using is a composite device
> having hid and audio interfaces .
>
> is it possible to claim audio interface from kernel space
> and hid interface from user space ?
>

Xiaofan?

Alan.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
