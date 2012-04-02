From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V4 Resend 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Mon, 2 Apr 2012 09:03:14 +0530
Message-ID: <4F791DFA.5030009@st.com>
References: <cover.1333009670.git.viresh.kumar@st.com> <406fb8092d6aca97a54add346a2528daefab9c8d.1333009670.git.viresh.kumar@st.com> <4F75FF4E.4040602@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:35356 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333Ab2DBDeg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Apr 2012 23:34:36 -0400
In-Reply-To: <4F75FF4E.4040602@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "sr@denx.de" <sr@denx.de>

On 3/31/2012 12:15 AM, Stephen Warren wrote:
>> > diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> ...
>> >  #else
>> > -static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
>> > -	struct platform_device *pdev)
>> > +static struct tegra_kbc_platform_data * __devinit
>> > +tegra_kbc_dt_parse_pdata(struct device_node *np)
> This one should be "inline" and not "__devinit", i.e. like it was before.
> 
>> > diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> ...
>> >  #else
>> > -static inline struct matrix_keymap_data *
>> > -matrix_keyboard_of_fill_keymap(struct device_node *np, const char *propname)
>> > +int matrix_keypad_of_build_keymap(struct input_dev *idev,
>> > +		unsigned int row_shift, const char *propname)
>> >  {
>> >  	return NULL;
>> >  }
> This one should also be "static inline".

Would send fixup/incremental patch for this.

-- 
viresh
