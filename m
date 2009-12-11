From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Fri, 11 Dec 2009 15:24:01 +0100
Message-ID: <4B225601.3080002@canonical.com>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com>	 <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de>	 <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>	 <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>	 <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com>	 <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de>	 <4B21308F.5070304@canonical.com> <1260541128.3656.6.camel@bede>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:58861 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbZLKOX5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 09:23:57 -0500
In-Reply-To: <1260541128.3656.6.camel@bede>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tim Cole <tim.cole@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tim Cole wrote:
> On Thu, 2009-12-10 at 18:31 +0100, Stefan Bader wrote:
>> I know this is quite a long time ago now, but has there be any outcome
>> on how to handle those joysticks?
> 
> Haven't heard anything in a while... I'm really kind of frustrated,
> since this originally shook out of the attempt to fix the problem where
> tablets are detected as non-functional joysticks which is a major pain
> to me personally.  But that evidently can't be fixed until these
> joysticks report themselves properly...
> 
> -Tim

The problem moved though. For the older kernels it was the tablets that
were incorrectly detected as joysticks. But that patch of you went upstream
and now it is the one joystick model that does not work.
In our tree we reverted the patch in Jaunty, but with Karmic we have the other
behavior. So in essence, someone is always complaining. :-P

-Stefan
