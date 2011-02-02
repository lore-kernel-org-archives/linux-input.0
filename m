From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Wed, 02 Feb 2011 16:54:50 -0500
Message-ID: <4D49D2AA.20201@teksavvy.com>
References: <4D3C5F73.2050408@teksavvy.com> <4D496AAC.1010106@canonical.com> <20110202165800.GB3178@core.coreip.homeip.net> <4D49B7D7.9020003@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:49167 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754431Ab1BBVyx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 16:54:53 -0500
In-Reply-To: <4D49B7D7.9020003@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, kraxel@redhat.com

On 11-02-02 03:00 PM, Chase Douglas wrote:
> On 02/02/2011 11:58 AM, Dmitry Torokhov wrote:
>> On Wed, Feb 02, 2011 at 09:31:08AM -0500, Chase Douglas wrote:
>>> On 01/23/2011 12:03 PM, Mark Lord wrote:
>>>> As of the 2.6.36 kernel, the userspace commands lsinput and input-kbd
>>>> no longer work.  And if I grab newer/patched versions of those from the latest
>>>> Ubuntu 10.10, then those newer/patched versions do not work with kernels
>>>> *before* 2.6.36.
>>>
>>> I planned on taking another look at this before we release Ubuntu 11.04
>>> at the end of April. That doesn't prevent someone else from helping out
>>> :), but I'll make sure the utility is working again if not.
>>>
>>
>> Here you go:

That patch was not enough for me to get input-kbd working here on Ubuntu-10.10.
It would still only let me map 10 keys of my 56(?) button remote.

I also had to hack it to ignore the read-in map->size value when writing-out
the new keymap.

Cheers
