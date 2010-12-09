From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] HID: magicmouse: Don't report REL_{X,Y} for Magic Trackpad
Date: Thu, 09 Dec 2010 07:13:27 -0800
Message-ID: <4D00F217.6050609@canonical.com>
References: <1291849685-2623-1-git-send-email-chase.douglas@canonical.com> <alpine.LNX.2.00.1012091440410.508@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39197 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0LIPNe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Dec 2010 10:13:34 -0500
In-Reply-To: <alpine.LNX.2.00.1012091440410.508@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/09/2010 05:41 AM, Jiri Kosina wrote:
> On Wed, 8 Dec 2010, Chase Douglas wrote:
> 
>> With the recent switch to having the hid layer handle standard axis
>> initialization, the Magic Trackpad now reports relative axes. This would
>> be fine in the normal mode, but the driver puts the device in multitouch
>> mode where no relative events are generated. Also, userspace software
>> depends on accurate axis information for device type detection. Thus,
>> ignoring the relative axes from the Magic Trackpad is best.
> 
> Applied, thank you. I take it this should better go into .37 still, right?

Yes, please.

Thanks,

-- Chase
