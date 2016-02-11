From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v1 2/6] mfd: cros_ec: Add MKBP event support
Date: Thu, 11 Feb 2016 15:52:33 +0100
Message-ID: <56BCA031.3010702@collabora.com>
References: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1454679181-8949-3-git-send-email-tomeu.vizoso@collabora.com>
 <CAMHSBOXRvC7U_KWeg+rX3Qymaos0-3FN6AuaXT2cyP=gAN47mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMHSBOXRvC7U_KWeg+rX3Qymaos0-3FN6AuaXT2cyP=gAN47mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=c3=b2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org

On 02/05/2016 06:24 PM, Gwendal Grignou wrote:
> We should not used kmalloc when get events, these functions are called
> quite often.
> Gwendal.
> 
> On Fri, Feb 5, 2016 at 5:32 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com
> <mailto:tomeu.vizoso@collabora.com>> wrote:
> 
>     +static int cros_ec_get_host_command_version_mask(struct
>     cros_ec_device *ec_dev,
>     +       u16 cmd, u32 *mask)
>     +{
>     +       struct ec_params_get_cmd_versions *pver;
>     +       struct ec_response_get_cmd_versions *rver;
>     +       struct cros_ec_command *msg;
>     +       int ret;
>     +
>     +       msg = kmalloc(sizeof(*msg) + max(sizeof(rver), sizeof(pver)),
>     +                     GFP_KERNEL);
>     +       if (!msg)
>     +               return -ENOMEM;
> 
>  Victor's version in https://chromium-review.googlesource.com/272954
> looks cleaner: no malloc, no need to cast rver.

I agree that it looks cleaner, but how would you allocate the payload at
build time if it has to be max(sizeof(*pver), sizeof(*rver))?

>     +static int get_next_event(struct cros_ec_device *ec_dev)
>     +{
>     +       struct cros_ec_command *msg;
>     +       int ret;
>     +
>     +       msg = kmalloc(sizeof(*msg) + sizeof(ec_dev->event_data),
>     GFP_KERNEL);
>     +       if (!msg)
>     +               return -ENOMEM;
> 
> Same grip about malloc(). This function will be called very often when
> sensors are used.

Ok.

>     +static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
>     +{
>     +       struct cros_ec_command *msg;
>     +
>     +       msg = kmalloc(sizeof(*msg) + sizeof(ec_dev->event_data.data),
>     +                     GFP_KERNEL);
>     +       if (!msg)
>     +               return -ENOMEM;
> 
> Given this command will be used on every key press, it is better to
> pre-allocate data (like
> in https://chromium-review.googlesource.com/276768) and use msg on the
> stack like Victor's changes.

Ok.

Thanks,

Tomeu
