From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/4] input: Add new sun4i-keypad driver
Date: Fri, 18 Sep 2015 11:44:31 +0200
Message-ID: <20150918094431.GN4684@lukather>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
 <1442325957-10102-4-git-send-email-yassinjaffer@gmail.com>
 <20150917130520.GD4684@lukather>
 <CAJzetvvUscEgTQ0Sr-BF7D6rzN_bfWT1KikRqz+BvSV-2+TWrw@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U/fW6JBK3GqE0Htg"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBAF256XQKGQETCXKKBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJzetvvUscEgTQ0Sr-BF7D6rzN_bfWT1KikRqz+BvSV-2+TWrw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--U/fW6JBK3GqE0Htg
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Yassin,

On Fri, Sep 18, 2015 at 10:19:55AM +1000, Yassin Jaffer wrote:
> Hi Maxime
> 
> I appreciate your time and efforts .
> 
> Do you need that rate to be enforced, or is it some leftover from the
> > allwinner BSP?
> 
> 
> I've found that clock rate works fine with the default denounce and scan
> cycle.

It was not really my point. My point was do you *need* it to operate.

And so your properties were in clock cycles?

Please use a unit indenpendant of the clock rate, like seconds or Hz
(or any multiple of them).

> By the way do you have any dev board which expose the keypad pins?

I don't think I have any.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--U/fW6JBK3GqE0Htg--
