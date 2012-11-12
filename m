From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] Input: spear-keyboard: Add clk_{un}prepare() support
Date: Mon, 12 Nov 2012 11:27:44 +0530
Message-ID: <CAKohpomky4s0OBYtQhDTZc9OeSo6w_mN9uAqUXpukqR1icvKPA@mail.gmail.com>
References: <9f07bb7dbf29978970d901bbe89add0a333cc925.1352381962.git.viresh.kumar@linaro.org>
	<27d9eea3815593df228c85958096bc14d7985e7e.1352381962.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38534 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab2KLF5p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 00:57:45 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so4173948iag.19
        for <linux-input@vger.kernel.org>; Sun, 11 Nov 2012 21:57:45 -0800 (PST)
In-Reply-To: <27d9eea3815593df228c85958096bc14d7985e7e.1352381962.git.viresh.kumar@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 8 November 2012 19:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
>
> clk_{un}prepare is mandatory for platforms using common clock framework. Because
> for SPEAr we don't do anything in clk_{un}prepare() calls, just call them ones
> in probe/remove.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Missed applying this one ?
