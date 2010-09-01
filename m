From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 21/74] ST SPEAr : Added keyboard support
Date: Wed, 1 Sep 2010 11:11:57 +0530
Message-ID: <4C7DE7A5.5030805@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com> <b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com> <20100830164825.GA28186@core.coreip.homeip.net> <4C7DE35F.9080103@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:36482 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963Ab0IAFmI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 01:42:08 -0400
In-Reply-To: <4C7DE35F.9080103@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Armando VISCONTI <armando.visconti@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>

On 9/1/2010 10:53 AM, rajeev wrote:
>>> +struct spear_kbd {
>>> >> +     struct input_dev *input;
>>> >> +     void __iomem *io_base;          /* Keyboard Base Address */
>>> >> +     struct clk *clk;
>>> >> +     int *keymap;
>> > 
>> > You need a copy of keymap here so that userspace can modify it safely
>> > via EVIOCSKEYCODE.
>> > 
> We have one copy of struct spear_kbd per device structure. I think it
> will be fine if we change this structure only. And so don't need to copy
> another structure in driver.
> 

Sorry!! I wanted to say "keymap array" not "struct spear_kbd" in above explanation.

rajeev.
