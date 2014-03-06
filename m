From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
Date: Thu, 6 Mar 2014 12:32:21 +0100
Message-ID: <CAOQ7t2bs9-FSD9PGakwU4uJacjPd9Ss8Qv3wGjeeZt_igOyhrw@mail.gmail.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
	<53121151.9050804@redhat.com>
	<CAOQ7t2ae35E-eiQW4DFspdTe3H7AWGzRpw4B_1t27p0OSkX_Uw@mail.gmail.com>
	<53123507.6020607@redhat.com>
	<531782DF.6090209@redhat.com>
	<CAOQ7t2bx1u73kxQVa3AeQ-hZ9nP3GSukEdXk-jRNwbT0vUH4+A@mail.gmail.com>
	<531848E5.4050704@redhat.com>
	<CAOQ7t2aVchEe0Mtbp8KV4ZTzE_0C0BeO15S7aF4nJx6PaBno=w@mail.gmail.com>
	<5318568E.4040405@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBZNZ4GMAKGQE4554ANY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <5318568E.4040405-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens Tsai <wens-jdAy2FN1RRM@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 6, 2014 at 12:05 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> Ah, yes but that is before you added all the regulators, which are a fixed part
> of the chip. Once you get long dts bits like that having a dtsi file makes a lot
> of sense IMHO. Note that the part of the dts this was discussing is actually the part
> I did not put in the dtis, since it can vary per board :)

Oook, now it makes sense. The idea was to integrate axp20x.dtsi at a
later time, but probably I was misunderstood. Thank you for clarifying
it.
I'll put axp20x.dtsi back in v2.

Thanks,

-- 
Carlo Caione
