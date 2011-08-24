From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching
 modes
Date: Wed, 24 Aug 2011 08:13:30 -0700
Message-ID: <4E55151A.3030802@canonical.com>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com> <4E4D3CFC.7000700@canonical.com> <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com> <4E4D426F.607@canonical.com> <4E4D68B0.8000703@canonical.com> <CAA8bQNgOZTqGMZhHF0MOm25ZUD5_G0i9F=rMsCOdiD3DYAWhTw@mail.gmail.com> <alpine.LNX.2.00.1108231052220.13644@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48002 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1HXPNf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Aug 2011 11:13:35 -0400
In-Reply-To: <alpine.LNX.2.00.1108231052220.13644@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jaikumar Ganesh <jaikumarg@android.com>, linux-input@vger.kernel.org

On 08/23/2011 01:53 AM, Jiri Kosina wrote:
> On Thu, 18 Aug 2011, Jaikumar Ganesh wrote:
> 
>> I also tracked down two Apple magic trackpads - both with the same
>> Bluetooth version.
>> One which needs this patch (as it returns an invalid report id) and
>> the other which doesn't need this patch.
>> Both use the same device id.
> 
> Gotta love hardware vendors indeed.
> 
> So how about the patch below?
> 
> 
> 
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching modes, v2

                                    spelling: ^

> 
> This is basically a more generic respin of 23746a6 ("HID: magicmouse: ignore
> 'ivalid report id' while switching modes") which got reverted later by
> c3a492.
> 
> It turns out that on some configurations, this is actually still the case
> and we are not able to detect in runtime.
> 
> The device reponds with 'invalid report id' when feature report switching it
> into multitouch mode is sent to it.
> 
> This has been silently ignored before 0825411ade ("HID: bt: Wait for ACK
> on Sent Reports"), but since this commit, it propagates -EIO from the _raw
> callback .
> 
> So let the driver ignore -EIO as response to 0xd7,0x01 report, as that's
> how the device reacts in normal mode.
> 
> Sad, but following reality.
> 
> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=35022
> 
> Reported-by: Chase Douglas <chase.douglas@canonical.com>
> Reported-by: Jaikumar Ganesh <jaikumarg@android.com>
> Tested-by: Chase Douglas <chase.douglas@canonical.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Looks good to me. I tested it and it fixed things here.

Thanks!

-- Chase
