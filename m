From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] input/of_keymap: Convert kzalloc to devm_kzalloc
 derivative
Date: Mon, 26 Mar 2012 09:26:01 -0600
Message-ID: <4F708A89.4090503@wwwdotorg.org>
References: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48321 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab2CZP0F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Mar 2012 11:26:05 -0400
In-Reply-To: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: dmitry.torokhov@gmail.com, rajeev-dlh.kumar@st.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org

On 03/26/2012 03:45 AM, Viresh Kumar wrote:
> matrix_keyboard_of_fill_keymap() routines allocates memory using kzalloc()
> routine. It is freed on call to matrix_keyboard_of_free_keymap() routine.
> 
> This patch converts these kzalloc() calls to devm_kzalloc() and thus we don't
> require matrix_keyboard_of_free_keymap() anymore.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

The Tegra-related parts,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

But that said, Dmitry specifically requested that the devm_* function
not be used during initial review of this code; IIRC he preferred just
doing the explicit frees. I can't find a link right now though.
