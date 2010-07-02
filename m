From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Fri, 02 Jul 2010 11:05:59 -0400
Message-ID: <4C2E0057.30206@signal11.us>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>	<4C2A1FA0.6020704@signal11.us>	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>	<4C2B3E6B.7060703@signal11.us>	<AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f@mail.gmail.com>	<16645BD8-07BB-4189-8A69-18E5EC76E670@signal11.us> <AANLkTilFyRjuP4VUmJolYhloDol5B7HsYV9d5SD8vZPo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTilFyRjuP4VUmJolYhloDol5B7HsYV9d5SD8vZPo-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Xiaofan Chen <xiaofanc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 07/02/2010 02:46 AM, Amit Nagal wrote:
>> 1. Your device has lots of reports, which all take the same type of data.
>>      
> Yes . the device has lots of inputs and output reports .
> the report values are<command>  <  response>  only .
>
>    
>> 2. Each report differs _only_ in its length, but the data is the same. For
>> example:
>>         1. If you want to send 5 bytes to the device, you use report 1, which
>> is 5 bytes long
>>         2. If you want to send 10 bytes to the device, you use report 2,
>> which is 10 bytes long.
>>         3. if you want to send 20 bytes to the device, you use report 3,
>> which is 20 bytes long.
>>         etc.
>>      
> Yes. exactly . data  payload len is the defining parameter to
> determine the report N to use .
>    

I'm going to challenge this. I looked at the report descriptor you 
attached, and I don't think it really works the way you think it does. 
What it looks like to me is separate reports expecting separate data, 
not a bunch of reports all expecting the same data but of different 
lengths. What you describe would be fairly non-standard, IMO.

What I would suggest for the short-term is this:
With the device you have, send data based on the HID descriptor you 
attached to the last email. I mean manually. In the case of your 
descriptor: if the report length you want to send is <= 5, use report 1; 
If it's <= 9, use report 2; if it's <= 13, use report 3; if it's <= 17, 
use report 4; if it's <= 25, use report 5, etc.

This will allow you to say for sure that it works the way you think it 
does. If it does, then you're right, (and I'm wrong :) ). I'm betting 
though, that it won't, and that each report is expecting different types 
of data than all the other reports.

Does this sound like a reasonable approach to the rest of you guys?

Alan.



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
