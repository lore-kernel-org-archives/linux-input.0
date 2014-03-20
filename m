From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add support for Win 8.1 multitouch touchpads
Date: Thu, 20 Mar 2014 13:36:38 -0400
Message-ID: <CAN+gG=HtEpKi-bjf-Aq7+Ko8MFnyXyfgL72D3pYo0NE9ZdWBsA@mail.gmail.com>
References: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
	<alpine.LNX.2.00.1403201002260.3690@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44940 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933061AbaCTRgj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2014 13:36:39 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so867634lbd.15
        for <linux-input@vger.kernel.org>; Thu, 20 Mar 2014 10:36:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1403201002260.3690@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Derya <derya.kiran@yahoo.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Thu, Mar 20, 2014 at 5:02 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 19 Mar 2014, Andrew Duggan wrote:
>
>> Multitouch touchpads built for Win 8.1 need to be sent an input mode feature report
>> in order to start reporting multitouch events. This is the same process sent
>> to Win 7 multitouch touchscreens except the value of the feature report is 3 for
>> touchpads.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Applied, thanks.

Thanks Jiri.

Derya, can you test if this also solves the problem with the Surface 2
touch cover?
(if you remove the special vendor handling in hid_scan_report)

Cheers,
Benjamin
