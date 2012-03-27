From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 2/2] Input: spear-keyboard: add device tree bindings
Date: Tue, 27 Mar 2012 13:07:51 +0530
Message-ID: <4F716E4F.4050408@st.com>
References: <4aba6f2cd9f050f419660555bdb661915c1be9b1.1332826100.git.viresh.kumar@st.com> <c7944fdbb1dca61840d33c6b96fde484b1527bfc.1332826100.git.viresh.kumar@st.com> <20120327071335.GB1521@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:39806 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756939Ab2C0HjK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 03:39:10 -0400
In-Reply-To: <20120327071335.GB1521@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "swarren@nvidia.com" <swarren@nvidia.com>, "olof@lixom.net" <olof@lixom.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "sr@denx.de" <sr@denx.de>

On 3/27/2012 12:43 PM, Dmitry Torokhov wrote:
> I think the opposite order woudl make more sense - if pdata is supplied
> by the platform code then we should use it, otherwise try to see if
> there is OF data available instead. This way one can easily override OF
> data, if needed.

Okay.

Just for better understanding, why should we give more preference to pdata?

I thought, a single image with pdata can be booted with or without DT
support for keyboard. So, if we are booting without of DT for keyboard,
then use pdata, otherwise use DT data.

-- 
viresh
