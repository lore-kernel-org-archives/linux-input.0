From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1] HID: cp2112: support i2c write-read transfers in hid-cp2112
Date: Wed, 08 Jul 2015 03:33:05 -0700
Message-ID: <559CFC61.6000303@cumulusnetworks.com>
References: <1434621340-10422-1-git-send-email-ellen@cumulusnetworks.com> <CAAj6DX03vzNHVLE2gx+zOCud-3WWUnewYCc2-z-wXKhDPHRYQg@mail.gmail.com> <alpine.LNX.2.00.1507081133350.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1507081133350.10183-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>, Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/08/2015 02:34 AM, Jiri Kosina wrote:
> On Sat, 20 Jun 2015, Antonio Borneo wrote:
>
>>> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>>> ---
>>>   drivers/hid/hid-cp2112.c |   74 ++++++++++++++++++++++++++++++++++------------
>>>   1 file changed, 55 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
>>> index 5a72819..00d062a 100644
>>> --- a/drivers/hid/hid-cp2112.c
>>> +++ b/drivers/hid/hid-cp2112.c
>>> @@ -153,6 +153,7 @@ MODULE_DEVICE_TABLE(hid, cp2112_devices);
>>>   struct cp2112_device {
>>>          struct i2c_adapter adap;
>>>          struct hid_device *hdev;
>>> +       int hwversion;
>>
>> No need for int; u8 is enough (value is copyed from buf[2] that is u8).
>> Put the new u8 field few lines below, together with the other u8, to
>> avoid extra padding.
>>
>> No need to send immediately a new version. Let's see if there is any
>> other comment and if someone can test it before me.
>
> Antonio, is there any result of your testing? I have put this patch on
> hold waiting for your word on it, but it has been ~3 weeks already.
>
> Thanks,

This patch should be applied after my other patch:
https://patchwork.ozlabs.org/patch/492842/
