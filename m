From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v8 4/6] input: misc: Add ABI docs for AXP20x PEK
Date: Fri, 16 Jan 2015 09:01:05 +0800
Message-ID: <CAGb2v65ZNvAZEE7K9Wsiv5vHO4NO3QjT0CVnnLZyb59T2OgxOA@mail.gmail.com>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
 <1419303194-3075-5-git-send-email-wens@csie.org> <CAGb2v64AvP+niDrFU-vGGsXUoKD_kv34DqEPRFUZ0fiyeWiz9A@mail.gmail.com>
 <20150115173930.GD33214@dtor-ws>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBZOF4GSQKGQECB7TJKI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20150115173930.GD33214@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jan 16, 2015 at 1:39 AM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Chen-Yu,
>
> On Fri, Jan 16, 2015 at 12:00:31AM +0800, Chen-Yu Tsai wrote:
>> On Tue, Dec 23, 2014 at 10:53 AM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>> > From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> >
>> > Add ABI entries for the PEK found on PMU X-Powers AXP202 and AXP209.
>>
>> Hi Dmitry,
>>
>> Would it be possible to take this patch through your tree?
>
> Actually I folded it into the original patch adding the code so it's
> already there.

Sorry I didn't look deep enough. Just looked at the commit messages.

Thanks again.

ChenYu

> Thanks.
>
>>
>>
>> Thanks
>> ChenYu
>>
>> > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> > [wens-jdAy2FN1RRM@public.gmane.org: Fixed path for sysfs entries]
>> > Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> > ---
>> >  Documentation/ABI/testing/sysfs-driver-input-axp-pek | 11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-driver-input-axp-pek b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
>> > new file mode 100644
>> > index 000000000000..a5e671b9fa79
>> > --- /dev/null
>> > +++ b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
>> > @@ -0,0 +1,11 @@
>> > +What:          /sys/class/input/input(x)/device/startup
>> > +Date:          March 2014
>> > +Contact:       Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> > +Description:   Startup time in us. Board is powered on if the button is pressed
>> > +               for more than <startup_time>
>> > +
>> > +What:          /sys/class/input/input(x)/device/shutdown
>> > +Date:          March 2014
>> > +Contact:       Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> > +Description:   Shutdown time in us. Board is powered off if the button is pressed
>> > +               for more than <shutdown_time>
>> > --
>> > 2.1.4
>> >
>
> --
> Dmitry
