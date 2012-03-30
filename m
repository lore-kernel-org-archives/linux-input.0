From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V3 1/2] Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
Date: Fri, 30 Mar 2012 09:08:57 +0530
Message-ID: <4F752AD1.3060401@st.com>
References: <cover.1333009670.git.viresh.kumar@st.com> <69c5aad139fbbf4e99134c414a819e1cf3f6dd84.1333009670.git.viresh.kumar@st.com> <4F748363.6040400@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:50905 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752142Ab2C3DkT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 23:40:19 -0400
In-Reply-To: <4F748363.6040400@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, spear-devel <spear-devel@list.st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "sr@denx.de" <sr@denx.de>

On 3/29/2012 9:14 PM, Stephen Warren wrote:
>> > +	size = proplen / sizeof(u32);
>> > +	if (size > idev->keycodemax) {
>> > +		dev_err(dev, "OF: %s overflow\n", propname);
>> > +		return -EINVAL;
>> >  	}
> That is checking the number of entries in the property, not the values
> of the MATRIX_SCAN_CODE values derived from those entries. I'd say just
> remove this check. See below.
> 

Stephen,

I have added a check on return value of MATRIX_SCAN_CODE(), but
would still keep above check. Number of keys passed should
also be less than keycodemax.

-- 
viresh
