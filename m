From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/2] include: dt-binding: input: create a DT header defining
 key codes.
Date: Thu, 8 Aug 2013 22:41:20 +0530
Message-ID: <5203D138.4030107@nvidia.com>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com> <52014E50.6030508@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9459 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab3HHQ52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Aug 2013 12:57:28 -0400
In-Reply-To: <52014E50.6030508@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@nvidia.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ian.campbell@citrix.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>

On Wednesday 07 August 2013 12:58 AM, Stephen Warren wrote:
> (CC'ing DT bindings maintainers too, hence quoting a bit of the patch)
>
> On 08/06/2013 08:12 AM, Laxman Dewangan wrote:
>> Many of Key device tree bindings uses the constant number as key code
>> which matches with kernel header key code and then comment as follows
>> for reference/better readability:
>> 	linux,code = <102>; /* KEY_HOME */
>>
>> Create a DT header which defines all the key code so that DT key bindings
>> can use it as follows:
>> 	linux,code = <KEY_HOME>;
> This looks fine to me.
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>
> A comment in support of the patch: This is adding OS-specific content to
> the DT. However, the bindings this header file supports are already
> written that way. There's not really any alternative here, since some
> numbering scheme had to be chosen for keycodes, and it may as well be
> the same set as the first/primary OS that'll use the binding.
>
> As far as merging it, this patch should probably go through the core DT
> tree, perhaps in a topic branch so that e.g. Tegra an MVEBU can merge it
> in to apply your subsequent patches (or we can just wait until the next
> kernel release to merge them in).

Do I need to include anyone for this patch to be applied or can go 
through Dmitry's input git branch?

