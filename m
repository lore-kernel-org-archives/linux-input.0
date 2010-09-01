From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 21/74] ST SPEAr : Added keyboard support
Date: Wed, 1 Sep 2010 12:31:24 +0530
Message-ID: <4C7DFA44.3050204@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<b62c01f06f5090775271a5f779db8508638eff15.1283161023.git.viresh.kumar@st.com>
	<20100830164825.GA28186@core.coreip.homeip.net>
	<4C7DE35F.9080103@st.com>
	<20100901063158.GF23585@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100901063158.GF23585@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pratyush ANAND <pratyush.anand@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, Armando VISCONTI <armando.visconti@st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Deepak SIKRI <deepak.sikri@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On 9/1/2010 12:01 PM, Dmitry Torokhov wrote:
>>>> +#define DECLARE_KEYMAP(name) \
>>>> > >> +int name[] = {\
>>>> > >> +     KEY(0, 0, KEY_ESC), \

[snip...]

>>>> > >> +     KEY(8, 6, KEY_KP2), \
>>>> > >> +     KEY(8, 7, KEY_KP3), \
>>>> > >> +     KEY(8, 8, KEY_KP0), \
>>>> > >> +};
>>> > >
>>> > > Hm, I'd expect this to be in particular board code, not in the header
>>> > > file.
>>> > >
>> >
>> > Currently we have support for evaluation boards only and all of them will have
>> > this structure in their board source files. In order to remove redundant code we
>> > kept it in plat/keyboard.h.
>> >
> So call it "spear_default_keymap" and put it right into the driver? And
> then allow platform code override it.
> 

Renaming is fine but I would still like to keep spear_default_keymap in
platform files instead of driver.

>>>> > >> +struct spear_kbd {
>>>> > >> +     struct input_dev *input;
>>>> > >> +     void __iomem *io_base;          /* Keyboard Base Address */
>>>> > >> +     struct clk *clk;
>>>> > >> +     int *keymap;
>>> > >
>>> > > You need a copy of keymap here so that userspace can modify it safely
>>> > > via EVIOCSKEYCODE.
>>> > >
>> >
>> > We have one copy of struct spear_kbd per device structure. I think it
>> > will be fine if we change this structure only. And so don't need to copy
>> > another structure in driver.
> Normally such platform data should be declared as 'const' and drivers
> should not modify such data. Also unbinding device from driver and
> rebinding later should restore the device into pristine state. Having a
> copy of keymap in spear_kbd allows to achieve such behavior.
> 

OK.

viresh.
