From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drivers:input:ps2 Added sunxi A20 ps2
 driver, changed makefile and Kconfig
Date: Fri, 05 Dec 2014 07:01:17 -0800
Message-ID: <63D786FF-B293-4FC1-AD71-D99515DE8E3D@gmail.com>
References: <1417647224-27950-1-git-send-email-VishnuPatekar0510@gmail.com> <12237550.afophX20rO@wuerfel>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBR4RQ6SAKGQEU2YL5CI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <12237550.afophX20rO@wuerfel>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: vishnupatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vishnupatekar <VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jdelvare-l3A5Bk7waGM@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Arnd,

On December 5, 2014 2:33:11 AM PST, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>On Thursday 04 December 2014 04:23:44 vishnupatekar wrote:
>> +
>> +struct sunxips2data {
>> +	int irq;
>> +	spinlock_t ps2_lock;
>> +	void __iomem *base_address;	/* virt address of control registers*/
>> +	struct serio *serio;		/* serio*/
>> +	struct device *dev;
>> +	struct	clk	*pclk;
>> +};
>
>As this is dynamically allocated, better embed the serio member
>directly to avoid allocating both separately.

That would be wrong - serio is refcounted and it may outlive instance of sunxips2data you embedded it into.


Thanks.

-- 
Dmitry
