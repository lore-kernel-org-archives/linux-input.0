From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] fixup! Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Thu, 5 Apr 2012 09:22:05 +0530
Message-ID: <4F7D16E5.3030303@st.com>
References: <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com> <3d33526ed060e70cdd981f990e449d46a4566278.1333339090.git.viresh.kumar@st.com> <20120405004500.GA11757@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:34674 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885Ab2DEDxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Apr 2012 23:53:34 -0400
In-Reply-To: <20120405004500.GA11757@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "swarren@nvidia.com" <swarren@nvidia.com>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "olof@lixom.net" <olof@lixom.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 4/5/2012 6:15 AM, Dmitry Torokhov wrote:
>> >  #ifdef CONFIG_OF
>> > -static struct tegra_kbc_platform_data * __devinit
>> > -tegra_kbc_dt_parse_pdata(struct device_node *np)
>> > +static inline struct tegra_kbc_platform_data * tegra_kbc_dt_parse_pdata(
>> > +		struct device_node *np)
>> >  {
> This is the full implementation and should stay __devinit. It's the stub
> for !CONFIG_OF case that you want to mark "static inline". I'll fix it
> up.

Ahh!! I can't believe i made this blunder. I exactly knew what i have to change,
and still changed the wrong line. Sorry. :(

-- 
viresh
