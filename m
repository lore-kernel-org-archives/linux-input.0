From: Nazar Mokrynskyi <nazar-yn5EusZxFslygrA4Gshslw@public.gmane.org>
Subject: Re: [PATCH v2] hid: Fix boot delay for Creative SB Omni Surround 5.1
 with quirk
Date: Mon, 25 Apr 2016 17:46:14 +0300
Message-ID: <e0ac2349-9e21-92a5-3cff-8c604037c6cb@mokrynskyi.com>
References: <7b30aa00-7085-1f6f-7bad-ac19532cc611@mokrynskyi.com>
 <alpine.LNX.2.00.1604251641340.27368@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1604251641340.27368-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 25.04.16 17:42, Jiri Kosina wrote:
> On Mon, 25 Apr 2016, Nazar Mokrynskyi wrote:
>
>> Needed for v2 of the device firmware, otherwise kernel will stuck for few
>> seconds and throw "usb_submit_urb(ctrl) failed: -1" early on system boot.
>>
>> Signed-off-by: Nazar Mokrynskyi <nazar-yn5EusZxFslygrA4Gshslw@public.gmane.org>
>> ---
>> No changes, just resubmission to ensure absence of undesired line breaks
> Line breaks are OK, but still your mailer converted tabs to space, which 
> equally breaks the application process.
>
> I've fixed that up manually and applied, but please look into 
> reconfiguring your MUA for any future submissions.
>
> Thanks,
>
Thank you, I'll try to fix tabs as well for the next time.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
