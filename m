From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: kye: Add report fixup for Genius Gx Imperator Keyboard
Date: Mon, 15 Jul 2013 09:53:12 +0200
Message-ID: <51E3AA68.2030504@redhat.com>
References: <1373633613-4947-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1307142313220.29788@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188Ab3GOHxR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 03:53:17 -0400
In-Reply-To: <alpine.LNX.2.00.1307142313220.29788@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Honza Brazdil <jbrazdil@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/14/2013 11:14 PM, Jiri Kosina wrote:
> On Fri, 12 Jul 2013, Benjamin Tissoires wrote:
> 
>> Genius Gx Imperator Keyboard presents the same problem in its report
>> descriptors than Genius Gila Gaming Mouse.
>> Use the same fixup for both.
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=928561
>>
>> Reported-and-tested-by: Honza Brazdil <jbrazdil@redhat.com>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---

> 
> Hi Benjamin,
> 
> I guess you are missing update of hid_have_special_driver[] list?
> 

Oops, thanks for spotting this. I will send a v2 ASAP.

Cheers,
Benjamin
