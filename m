From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Wed, 16 Apr 2008 16:43:18 +0200
Message-ID: <48061086.5070804@gmail.com>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com> <1207341357-17792-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:29024 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412AbYDPOne (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 10:43:34 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2452964fgb.17
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 07:43:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jslaby@suse.cz>

On 04/16/2008 03:31 PM, Jiri Kosina wrote:
> On Fri, 4 Apr 2008, Jiri Slaby wrote:
> 
>> +menu "Special HID drivers"
>> +	depends on HID
>> +
>> +config HID_LOGITECH
>> +	tristate "Logitech"
>> +	depends on USB_HID
>> +	---help---
>> +	Support for some Logitech devices which breaks less or more
>> +	HID specification.
> 
> Hi Jiri,
> 
> I think that we want to make this default to y if USB_HID is selected, 
> right?

I think you're right here. Thanks.
