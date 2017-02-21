From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 13:16:20 -0800
Message-ID: <9a85e1ef-59c0-3017-910b-d5e9de3fd4c5@synaptics.com>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm>
 <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com>
 <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com>
 <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com>
 <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:27640 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdBUVQV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 16:16:21 -0500
In-Reply-To: <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On 02/21/2017 06:17 AM, Jiri Kosina wrote:
> On Mon, 20 Feb 2017, Linus Torvalds wrote:
>
>>> I'll have a more specific commit (or range) soon.
>> Hmm. It's commit 279967a65b32 ("HID: rmi: Handle all Synaptics
>> touchpads using hid-rmi").
>>
>> And the reason seems to be stupid: I don't have RMI enabled at all,
>> because that didn't use to work or make a difference.
>>
>> Maybe that "let's use RMI" code should depend on RMI actually being
>> enabled? Because as-is, that code now breaks existing configurations.
> I agree; that's in line with what we usually try to stick to (force
> specific drivers if the device doesn't work with the generic at all and
> switch over to generic in compile-time for devices that have limited
> functionality with the generic driver).
>
> Andrew, Benjamin, how about the patch below?
>

I tested this patch and hid-core now correctly binds hid-mulitouch to 
the touchpad if CONFIG_HID_RMI is disabled. Sorry, about the oversight.

Tested-by: Andrew Duggan <aduggan@synaptics.com>

Thanks,
Andrew

>
>
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is not built
>
> Commit 279967a65b32 ("HID: rmi: Handle all Synaptics touchpads using hid-rmi")
> unconditionally switches over handling of all Synaptics touchpads to hid-rmi
> (to make use of extended features of the HW); in case CONFIG_HID_RMI is
> disabled though this renders the touchpad unusable, as the
>
> 	HID_DEVICE(HID_BUS_ANY, HID_GROUP_RMI, HID_ANY_ID, HID_ANY_ID)
>
> match doesn't exist and generic/multitouch doesn't bind to it either (due
> to hid group mismatch).
>
> Fix this by switching over to hid-rmi only if it has been actually built.
>
> Fixes: 279967a65b32 ("HID: rmi: Handle all Synaptics touchpads using hid-rmi")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>   drivers/hid/hid-core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 538ff697a4cf..e9e87d337446 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -827,7 +827,8 @@ static int hid_scan_report(struct hid_device *hid)
>   				 * hid-rmi should take care of them,
>   				 * not hid-generic
>   				 */
> -				hid->group = HID_GROUP_RMI;
> +				if (IS_ENABLED(CONFIG_HID_RMI))
> +					hid->group = HID_GROUP_RMI;
>   		break;
>   	}
>   
>

