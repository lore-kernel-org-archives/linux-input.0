From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 2/2] Input/spear-keyboard: Provide thaw and poweroff routines
Date: Thu, 23 Feb 2012 17:29:55 +0530
Message-ID: <4F462A3B.30502@st.com>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com> <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com> <4F462319.9010602@ti.com> <4F462989.3000102@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:55979 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752642Ab2BWMAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 07:00:22 -0500
In-Reply-To: <4F462989.3000102@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Mirko GARDI <mirko.gardi@st.com>

On 2/23/2012 5:26 PM, Viresh Kumar wrote:
>>>> >> > -static const struct dev_pm_ops spear_kbd_pm_ops = {
>>>> >> > -	.suspend	= spear_kbd_suspend,
>>>> >> > -	.resume		= spear_kbd_resume,
>>>> >> > -};
>> > Now that you have converted to simple dev pm can you remove the #ifdef
>> > from pm.
>> > 
> I didn't get it completely. CONFIG_PM Macro's are still required.

Sorry. Got it now. Will remove it. :)

-- 
viresh
