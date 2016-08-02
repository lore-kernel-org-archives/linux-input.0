From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 0290/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 09:51:54 -0500
Message-ID: <f9e839e7-dcbb-00c9-eb52-45813dc864e2@ti.com>
References: <20160802105711.703-1-baolex.ni@intel.com>
 <20160802143150.GC10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965624AbcHBOzh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2016 10:55:37 -0400
In-Reply-To: <20160802143150.GC10376@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Baole Ni <baolex.ni@intel.com>
Cc: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, haibo.chen@freescale.com, andrey.gelman@compulab.co.il, javier@osg.samsung.com, chuansheng.liu@intel.com

On 08/02/2016 09:31 AM, Mark Brown wrote:
> On Tue, Aug 02, 2016 at 06:57:11PM +0800, Baole Ni wrote:
>> I find that the developers often just specified the numeric value
>> when calling a macro which is defined with a parameter for access permission.
>> As we know, these numeric value for access permission have had the corresponding macro,
>> and that using macro can improve the robustness and readability of the code,
>> thus, I suggest replacing the numeric parameter with the macro.
> 
> Please split these up and send them independently to the relevant
> maintainers with sensible subject lines - a single 1000+ patch series is
> far too large and you're CCing random people so it's hard to tell which
> patches are relevant (for example the batch I'm replying to here are for
> the input subsystem which I don't maintain so I'm not 100% sure why I'm
> being copied here).
> 
> With this sort of thing it's often best to send one series per directory
> or something similar.
> 

I would recommend just adding whatever script you used to find all of
these to patchcheck or coccinelle, then let people familiar with each
subsystem make and submit the fix-ups for each subsystem. You won't get
1000+ patches to your name, but the work still gets done and you avoid
bothering a lot of people.

(I got about several of these for files I've never touched :/)

Thanks,
Andrew
