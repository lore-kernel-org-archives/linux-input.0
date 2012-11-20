From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] Input: spear-keyboard: Add clk_{un}prepare() support
Date: Tue, 20 Nov 2012 14:24:16 +0530
Message-ID: <CAKohpokQDSFHPVGkneAas+6XK09VKUQV-b0H8uqGYfXMJGyFbg@mail.gmail.com>
References: <9f07bb7dbf29978970d901bbe89add0a333cc925.1352381962.git.viresh.kumar@linaro.org>
	<27d9eea3815593df228c85958096bc14d7985e7e.1352381962.git.viresh.kumar@linaro.org>
	<CAKohpomky4s0OBYtQhDTZc9OeSo6w_mN9uAqUXpukqR1icvKPA@mail.gmail.com>
	<CAKohpoknJqMzro4gbTH+Rh=T2Bc9ZOVmDbYZsqC4Fjq2Sqsszg@mail.gmail.com>
	<20121120084758.GA29199@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121120084758.GA29199@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>
List-Id: linux-input@vger.kernel.org

On 20 November 2012 14:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> No, not really, it just does not work well with devm_* patches that got
> applied: on removal you unprepare clock as the very first operation and
> then devm_* does the rest which is wrong order.

Nice. I don't expect the order would do anything wrong, as we aren't
touching any registers between unpreparing clock and devm_ undo stuff.

> I am looking at adding dem_* for clocks.

You mean, adding devm_clk_prepare, devm_clk_enable, devm_clk_prepare_enable ?
