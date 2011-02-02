From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: 2.6.36/2.6.37: broken compatibility with userspace input-utils
 ?
Date: Wed, 02 Feb 2011 15:00:23 -0500
Message-ID: <4D49B7D7.9020003@canonical.com>
References: <4D3C5F73.2050408@teksavvy.com> <4D496AAC.1010106@canonical.com> <20110202165800.GB3178@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34007 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab1BBUAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 15:00:30 -0500
In-Reply-To: <20110202165800.GB3178@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, kraxel@redhat.com

On 02/02/2011 11:58 AM, Dmitry Torokhov wrote:
> On Wed, Feb 02, 2011 at 09:31:08AM -0500, Chase Douglas wrote:
>> On 01/23/2011 12:03 PM, Mark Lord wrote:
>>> As of the 2.6.36 kernel, the userspace commands lsinput and input-kbd
>>> no longer work.  And if I grab newer/patched versions of those from the latest
>>> Ubuntu 10.10, then those newer/patched versions do not work with kernels
>>> *before* 2.6.36.
>>
>> I planned on taking another look at this before we release Ubuntu 11.04
>> at the end of April. That doesn't prevent someone else from helping out
>> :), but I'll make sure the utility is working again if not.
>>
> 
> Here you go:
> 
> From dbe48c8044987da6e64036fa3f36d7b2826994d5 Mon Sep 17 00:00:00 2001
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date: Mon, 24 Jan 2011 22:06:10 -0800
> Subject: [PATCH 1/2] Do not require exact version of EVDEV protocol, we can work with
>  other versions too.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yeah that's the easy part :). I need to find time to go through the
packaging and bug handling churn...

Thanks,

-- Chase
