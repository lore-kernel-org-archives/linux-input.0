From: deepaksi <deepak.sikri@st.com>
Subject: Re: [PATCH 1/2] Input/spear-keyboard: Fix for balancing the enable_irq_wake
 in Power Mgmt
Date: Fri, 24 Feb 2012 14:42:52 +0530
Message-ID: <4F475494.1090305@st.com>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com> <20120224083409.GD18291@core.coreip.homeip.net> <4F475131.6050506@st.com> <20120224090239.GC10763@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:37223 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756117Ab2BXJNS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 04:13:18 -0500
In-Reply-To: <20120224090239.GC10763@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Mirko GARDI <mirko.gardi@st.com>

On 2/24/2012 2:32 PM, Dmitry Torokhov wrote:
> On Fri, Feb 24, 2012 at 02:28:25PM +0530, deepaksi wrote:
>> Hi,
>>
>>
>> On 2/24/2012 2:04 PM, Dmitry Torokhov wrote:
>>> On Thu, Feb 23, 2012 at 03:10:51PM +0530, Viresh Kumar wrote:
>>>> From: Deepak Sikri<deepak.sikri@st.com>
>>>>
>>>> This patch handles the fix for unbalanced irq for the cases when
>>>> enable_irq_wake fails, and a warning related to same is displayed
>>>> on the console. The workaround is handled at the driver level.
>>> So why is the device marked as wakeup capable?
>> The device is capable of wake up. There are cases in which the
>> enable_irq_wake call may fail.
> In this case I'd say the proper action would be to abort suspend instead
> of continuing.

ok

>> This was specifically observed for ARM cortex architecture kernel
>> implementation for GIC (PL390).
>> The 2.6.37 kernel versions and before do not have the callbacks
>> related to function that help to set up
>> the wake up interrupts  in GIC, and enable_irq_wake returns with an
>> error code -ENXIO.
> Right, but current mainline does have it set up properly, correct? IOW
> we do not really expect enable_irq_wake() to fail if device is wakeup
> capable, correct?
>
> Thanks.
>

I agree the current mainline does have the support now. This was added 
some time back for 2.6.37.
Please do not consider this patch for the mainline.

Thanks
Deepak

