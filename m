From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 1/2] ACPI / button: Add KEY_LID_CLOSE for new usage
 model
Date: Mon, 18 Jul 2016 17:51:33 +0200
Message-ID: <1468857093.6761.23.camel@hadess.net>
References: <cover.1467717304.git.lv.zheng@intel.com>
	 <4537c34e4685658b0a12830499f971c7fc3c0426.1468318558.git.lv.zheng@intel.com>
	 <CAN+gG=EcUjnDZqRZC8QfMnxyOX-sNSzBhyfgLfeAmRABiiG8+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45345 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbcGRPvk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 11:51:40 -0400
In-Reply-To: <CAN+gG=EcUjnDZqRZC8QfMnxyOX-sNSzBhyfgLfeAmRABiiG8+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, 2016-07-18 at 09:53 +0200, Benjamin Tissoires wrote:
> 
<snip>
> I don't think this is a good solution to have a kernel parameter. I
> thought the final decision were to have userspace decide which event
> was valid, and so we just need to export and emit both of events.
> 
> _If_ you export a kernel parameter, it makes sense to have a dmi
> blacklist to have a good default experience, which is what you wanted
> to avoid.
> So if you just export and use both events at the same time, you will
> have:
> - correct ACPI machines will just have an extra KEY_LID_CLOSE event
> emitted, which will not harm logind
> - wrong ACPI machines will not have their SW_LID input event updated
> because it will be kept closed. But given that logind will ignore it,
> there is no harm either
> 
> As Dmitry said, we could also have a KEY_LID_OPEN emitted for
> symmetrical purposes, but I am not entirely sure if this will confuse
> userspace or not. On the other hand, there are few users of these
> states, and we can teach them how to properly use them.
> 
> So in the end, I think you should just get rid of the kernel
> parameter, export SW_LID, KEY_LID_CLOSE, KEY_LID_OPEN in the event
> node, and only add the KEY_LID_CLOSE|OPEN events on an actual acpi
> notification.
> 
> Then a small hwdb entry set will teach logind/powerd if they need to
> ignore the SW_LID event or not.

So user-space would have its own blacklist (likely in udev through an
hwdb), instead of having it in the kernel? That seems like a fine idea
to me, and one of the first consumers, logind, would have all the
necessary data straight away.
