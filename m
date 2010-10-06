From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
Date: Wed, 6 Oct 2010 12:41:56 +0530
Message-ID: <4CAC213C.9080506@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com> <584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com> <20101005154737.GA19730@core.coreip.homeip.net> <4CABF3E0.8010909@st.com> <20101006061652.GA14609@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:45593 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758637Ab0JFHMl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Oct 2010 03:12:41 -0400
In-Reply-To: <20101006061652.GA14609@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipin KUMAR <vipin.kumar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, Armando VISCONTI <armando.visconti@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>

On 10/06/2010 11:46 AM, Dmitry Torokhov wrote:
> Sorry, did not look far enough in the patch and missed the separate
> allocation. But do you really want to allocate it separately? I think
> the following patch simplifies and speeds up things at the expense of
> slightly larger keymap structure.
> 
> There are also fixes for proper __devinit/__devexit markups, locking of
> open/close vs suspend/resume, keymap can be changed from userspace via
> EVIOCSKEYCODE and bunch of other changes.
> 
> Thanks.
> 
> --
> Dmitry
> 
> 
> Input: spear-kbd - assorted changes
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  arch/arm/plat-spear/include/plat/keyboard.h |    3
>  drivers/input/keyboard/spear-keyboard.c     |  311 +++++++++++++--------------
>  2 files changed, 149 insertions(+), 165 deletions(-)

Dmitry,

We are busy with other activities, and can't test it right now.
But i have reviewed it and it looks fine to me.

Acked-by: Viresh Kumar <viresh.kumar@st.com>

Please include it in input-next repo. We will test it later on.

--
viresh
