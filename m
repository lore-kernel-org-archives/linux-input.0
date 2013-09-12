From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 03/10] HID: sony: validate HID output report details
Date: Thu, 12 Sep 2013 16:11:47 +0200
Message-ID: <5231CBA3.3070405@redhat.com>
References: <1378929419-6269-1-git-send-email-benjamin.tissoires@redhat.com> <1378929419-6269-4-git-send-email-benjamin.tissoires@redhat.com> <CA+5PVA5LAzseeqv_OGPX57tnq+16smZRv72fZ=H_GN9BegDXcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab3ILOMB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Sep 2013 10:12:01 -0400
In-Reply-To: <CA+5PVA5LAzseeqv_OGPX57tnq+16smZRv72fZ=H_GN9BegDXcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Kees Cook <keescook@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On 12/09/13 14:39, Josh Boyer wrote:
> On Wed, Sep 11, 2013 at 3:56 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> This driver must validate the availability of the HID output report and
>> its size before it can write LED states via buzz_set_leds(). This stops
>> a heap overflow that is possible if a device provides a malicious HID
>> output report:
>>
>> [  108.171280] usb 1-1: New USB device found, idVendor=054c, idProduct=0002
>> ...
>> [  117.507877] BUG kmalloc-192 (Not tainted): Redzone overwritten
>>
>> CVE-2013-2890
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> As far as I know, this should be Cc: stable@vger.kernel.org #3.11, correct?
> 

Yep, for this one, only 3.11 is impacted.
Thanks Josh. And sorry for being to lazy to have added the proper tags :(

Cheers,
Benjamin

