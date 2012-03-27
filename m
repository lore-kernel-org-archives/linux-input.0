From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] Input: tegra-kbc: Fix: Allocate pdata before using it
Date: Tue, 27 Mar 2012 12:18:32 +0530
Message-ID: <4F7162C0.30801@st.com>
References: <28d8716b43c5078b238638ba60a4b170807074b9.1332827588.git.viresh.kumar@st.com> <20120327064725.GA1361@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:36973 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707Ab2C0Gtl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 02:49:41 -0400
In-Reply-To: <20120327064725.GA1361@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "swarren@nvidia.com" <swarren@nvidia.com>, "olof@lixom.net" <olof@lixom.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "srasal@nvidia.com" <srasal@nvidia.com>

On 3/27/2012 12:17 PM, Dmitry Torokhov wrote:
> On Tue, Mar 27, 2012 at 11:24:49AM +0530, Viresh Kumar wrote:
>> > Following commit broke DT support for tegra-kbc by removing pdata allocation
>> > completely.
> Must be my fat fingers, sorry about this.

No, it was Shridhar's. :)

-- 
viresh
