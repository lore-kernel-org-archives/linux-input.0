From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v5 4/8] input: misc: Add driver for
 AXP20x Power Enable Key
Date: Mon, 19 May 2014 11:39:42 +0200
Message-ID: <CAOQ7t2a=V_dO17Xg4VJUTV3W_OFCaE5Wuj15_Fox2jywjH+RPg@mail.gmail.com>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
	<1398947374-3115-5-git-send-email-carlo@caione.org>
	<20140503010604.GE4090@lukather>
	<20140519055745.GL29386@core.coreip.homeip.net>
	<CAOQ7t2bPHnjfpeqQjMsYJs--qpd1_1RvBEFXztTDgnf5yW=Yxg@mail.gmail.com>
	<20140519091553.GC4978@lee--X1>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBXVC46NQKGQEM7P5XQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140519091553.GC4978@lee--X1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, May 19, 2014 at 11:15 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Mon, 19 May 2014, Carlo Caione wrote:
>
>> On Mon, May 19, 2014 at 7:57 AM, Dmitry Torokhov
>> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Fri, May 02, 2014 at 06:06:04PM -0700, Maxime Ripard wrote:
>> >> On Thu, May 01, 2014 at 02:29:30PM +0200, Carlo Caione wrote:
>> >> > This patch add support for the Power Enable Key found on MFD AXP202 and
>> >> > AXP209. Besides the basic support for the button, the driver adds two
>> >> > entries in sysfs to configure the time delay for power on/off.
>> >> >
>> >> > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> >>
>> >> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> >
>> > Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >
>> > How are we merging it? MFD tree?
>>
>> No idea. Lee, can you help in merging it?
>> The only thing still  left out is the DT to be merged through Maxime
>> (I need to submit a v6 only for that).
>
> Yes.
>
> Weren't you in receipt of my email sent out an hour before this one?

Yes, but this email was sent before receiving yours :)

> I thought you were re-sending the test though (v6?).
>
> If you can set that, complete with all the Acks, I'd be much obliged.

Ok, no problem. I'll also fix a small compilation-warning spotted by Hans.

Thank you,

-- 
Carlo Caione
