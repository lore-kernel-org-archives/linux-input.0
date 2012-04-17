From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] fixup! Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Tue, 17 Apr 2012 17:02:02 +0530
Message-ID: <4F8D54B2.1060104@st.com>
References: <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com> <3d33526ed060e70cdd981f990e449d46a4566278.1333339090.git.viresh.kumar@st.com> <20120405004500.GA11757@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:50396 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754265Ab2DQLdt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 07:33:49 -0400
In-Reply-To: <20120405004500.GA11757@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "swarren@nvidia.com" <swarren@nvidia.com>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "olof@lixom.net" <olof@lixom.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 4/5/2012 6:15 AM, Dmitry Torokhov wrote:
> This is the full implementation and should stay __devinit. It's the stub
> for !CONFIG_OF case that you want to mark "static inline". I'll fix it
> up.

Have you pushed these for v3.5?

-- 
viresh
