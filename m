From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 1/3] Input: synaptics-rmi4 - add capabilities for touchpads
Date: Fri, 28 Mar 2014 11:24:43 -0700
Message-ID: <5335BE6B.2060302@synaptics.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com> <5329A9CE.1080504@redhat.com> <20140328161505.GC22658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:47909 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaC1SYo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 14:24:44 -0400
In-Reply-To: <20140328161505.GC22658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/28/2014 09:15 AM, Dmitry Torokhov wrote:
> On Wed, Mar 19, 2014 at 10:29:34AM -0400, Benjamin Tissoires wrote:
>> >Hi Chris,
>> >
>> >On 03/18/2014 09:03 PM, Christopher Heiny wrote:
>>> > >When the device is a touchpad additional capabilities need to
>>> > >be set and reported.
>>> > >
>> >
>> >We have a problem here. While this patch would have been fine in the
>> >pre-v3.8 era, it is not true anymore.
>> >However, the current branch where synaptics-rmi4 is attached is v3.4.
>> >
>> >So if you use the right API (the current one), it will not compile :(
>> >
>> >Dmitry, would it be possible to update the branch to at least v3.8
>> >to get the new input-mt API? (if the Synaptics guys are ok).
 >
> If we are getting ready to pull it into mainline (and I think we are
> for F01 and F11 support) then I think I should simply uprev to the
> latest released kernel.

That works for us.
