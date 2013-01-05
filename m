From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 4/4] input: keyboard: tegra: remove default key mapping
Date: Sat, 5 Jan 2013 12:50:50 +0530
Message-ID: <50E7D452.8030208@nvidia.com>
References: <1357297330-28878-1-git-send-email-ldewangan@nvidia.com> <1357297330-28878-5-git-send-email-ldewangan@nvidia.com> <50E7330D.2060107@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [216.228.121.35] ([216.228.121.35]:14334 "EHLO
	hqemgate04.nvidia.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab3AEHVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Jan 2013 02:21:36 -0500
In-Reply-To: <50E7330D.2060107@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On Saturday 05 January 2013 01:22 AM, Stephen Warren wrote:
> On 01/04/2013 04:02 AM, Laxman Dewangan wrote:
>> Tegra KBC driver have the default key mapping for 16x8 configuration.
>> The key mapping can be provided through platform data or through DT
>> and the mapping varies from platform to platform, hence this default
>> mapping is not so useful. Remove the default mapping to reduce the code
>> lines of the driver.
> Overall, I agree with the intent of this change, but I /think/ the
> default keymap described here actually /is/ useful for the
> Seaboard/Springbank platforms. I guess the KBC driver isn't in the
> device tree for that (or any) board yet, so removing this keymap isn't
> really a regression, but it would be nice if you could come up with a
> change to add suitable keymaps to the device tree files too.

OK, I will push the patch for enabling keys in seaboard along with the 
other changes for DT files for tegra.
