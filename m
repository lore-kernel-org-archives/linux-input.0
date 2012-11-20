From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: spear-keyboard: Add clk_{un}prepare() support
Date: Tue, 20 Nov 2012 00:47:58 -0800
Message-ID: <20121120084758.GA29199@core.coreip.homeip.net>
References: <9f07bb7dbf29978970d901bbe89add0a333cc925.1352381962.git.viresh.kumar@linaro.org>
 <27d9eea3815593df228c85958096bc14d7985e7e.1352381962.git.viresh.kumar@linaro.org>
 <CAKohpomky4s0OBYtQhDTZc9OeSo6w_mN9uAqUXpukqR1icvKPA@mail.gmail.com>
 <CAKohpoknJqMzro4gbTH+Rh=T2Bc9ZOVmDbYZsqC4Fjq2Sqsszg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44146 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab2KTIsD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 03:48:03 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpoknJqMzro4gbTH+Rh=T2Bc9ZOVmDbYZsqC4Fjq2Sqsszg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>

On Tue, Nov 20, 2012 at 01:26:29PM +0530, Viresh Kumar wrote:
> On 12 November 2012 11:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 8 November 2012 19:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
> >>
> >> clk_{un}prepare is mandatory for platforms using common clock framework. Because
> >> for SPEAr we don't do anything in clk_{un}prepare() calls, just call them ones
> >> in probe/remove.
> >>
> >> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Missed applying this one ?
> 
> This one you missed :)

No, not really, it just does not work well with devm_* patches that got
applied: on removal you unprepare clock as the very first operation and
then devm_* does the rest which is wrong order.

I am looking at adding dem_* for clocks.

Thanks.

-- 
Dmitry
