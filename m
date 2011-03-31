From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 0/3] input/touchscreen: Synaptics RMI4 Touchscreen Driver
Date: Wed, 30 Mar 2011 19:35:09 -0700
Message-ID: <4D93E85D.6080204@synaptics.com>
References: <1301493927-30237-1-git-send-email-cheiny@synaptics.com> <20110330200238.GA9493@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:55898 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543Ab1CaCfM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2011 22:35:12 -0400
In-Reply-To: <20110330200238.GA9493@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <WManson@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On 03/30/2011 01:02 PM, Dmitry Torokhov wrote:
> Hi Chris,
>
> On Wed, Mar 30, 2011 at 07:05:24AM -0700, Christopher Heiny wrote:
>> This patch implements a driver supporting Synaptics ClearPad and other
>> touchscreens that use the RMI4 protocol, as defined here:
>>
>>      http://www.synaptics.com/sites/default/files/511-000136-01_revD.pdf
>>
>> This patch is against the v2.6.38 tag of Linus' kernel tree, commit
>> 521cb40b0c44418a4fd36dc633f575813d59a43d.  Note that previous patches
>> were against the synaptics-rmi4 branch of Dmitry Torokhov's input
>> tree.  At Dmitry's request, we have switched the base for our work
>> to v2.6.38 - this should make it easier for people to pick up and
>> test this and future patches.
>>
>
> The source as sumitted is quite "dirty" i.e. littered with multiple #if
> 0...#endif etc. Cooudl you please clean it up and resubmit so that
> unneeded details/code would not get into the way of reviiewing the
> driver?

I've done some tidy up.  Two #if 0's still exist, surrounding code that 
causes problems on some dev systems.  The remaining #if 0's have been 
removed or converted to a more conventional and compact approach that 
shouldn't interfere with understanding the code.

I've also removed a bunch of extraneous printks.

Patch to follow in a few minutes.

						Chris
