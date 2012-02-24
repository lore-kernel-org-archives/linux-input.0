From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input/spear-keyboard: Fix for balancing the
 enable_irq_wake in Power Mgmt
Date: Fri, 24 Feb 2012 00:34:09 -0800
Message-ID: <20120224083409.GD18291@core.coreip.homeip.net>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49515 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab2BXIeP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 03:34:15 -0500
Received: by pbcun15 with SMTP id un15so2398828pbc.19
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2012 00:34:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

On Thu, Feb 23, 2012 at 03:10:51PM +0530, Viresh Kumar wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
> 
> This patch handles the fix for unbalanced irq for the cases when
> enable_irq_wake fails, and a warning related to same is displayed
> on the console. The workaround is handled at the driver level.

So why is the device marked as wakeup capable?

Thanks.

-- 
Dmitry
