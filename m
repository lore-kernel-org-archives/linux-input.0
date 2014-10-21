From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: sun5i: Add lradc node
Date: Tue, 21 Oct 2014 22:29:51 +0200
Message-ID: <5446C23F.3040604@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com> <1413879890-7254-4-git-send-email-hdegoede@redhat.com> <20141021162159.GC8609@dtor-ws>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBR4ETORAKGQEHFI4MSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141021162159.GC8609@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 10/21/2014 06:21 PM, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Tue, Oct 21, 2014 at 10:24:49AM +0200, Hans de Goede wrote:
>> +			button@98 {
>> +				label = "Home";
>> +				linux,code = <KEY_HOME>;
>
> I do not think you really want KEY_HOME (go to the beginning of the
> line) here, KEY_HOMEPAGE or similar would suit better.

I can understand where you're coming from, but KEY_HOME is what these
keys typically send under android, and what android expects them to
send...

Not sure if that is a good argument to keep it as KEY_HOME though.

Please let me know which way you want this key to be mapped, and
I'll update it for the next version.

Regards,

Hans
