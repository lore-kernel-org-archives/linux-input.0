From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input/of_keymap: Convert kzalloc to devm_kzalloc
 derivative
Date: Mon, 26 Mar 2012 08:55:02 -0700
Message-ID: <20120326155502.GA25590@core.coreip.homeip.net>
References: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
 <4F708A89.4090503@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39359 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568Ab2CZPzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 11:55:09 -0400
Received: by pbcun15 with SMTP id un15so6129579pbc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Mar 2012 08:55:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F708A89.4090503@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@st.com>, rajeev-dlh.kumar@st.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org

On Mon, Mar 26, 2012 at 09:26:01AM -0600, Stephen Warren wrote:
> On 03/26/2012 03:45 AM, Viresh Kumar wrote:
> > matrix_keyboard_of_fill_keymap() routines allocates memory using kzalloc()
> > routine. It is freed on call to matrix_keyboard_of_free_keymap() routine.
> > 
> > This patch converts these kzalloc() calls to devm_kzalloc() and thus we don't
> > require matrix_keyboard_of_free_keymap() anymore.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> The Tegra-related parts,
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> But that said, Dmitry specifically requested that the devm_* function
> not be used during initial review of this code; IIRC he preferred just
> doing the explicit frees. I can't find a link right now though.

Right, there is no need to haul allocated memory past the building of
the "real" keymap anyway.

Actually I want to change the interface so that we could do something
like:

	if (pdata->keymap) {
		matrix_keypad_build_keymap(...)
	} else {
		error = matrix_keypad_build_of_keymap();
		if (error)
			goto blah;
	}

So that one could override OF data with plaform data if needed and no
freeing of intermediate platform-like keymap structure is requited.
Or maybe encapsulate OF parsing directly into matrix_keypad_build_keymap
if passed keymap data is NULL...

Thanks.

-- 
Dmitry
