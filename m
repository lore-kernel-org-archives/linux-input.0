From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH WIP 0/6] suggested changes to gpio_buttons driver
Date: Tue, 30 Nov 2010 11:30:25 +0100
Message-ID: <4CF4D241.1090401@openwrt.org>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca> <20101130075610.GB15731@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41634 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab0K3Kab (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 05:30:31 -0500
In-Reply-To: <20101130075610.GB15731@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

Hi Dmitry,

> On Wed, Nov 24, 2010 at 04:01:34PM -0500, Ben Gardiner wrote:
>> These are just some suggested changes from the review in patch-form. I will
>> do my best to make time for reviewing and testing any future versions of the
>> patch that you submit but I will regrettably be moving to other projects 
>> for awhile. Until then I will not be able to spend much time on integration.
>>
>> With these patches applied I was able to build the da850-evm buttons and keys
>> support with minimal changes.As I said, these are just suggested changes,
>> please feel free to squash, edit or drop them as you see fit. My motivation 
>> here is that if you pickup the driver name and config symbol names as-is then
>> I will have no remaining integration to perform in the da850-evm series. I
>> hope you don't mind that I have to patch and run here.
>>
>> I look forward to your next version of the patch. 
> 
> I do like the original patch and even more so Ben changes. Could you
> tell me if the following still works for you (goes on top of Ben's)
> and if it does I'll fold everything together and queue for 2.6.38.

It works for me, however I have additional fixes on top of Ben's changes. I will
post an updated version soon.

The original driver was a part of a patch-set which adds support for a new MIPS
platform. There are a couple of patches in that series which requires this one.
It would be nice if the driver would be able to go through the MIPS tree to
avoid cross-tree dependencies.

Regards,
Gabor
