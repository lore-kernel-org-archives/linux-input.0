From: spear devel <spear.devel@st.com>
Subject: Re: [PATCH 1/2] input/of_keymap: Convert kzalloc to devm_kzalloc
 derivative
Date: Tue, 27 Mar 2012 09:48:20 +0530
Message-ID: <4F713F8C.20509@st.com>
References: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com> <4F708A89.4090503@wwwdotorg.org> <20120326155502.GA25590@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:38319 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947Ab2C0ETe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 00:19:34 -0400
In-Reply-To: <20120326155502.GA25590@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@st.com>, rajeev-dlh.kumar@st.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, viresh.linux@gmail.com, linux-input@vger.kernel.org

On 3/26/2012 9:25 PM, Dmitry Torokhov wrote:
> Actually I want to change the interface so that we could do something
> like:
> 
> 	if (pdata->keymap) {
> 		matrix_keypad_build_keymap(...)
> 	} else {
> 		error = matrix_keypad_build_of_keymap();
> 		if (error)
> 			goto blah;
> 	}

I would implement this and send V2.

--
viresh
