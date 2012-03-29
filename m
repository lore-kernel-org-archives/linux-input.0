From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH V3 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Thu, 29 Mar 2012 22:01:53 +0530
Message-ID: <CAOh2x==pyOhskNE5JmmNkMZ-EdOJOmBgvQ_q+3nmOeGqd6ATjw@mail.gmail.com>
References: <cover.1333009670.git.viresh.kumar@st.com>
	<69c5aad139fbbf4e99134c414a819e1cf3f6dd84.1333009670.git.viresh.kumar@st.com>
	<4F748363.6040400@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63907 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab2C2Qbz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 12:31:55 -0400
Received: by wgbdr13 with SMTP id dr13so1726687wgb.1
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 09:31:53 -0700 (PDT)
In-Reply-To: <4F748363.6040400@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@st.com>, dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, spear-devel@list.st.com, linux-input@vger.kernel.org, sr@denx.de

On 3/29/12, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/29/2012 02:33 AM, Viresh Kumar wrote:
>> +static struct tegra_kbc_platform_data *
>> +__devinit tegra_kbc_dt_parse_pdata(struct device_node *np)
>
> I'd be tempted to keep __devinit on the first line, but not a big deal.

I need to send V4. So will do this too. :)

>> +int matrix_keypad_of_build_keymap(struct input_dev *idev,
>> +		unsigned int row_shift, const char *propname)
>
>> +	size = proplen / sizeof(u32);
>> +	if (size > idev->keycodemax) {
>> +		dev_err(dev, "OF: %s overflow\n", propname);
>> +		return -EINVAL;
>>  	}
>
> That is checking the number of entries in the property, not the values
> of the MATRIX_SCAN_CODE values derived from those entries. I'd say just
> remove this check. See below.

Absolutely correct.

--
Viresh
