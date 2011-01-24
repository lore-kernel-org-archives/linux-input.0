From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/3] Input: split hid-drff into general and ff parts
Date: Mon, 24 Jan 2011 18:45:07 +0300
Message-ID: <4D3D9E83.3070304@gmail.com>
References: <1295602215-6056-1-git-send-email-spbnick@gmail.com> <1295602215-6056-2-git-send-email-spbnick@gmail.com> <20110121095243.GD21842@core.coreip.homeip.net> <alpine.LNX.2.00.1101241628210.5725@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60596 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab1AXPpb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 10:45:31 -0500
Received: by eye27 with SMTP id 27so1893588eye.19
        for <linux-input@vger.kernel.org>; Mon, 24 Jan 2011 07:45:30 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101241628210.5725@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>

On 01/24/2011 06:28 PM, Jiri Kosina wrote:
> On Fri, 21 Jan 2011, Dmitry Torokhov wrote:
>> Or maybe fold them into one?
>
> Yeah, folding into one looks sane to me.
>
> Nikolai, could you please respin the patches and resend? Otherwise I have
> no objections.
Sure, that was my original idea, but I thought this way it would be less
diruptive.

Yet, I'll still have to read about Kbuild makefiles to understand completely
what Dmitry was talking about :)

Sincerely,
Nick
