From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tegra-kbc: Fix: Allocate pdata before using it
Date: Mon, 26 Mar 2012 23:55:02 -0700
Message-ID: <20120327065502.GA1521@core.coreip.homeip.net>
References: <28d8716b43c5078b238638ba60a4b170807074b9.1332827588.git.viresh.kumar@st.com>
 <20120327064725.GA1361@core.coreip.homeip.net>
 <4F7162C0.30801@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62604 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2C0GzI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 02:55:08 -0400
Received: by yhmm54 with SMTP id m54so4389452yhm.19
        for <linux-input@vger.kernel.org>; Mon, 26 Mar 2012 23:55:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7162C0.30801@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: "swarren@nvidia.com" <swarren@nvidia.com>, "olof@lixom.net" <olof@lixom.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "srasal@nvidia.com" <srasal@nvidia.com>

On Tue, Mar 27, 2012 at 12:18:32PM +0530, Viresh Kumar wrote:
> On 3/27/2012 12:17 PM, Dmitry Torokhov wrote:
> > On Tue, Mar 27, 2012 at 11:24:49AM +0530, Viresh Kumar wrote:
> >> > Following commit broke DT support for tegra-kbc by removing pdata allocation
> >> > completely.
> > Must be my fat fingers, sorry about this.
> 
> No, it was Shridhar's. :)

Nope, they were really mine :) I reworked Shridhar's patch and
accidentally deleted memory allocation.

I'll queue your patch ASAP.

Thanks.

-- 
Dmitry
