From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] Synaptics TM1217 Touchscreen Controller driver
Date: Mon, 26 Jul 2010 18:51:08 -0700
Message-ID: <4C4E3B8C.9080207@synaptics.com>
References: <20100716130926.12814.59708.stgit@localhost.localdomain>	<20100716162939.GB9232@core.coreip.homeip.net> <20100719090659.6525eade@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:43635 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0G0CAq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 22:00:46 -0400
In-Reply-To: <20100719090659.6525eade@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 07/19/2010 01:06 AM, Alan Cox wrote:
>> Is this RMI3 or RMI4 hardware? Synaptics has posted and generic-ish
>> framework for RMI4 devices so if it is RMI4 we'd need to move over to
>> it.
>
> RIM4 - when will the Synaptics patches get merged ?

We'll be submitting an updated patch in the next 24 hours.

> Moving over to use their framework providing its going to end up in
> tree soonish looks sensible enough.
