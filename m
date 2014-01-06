From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [patch 3/3] HID: multitouch: add support of other generic collections
 in hid-mt
Date: Mon, 06 Jan 2014 11:47:21 -0500
Message-ID: <52CADE19.9010607@redhat.com>
References: <1387470191-9725-1-git-send-email-benjamin.tissoires@redhat.com> <1387470191-9725-4-git-send-email-benjamin.tissoires@redhat.com> <52B5F96D.9050400@euromail.se> <alpine.LNX.2.00.1401031056000.14951@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40941 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779AbaAFQri (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jan 2014 11:47:38 -0500
In-Reply-To: <alpine.LNX.2.00.1401031056000.14951@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Edel Maks <edelmaks@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/01/14 04:56, Jiri Kosina wrote:
> On Sat, 21 Dec 2013, Henrik Rydberg wrote:
> 
>>> The ANTEC Touch Pad is a device which can switch from a multitouch
>>> touchpad to a mouse. It thus presents several generic collections which
>>> are currently ignored by hid-multitouch. Enable them by using the generic
>>> protocol. Adding also a suffix for them depending on their application.
>>
>> In what way does this and the preceeding patches differ from "else if (is_pen ||
>> export_all_inputs)"? Adding a functional pattern which then is converted to a
>> generic case, such that the usual branching is bound to occur anyways, seems
>> unnecessary.
> 
> Benjamin,
> 
> did you have chance to do any followup work on this?
> 
> If this is to go into 3.14, it's the time to have the thing finalized.
> 

Hi Jiri,

well, I'm still not sure what to answer to address Henrik's comments. I
will work on that later in the week I think, but currently I am focusing
on hid-logitech-dj and others, which is rather time consuming.

I think Maks is fine with the current status (he still have to use a
backport due to an arm platform), so let's skip this for 3.15.

Cheers,
Benjamin

