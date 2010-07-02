From: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Fri, 2 Jul 2010 09:19:59 -0700
Message-ID: <AANLkTin8sNV75wRTM8au0Nad-zp2R0ugMdVpJiah31Di@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTimb_xMYTZYAm51lmHEkYvrvegwbmkUyJldxYA-f@mail.gmail.com>
	<16645BD8-07BB-4189-8A69-18E5EC76E670@signal11.us>
	<AANLkTilFyRjuP4VUmJolYhloDol5B7HsYV9d5SD8vZPo@mail.gmail.com>
	<4C2E0057.30206@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C2E0057.30206-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Xiaofan Chen <xiaofanc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

> I'm going to challenge this. I looked at the report descriptor you attached,
> and I don't think it really works the way you think it does. What it looks
> like to me is separate reports expecting separate data, not a bunch of
> reports all expecting the same data but of different lengths. What you
> describe would be fairly non-standard, IMO.
>


Sorry , i did not get what is meant by "a bunch of reports all
expecting same data
but of different lengths " . what is the meaning of this phrase "same data"  .

ya i agree if the device supports separate reports ,
theoretically each one should be there to serve separate data .
otherwise a device can define a report of max size N and all transactions
can take place with it .
but if a device support only one report of max size N
the drawback is that even to send  a very small report data (say 4-5 bytes ) ,
we have to use max size N report always , which may waste considerable
bandwidth .

Now in my case yes mostly different reports carry different data only .
as i told previously , the payload protocol is in the form  <command >
<response >.

by this i mean let say if i want to fetch ipod root folder entries
(filenames ),
i will send a command for that in a output report and device will send
root folder entries
in input reports .

so different payload commands are send over different reports only .

But again , the defining parameter that a report N should be used is
data payload len only . so if 2 payload commands have
same size , both can be send using same report ID .
and this thing is already working for me  .

> What I would suggest for the short-term is this:
> With the device you have, send data based on the HID descriptor you attached
> to the last email. I mean manually. In the case of your descriptor: if the
> report length you want to send is <= 5, use report 1; If it's <= 9, use
> report 2; if it's <= 13, use report 3; if it's <= 17, use report 4; if it's
> <= 25, use report 5, etc.
>

Yes , this approach is already working for me .
with the above mentioned approch ( <= 5 use report 1 , <=9  use report 2) and
using hidraw interface  , i am able to transact a few basic payload
commands with the device .
infact even the device is sending different payload command <Responses >
using the same < Report ID > .

May be i am wrong , due to lack of documentation regarding the
presence of different report ID ,
but i am able to transact with the device using the above mentioned
approach of sending
payload data in  a report whose size is >= data payload len .

if desired , i can send dmesg logs also depicting the same .

Thanx & Regards
Amit Nagal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
