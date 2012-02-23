From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 2/2] Input/spear-keyboard: Provide thaw and poweroff routines
Date: Thu, 23 Feb 2012 17:26:57 +0530
Message-ID: <4F462989.3000102@st.com>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com> <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com> <4F462319.9010602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:58338 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785Ab2BWL5V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 06:57:21 -0500
In-Reply-To: <4F462319.9010602@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Amit VIRDI <Amit.VIRDI@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Bhavna YADAV <bhavna.yadav@st.com>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>, Mirko GARDI <mirko.gardi@st.com>

On 2/23/2012 4:59 PM, Shubhrajyoti wrote:
>> > - Using test features, of hibernate.
> Not a comment doubt
> 
> When is thaw called and when is power off called?

Firstly freeze is called, after that snapshot of memory is taken
(to be saved in disk). Now, we need resume harddisk, so we get our
thaw routines called (analogous to resume). Now system is up again. Save
image to disk and call poweroff() to finally shutdown.

Refer Documentation/power/devices.txt to get complete sequence of calls.

>> > diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
>> > index 6eb2dd8..6e83828 100644
>> > --- a/drivers/input/keyboard/spear-keyboard.c
>> > +++ b/drivers/input/keyboard/spear-keyboard.c
>> > @@ -321,10 +321,7 @@ static int spear_kbd_resume(struct device *dev)
>> >  	return 0;
>> >  }
>> >  
>> > -static const struct dev_pm_ops spear_kbd_pm_ops = {
>> > -	.suspend	= spear_kbd_suspend,
>> > -	.resume		= spear_kbd_resume,
>> > -};
> Now that you have converted to simple dev pm can you remove the #ifdef
> from pm.
> 

I didn't get it completely. CONFIG_PM Macro's are still required.

-- 
viresh
