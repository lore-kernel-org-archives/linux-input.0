From: Jamie Lentin <jamie@lentin.co.uk>
Subject: Re: [REPOST] [PATCH] Add support for OQO 01+ multimedia keys (fwd)
Date: Wed, 21 Oct 2009 19:15:54 +0100 (BST)
Message-ID: <alpine.DEB.1.10.0910211911060.14996@chipmunk.wormnet.eu>
References: <alpine.DEB.1.10.0906302300290.9420@woodchuck.wormnet.eu> <20091020013859.GD24370@core.coreip.homeip.net> <alpine.DEB.2.00.0910202110360.11516@bunsen.wrottesley.wormnet.eu> <20091021044936.GA386@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chipmunk.wormnet.eu ([195.195.131.226]:51910 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbZJUSPu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2009 14:15:50 -0400
In-Reply-To: <20091021044936.GA386@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 20 Oct 2009, Dmitry Torokhov wrote:
> On Tue, Oct 20, 2009 at 09:12:38PM +0100, Jamie Lentin wrote:
>> On Mon, 19 Oct 2009, Dmitry Torokhov wrote:
>>
>>> On Tue, Jun 30, 2009 at 11:06:49PM +0100, Jamie Lentin wrote:
>>>> Apologies for reposting, but it'd be nice to get something along these
>>>> lines merged.  If there's suggestions of other things I could try, or
>>>> you'd prefer a patch to make the "up" and "down" keycodes auto-release,
>>>> please let me know.
>>>>
>>>
>>> I am sorry, I completely missed your patch and just now was going
>>> through my inbox and saw it...
>>
>> Not to worry---so long as the patch wasn't so offensive you couldn't bring
>> yourself to reply :)
>
> ;)
>
>>
>>> Could you please tell me if OQO has external PS/2 port?
>>
>> No, it has a PS/2 trackpoint and gravity mouse (easter-egg mode where the
>> firmware turns accelerometer input into mouse) built-in, but I doubt
>> they'll provide much useful info.
>>
>
> OK, I was just concerned about the scancode mangling screwing up
> external keyboard but in absence of PS/2 ports this point is moot.
>
> I rearranged the code a bit, could yo please try it out to make sure I
> did not screw it up and I will apply it.

Tried it, works fine.  Applying this would be much appreciated!

Thankyou for all your work.

>
> Thanks!
>
>
