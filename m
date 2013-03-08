From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] HID: holtek: Holtek devices depends on USB_HID
Date: Fri, 08 Mar 2013 13:10:33 -0800
Message-ID: <513A53C9.6020606@infradead.org>
References: <1362649709-9608-1-git-send-email-benjamin.tissoires@redhat.com> <513A4FA2.6070309@infradead.org> <alpine.LNX.2.00.1303082159140.19460@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36663 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab3CHVKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Mar 2013 16:10:10 -0500
In-Reply-To: <alpine.LNX.2.00.1303082159140.19460@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/08/13 13:00, Jiri Kosina wrote:
> On Fri, 8 Mar 2013, Randy Dunlap wrote:
> 
>>> In the HID drivers tranport cleanup series, I removed the dependency
>>> between hid-holtek and usbhid. This was wrong as hid-holtek.c relies
>>> extensively on usb calls.
>>>
>>> This fixes compilation error when CONFIG_USB_SUPPORT is not enabled.
>>>
>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>>
>> but hid-multitouch build still fails (on 3.9-rc1) when USB_SUPPORT is not enabled:
> 
> Are you sure about 3.9-rc1? It has USB_HID dependency for HID_MUTLTIOUCH, 
> hence that shouldn't be a problem.

You are correct.  I was testing 3.9-rc1 + mmotm, where the latter contains
some incorrect HID patches (from linux-next).

Thanks.

> There used to be a problem in linux-next, but that should be fixed by 
> 4ba25d3f87 ("HID: multitouch: remove last usb dependency"), which I have 
> pushed out yesterday.
> 


-- 
~Randy
