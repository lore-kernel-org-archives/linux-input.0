From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] Bluetooth: hidp: remove wrong send_report at init
Date: Fri, 12 Jul 2013 14:55:23 +0200
Message-ID: <51DFFCBB.3090709@redhat.com>
References: <1373550090-30379-1-git-send-email-benjamin.tissoires@redhat.com> <1373550090-30379-3-git-send-email-benjamin.tissoires@redhat.com> <20130712100923.GA2065@joana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130712100923.GA2065@joana>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/12/2013 12:09 PM, Gustavo Padovan wrote:
> Hi Benjamin,
> 
> * Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [2013-07-11 15:41:30 +0200]:
> 
>> The USB hid implementation does retrieve the reports during the start.
>> However, this implementation does not call the HID command GET_REPORT
>> (which would fetch the current status of each report), but use the
>> DATA command, which is an Output Report (so transmitting data from the
>> host to the device).
>> The Wiimote controller is already guarded against this problem in the
>> protocol, but it is not conformant to the specification to set all the
>> reports to 0 on start.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  net/bluetooth/hidp/core.c | 14 --------------
>>  1 file changed, 14 deletions(-)
> 
> Both patches have been applied to bluetooth-next. Thanks.
> 
> 	Gustavo
> 

Thanks Gustavo!

Cheers,
Benjamin
