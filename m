From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/4] input: Add new sun4i-lradc-keys driver
Date: Mon, 01 Sep 2014 15:53:53 +0200
Message-ID: <54047A71.3070207@redhat.com>
References: <1388656707-16181-1-git-send-email-hdegoede@redhat.com> <CAGb2v66VZqpHyghs5xn=RdDUVU=2PxFw5BJ-R5Xpsk-nfoDM0Q@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORB77USGQAKGQEZTNU4OA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGb2v66VZqpHyghs5xn=RdDUVU=2PxFw5BJ-R5Xpsk-nfoDM0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 09/01/2014 03:47 PM, Chen-Yu Tsai wrote:
> Hi Hans,
> 
> It seems this series didn't get any attention. Care to respin on top
> of the latest tree?
> 
> FYI, I have the series rebased on top of sunxi-next:
> https://github.com/wens/linux/commits/others/sunxi-lradc-input-v2

The problem is not it not getting attention, the problem is people were
unhappy with the dt-bindings for this. I've a pretty good idea of how
to fix up the bindings, but -ENOTIME so far. If you've a board you can
test this on and want to take a shot at fixing it up, I can get into
a little bit more detail.

Regards,

Hans
