From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/2] Input/spear-keyboard: Provide thaw and poweroff routines
Date: Thu, 23 Feb 2012 16:59:29 +0530
Message-ID: <4F462319.9010602@ti.com>
References: <c65186b4c05cca4b233a56630a87b7e7c94ccc9d.1329990021.git.viresh.kumar@st.com> <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:41880 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753438Ab2BWL3j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 06:29:39 -0500
Received: by mail-yx0-f178.google.com with SMTP id m12so491352yen.9
        for <linux-input@vger.kernel.org>; Thu, 23 Feb 2012 03:29:38 -0800 (PST)
In-Reply-To: <94d1fcbd230297361d8137e06fdb5d4e2b741529.1329990021.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com

On Thursday 23 February 2012 03:10 PM, Viresh Kumar wrote:
> Thaw and poweroff routines are missing for spear-keyboard. They are required for:
> - Error case scenarios during freeze
> - Using test features, of hibernate.
Not a comment doubt

When is thaw called and when is power off called?
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/input/keyboard/spear-keyboard.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
> index 6eb2dd8..6e83828 100644
> --- a/drivers/input/keyboard/spear-keyboard.c
> +++ b/drivers/input/keyboard/spear-keyboard.c
> @@ -321,10 +321,7 @@ static int spear_kbd_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops spear_kbd_pm_ops = {
> -	.suspend	= spear_kbd_suspend,
> -	.resume		= spear_kbd_resume,
> -};
Now that you have converted to simple dev pm can you remove the #ifdef
from pm.

> +static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
>  #endif
>  
>  static struct platform_driver spear_kbd_driver = {

