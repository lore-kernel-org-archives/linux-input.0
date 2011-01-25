From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Mon, 24 Jan 2011 19:32:08 -0500
Message-ID: <4D3E1A08.5060303@teksavvy.com>
References: <4D3C5F73.2050408@teksavvy.com> <20110124175456.GA17855@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:37573 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751323Ab1AYAcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 19:32:11 -0500
In-Reply-To: <20110124175456.GA17855@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On 11-01-24 12:54 PM, Dmitry Torokhov wrote:
> Hi Mark,
> 
> On Sun, Jan 23, 2011 at 12:03:47PM -0500, Mark Lord wrote:
>> As of the 2.6.36 kernel, the userspace commands lsinput and input-kbd
>> no longer work.  And if I grab newer/patched versions of those from the latest
>> Ubuntu 10.10, then those newer/patched versions do not work with kernels
>> *before* 2.6.36.
>>
>> At first glance, this looks like a visible regression.
>> Is there a version of input-utils that works with both
>> old and new kernels ?
>>
> 
> The event protocol number was updated to reflect support of large
> scancodes, unfortunately some of the utilities expected exact version
> and refuse to work with updated one.


So is there a danger of memory corruption if running a binary
that doesn't check the version number?

In other words, did the size and/or format of returned data
change for an ioctl() or something here?

If so, then that is a user-visible regression, and shouldn't happen.
One correct way to handle that, would be to create a new ioctl(),
and mark the old one as deprecated, for removal a few years later perhaps.

???

Thanks
