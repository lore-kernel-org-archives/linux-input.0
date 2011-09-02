From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] hidraw : free list for all error in hidraw_open
Date: Fri, 02 Sep 2011 15:03:30 +0400
Message-ID: <4E60B802.7050606@ru.mvista.com>
References: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com> <CA+F9FsA=u6EtGkWO8PVfJ4voSx+=wvoFdZ_61WO6x=8WMFM0Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+F9FsA=u6EtGkWO8PVfJ4voSx+=wvoFdZ_61WO6x=8WMFM0Rg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello.

On 02-09-2011 11:27, Amit Nagal wrote:

>> In function hidraw_open (linux-3.0.3/drivers/hid/hidraw.c ) ,  struct
>> hidraw_list *list should be freed for all error conditions .

> Due to tab to space conversion by gmail ,

    Just don't use GMail.

> i have enclosed patch as attachment currently .

    Patches in attachments are not acceptable, especially when not in 
text/plain format.

> Regards
> Amit

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
