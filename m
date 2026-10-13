Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB788582B88
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931340; cv=pass; b=fNXmBneP1+jBf816zr/ZH8yv4b6kOfb99mix3Qfpc7Nzm0xSnc0bKjgzanjS4s/dqzbPSJ/7OkGbaG5rluUFZ4WXZichsILGVdlu8uupk6eEL+6AAWhPF4jNS29fVvWDSFFaDBdHrfb80fqlKLApVgkdX2vckUFxyIQ1lzJKVvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931340; c=relaxed/simple;
	bh=Z/I4S15ftkuItb30dQ0Y6s6zrwHnKKd3YFIMlS8Y+CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwbs5XnK7Lq70v0fEYwfR8hrabUDN1AdzAK/x+JbsAwcJp1nJ47wiFm6fXa4Y/KJpXgqr9dH0/N6vGIC7ziMELvYfE27fv7EegJ42q+DkFkmXIS4fxHpztJSvb2fi6oSsXj+PA9SeVxWXj6zB1bk9xme0rzpPEqu6gTdz2IwgD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ichhgux4; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ichhgux4"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53394bffe0fso4735171cf.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791931325; cv=none;
        d=google.com; s=arc-20260327;
        b=NHPDik1ZRSbibdXRbQO/o7aJZOW4oPmsxkely+k5bgkdw3XpCQfEb0VnMsXwAh2xQG
         6PIfhjWldGDnrmebe+ZU3KuXnxQRKncCt8OOVFcjFNnoC3LVKXb4xg5i3egHLxI8MLKw
         lSNOTBwDDnZmA8uvr1xkhb3sSokM1pS08AFWXpXxkJLPCTUrPfmMcmxy+vZix+hiNvJC
         yFyssCe0x92rNgNkDTtCPFYj1ElsK4kJWf/C3O9S6t01zLUk8sKIOVtXzHUq7ooeUNCG
         MlLexSmC6E2+QvgE6yOrzKPAC6Rwxv63g1HqqPjkqA33gC2QKCYYPEfqFH3AIzdxK293
         pYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kzcAJRxqF0EPgAzdEja8q8/BeNv70TUdDYFWH38K7FA=;
        fh=SYYi5hb7dvjXMlU8zNIKQODhe7a5Yf8nIezgRV0GH9c=;
        b=SuNJKoSaIOSl5p5gVrZa3wANKfoCvtL3/8jNhQu6VI31yi6K0H/sG+B+33adEdfoi/
         M+9VaI4/wZCg3vbGBtcBOFO5BDSJqFgLYBzu2siMB0tuniFSQIY3tEAQ4kegvoqtPXbu
         /lk+nv7t7VNjJn+7soCehDWBLuQb+B5FfIndDEpfxQOv88wFMpcR5l1CqJn0+pOPx9oM
         UliDGv9iHocCgl4W9Pb626Xhn70Ws2ewHv82JFZEP7F8t4vtyvWmtHc6cQdMbfQnPgdB
         hTgtg+nwE3bgg6nSVt5vAEd99IG2cK653jbQWMPq5JDL1tG3eK1wm8yY+LFk+jAnNtk5
         apDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791931325; x=1792536125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kzcAJRxqF0EPgAzdEja8q8/BeNv70TUdDYFWH38K7FA=;
        b=ichhgux4b02X/wk/J3gxKL3wyZurIRl6Vgo5QFdDdm5xYvAPLU8oLDRQHYE0xlN2oL
         jk2hsWBpNeZNFr7ZKUV8cz6ucjrZj11m1iDniNxv16JRkfYhb+WTiX9/ufRrhlysHq3r
         0dPcCCAcR6Ysk5X+YFw/MtblycDizCgI+PLamJeHeHaYR1P0mE/FgCoBkASsj1lWUmr8
         hemLqXQucAP96leIGZ1raBb8wF7K8mBEbLFQyYFk5vWvIPJrOfbEKJyp6u70C76CvjbM
         05rEmctySaqeXa37ldotcPzqrEUQhMNXZoDp86XgWSJFDmOO/QR1zBEZXikWQwamrUxW
         vS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931325; x=1792536125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kzcAJRxqF0EPgAzdEja8q8/BeNv70TUdDYFWH38K7FA=;
        b=kSt8g6LPVrF9foCImkVHfDgXet/AR+JxnbiQvc3HAbsKirshAgLSCk1c8MI81YbRSo
         LVKj3wbAkhWCtfhi/kAqaklXYV7uM8Xn9dUOVnWCqzJHEP4GfUDojIsDIsH7lkb7WYaI
         MUrmrwOYQkSi8VoLAbdr5KGcTcOcO8BwIA0D3Lg19fEP7DQkWuEm90XzTxjyW7aUx+CC
         IXAmxyxyKJCBLkVx0GWTLMLNuUEj1jigkDOB1CHxNrryITiiGILMRsKN5PuRrv/Z19Xo
         A8ReK2+M7j8zI8X+kM7W8gQsgys09MJRcRVqhvb8TjNohMC/T76qO26pReZTnJ8onRc7
         YeNA==
X-Gm-Message-State: AFq9FYKy09mQv4A6pLqnN6EXe6RiBgB14I2iNEfCLFLm5GcOfhwe0eNw
	BquKMqr/J2wguUk+P5IhMjDo3VtpKHEWIj/W3Ev/fTDzFcgn9KKJaEGr6zubmpgSYj0mH/js/cX
	C44E0O+YtEQVFK5UY7JL4AU4CWXF/XEk=
X-Gm-Gg: AYBFou1RA1N660Yg/nYJnTohIpKBK9esmrq8zMveYCVjAfGfPX2cYkQ0uFfrNGBf53Q
	xOOyhVjU8auqHmoi4Qo2oIKYSk2uRRVsySXsr5b1QZ7eqhgxxKqiHg1I0GgYmJZr/7pj4NKxgD3
	bygG9xEzxppBV+oc32JoY44n25cqEETWiqJZ/cFH9zsk3a3oa/UAxFtUjepq/2TwuFIdLeSAp1T
	HPdSsN8ciOvKMgME0weGeZTevm7U8Ek//4y415QrA40z84SgeIB3B6tQ7dIB+PqKw1Y6P+BUia3
	2FHv5JQDZp5A3H1xOKNIFkziGKovfGE3Jf47GNAo9ZUPDauv4ujRqnA=
X-Received: by 2002:a05:620a:618a:b0:93e:6e6a:b686 with SMTP id
 af79cd13be357-93eb966427dmr2065614185a.29.1791931325199; Tue, 13 Oct 2026
 15:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 13 Oct 2026 15:41:53 -0700
X-Gm-Features: AclHuK8uJ1P7MYe1EpAGQ9unYJ-Cr73XgNxiQ6CQTpzcAjXMamauD-hPf3hmvJM
Message-ID: <CANRwn3QGaQYUZqm2Mh56v0SgQHY8mLuG+FKCtFXjUPRpP6bpNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Input: wacom_w8001 - fix teardown order and device lifetime
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 12:25=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> In w8001_disconnect(), serio_close() was called before unregistering
> the input devices. When input_unregister_device() calls w8001_close()
> to shut down the hardware, w8001_command() fails because the serio
> port is already closed, preventing W8001_CMD_STOP from reaching the
> controller.
>
> Additionally, w8001_connect() pre-allocated both pen_dev and touch_dev
> upfront before serio_open() so w8001_interrupt() could dereference
> them unconditionally, and then freed unused input devices mid-probe
> without synchronizing with w8001_interrupt() when pen or touch was
> absent. That created a race and use-after-free hazard with
> w8001_interrupt(), as well as a double-free on the fail4 error path.
>
> Fix these issues by guarding event reporting in w8001_interrupt()
> against NULL device pointers, allocating and registering input devices
> on demand after querying capabilities, synchronizing device pointer
> publication and teardown with serio_pause_rx, and unregistering input
> devices before closing the serio port in both disconnect and probe
> error unwind paths.
>

This patch seems to be pretty complicated for a 'Fixes' and I'd feel a
lot more comfortable reviewing it if it could be broken into smaller
chunks. I know that might not be possible, but it's pretty hard to
audit all the changes here. There's nothing that sets off loud alarms,
but I think at this level of complexity the best I could do is Ack the
patch...

> Fixes: 66fd9385ee9c ("Input: wacom_w8001 - simplify w8001_remove")
> Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen device=
s into two devices")
> Reported-by: sashiko-bot@kernel.org
> Assisted-by: LLM

Just a note that current recommendations are to include the agent name
and model version in Assisted-by lines:

https://elixir.bootlin.com/linux/v7.2.9/source/Documentation/process/coding=
-assistants.rst#L39

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 341 +++++++++++++-----------
>  1 file changed, 186 insertions(+), 155 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touc=
hscreen/wacom_w8001.c
> index d8d1cdc3f09e..1c48e2775214 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -302,7 +302,8 @@ static irqreturn_t w8001_interrupt(struct serio *seri=
o,
>
>                 if (w8001->pktlen =3D=3D w8001->idx) {
>                         w8001->idx =3D 0;
> -                       if (w8001->type !=3D BTN_TOOL_PEN &&
> +                       if (w8001->touch_dev &&
> +                           w8001->type !=3D BTN_TOOL_PEN &&
>                             w8001->type !=3D BTN_TOOL_RUBBER) {
>                                 parse_single_touch(w8001->data, &coord);
>                                 report_single_touch(w8001, &coord);
> @@ -321,8 +322,10 @@ static irqreturn_t w8001_interrupt(struct serio *ser=
io,
>                         break;
>
>                 w8001->idx =3D 0;
> -               parse_pen_data(w8001->data, &coord);
> -               report_pen_events(w8001, &coord);
> +               if (w8001->pen_dev) {
> +                       parse_pen_data(w8001->data, &coord);
> +                       report_pen_events(w8001, &coord);
> +               }
>                 break;
>
>         /* control packet */
> @@ -340,7 +343,8 @@ static irqreturn_t w8001_interrupt(struct serio *seri=
o,
>         /* 2 finger touch packet */
>         case W8001_PKTLEN_TOUCH2FG - 1:
>                 w8001->idx =3D 0;
> -               parse_multi_touch(w8001);
> +               if (w8001->touch_dev)
> +                       parse_multi_touch(w8001);
>                 break;
>
>         default:
> @@ -349,7 +353,9 @@ static irqreturn_t w8001_interrupt(struct serio *seri=
o,
>                  * sends invalid data packets that are larger than
>                  * W8001_PKTLEN_TPCPEN. Let's start over again.
>                  */
> -               if (!w8001->touch_dev && w8001->idx > W8001_PKTLEN_TPCPEN=
 - 1)
> +               if (!w8001->touch_dev &&
> +                   (w8001->data[0] & W8001_TAB_MASK) !=3D W8001_TAB_BYTE=
 &&
> +                   w8001->idx > W8001_PKTLEN_TPCPEN - 1)

I'm not an expert in the w8001 protocol and don't have docs handy at
the moment. Can you explain the purpose of adding this new
W8001_TAB_BYTE check? I have a vague idea that it might have something
to do with allowing the query response packets to be processed prior
to pen/touch being initialized?

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>                         w8001->idx =3D 0;
>         }
>
> @@ -404,19 +410,6 @@ static void w8001_close(struct input_dev *dev)
>                 w8001_command(w8001, W8001_CMD_STOP, false);
>  }
>
> -static int w8001_detect(struct w8001 *w8001)
> -{
> -       int error;
> -
> -       error =3D w8001_command(w8001, W8001_CMD_STOP, false);
> -       if (error)
> -               return error;
> -
> -       msleep(250);    /* wait 250ms before querying the device */
> -
> -       return 0;
> -}
> -
>  static void w8001_append_suffix(char *dest, const char *suffix, size_t d=
est_sz)
>  {
>         size_t used =3D strnlen(dest, dest_sz);
> @@ -424,88 +417,54 @@ static void w8001_append_suffix(char *dest, const c=
har *suffix, size_t dest_sz)
>         strscpy(dest + used, suffix, dest_sz - used);
>  }
>
> -static int w8001_setup_pen(struct w8001 *w8001, char *basename,
> -                          size_t basename_sz)
> +static bool w8001_detect_pen(struct w8001 *w8001,
> +                            char *basename, size_t basename_sz,
> +                            struct w8001_coord *coord)
>  {
> -       struct input_dev *dev =3D w8001->pen_dev;
> -       struct w8001_coord coord;
>         int error;
>
> -       /* penabled? */
>         error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
>         if (error)
> -               return error;
> -
> -       __set_bit(EV_KEY, dev->evbit);
> -       __set_bit(EV_ABS, dev->evbit);
> -       __set_bit(BTN_TOUCH, dev->keybit);
> -       __set_bit(BTN_TOOL_PEN, dev->keybit);
> -       __set_bit(BTN_TOOL_RUBBER, dev->keybit);
> -       __set_bit(BTN_STYLUS, dev->keybit);
> -       __set_bit(BTN_STYLUS2, dev->keybit);
> -       __set_bit(INPUT_PROP_DIRECT, dev->propbit);
> -
> -       parse_pen_data(w8001->response, &coord);
> -       w8001->max_pen_x =3D coord.x;
> -       w8001->max_pen_y =3D coord.y;
> -
> -       input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
> -       input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
> -       input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
> -       input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
> -       input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0,=
 0);
> -       if (coord.tilt_x && coord.tilt_y) {
> -               input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0,=
 0);
> -               input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0,=
 0);
> -       }
> +               return false;
>
> +       parse_pen_data(w8001->response, coord);
> +       w8001->max_pen_x =3D coord->x;
> +       w8001->max_pen_y =3D coord->y;
>         w8001->id =3D 0x90;
>         w8001_append_suffix(basename, " Penabled", basename_sz);
>
> -       return 0;
> +       return true;
>  }
>
> -static int w8001_setup_touch(struct w8001 *w8001, char *basename,
> -                            size_t basename_sz)
> +static bool w8001_detect_touch(struct w8001 *w8001,
> +                              char *basename, size_t basename_sz,
> +                              struct w8001_touch_query *touch)
>  {
> -       struct input_dev *dev =3D w8001->touch_dev;
> -       struct w8001_touch_query touch;
>         int error;
>
> -
> -       /* Touch enabled? */
>         error =3D w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
>         if (error)
> -               return error;
> +               return false;
> +
>         /*
>          * Some non-touch devices may reply to the touch query. But their
>          * second byte is empty, which indicates touch is not supported.
>          */
>         if (!w8001->response[1])
> -               return -ENXIO;
> +               return false;
>
> -       __set_bit(EV_KEY, dev->evbit);
> -       __set_bit(EV_ABS, dev->evbit);
> -       __set_bit(BTN_TOUCH, dev->keybit);
> -       __set_bit(INPUT_PROP_DIRECT, dev->propbit);
> -
> -       parse_touchquery(w8001->response, &touch);
> -       w8001->max_touch_x =3D touch.x;
> -       w8001->max_touch_y =3D touch.y;
> +       parse_touchquery(w8001->response, touch);
> +       w8001->max_touch_x =3D touch->x;
> +       w8001->max_touch_y =3D touch->y;
>
>         if (w8001->max_pen_x && w8001->max_pen_y) {
>                 /* if pen is supported scale to pen maximum */
> -               touch.x =3D w8001->max_pen_x;
> -               touch.y =3D w8001->max_pen_y;
> -               touch.panel_res =3D W8001_PEN_RESOLUTION;
> +               touch->x =3D w8001->max_pen_x;
> +               touch->y =3D w8001->max_pen_y;
> +               touch->panel_res =3D W8001_PEN_RESOLUTION;
>         }
>
> -       input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
> -       input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
> -       input_abs_set_res(dev, ABS_X, touch.panel_res);
> -       input_abs_set_res(dev, ABS_Y, touch.panel_res);
> -
> -       switch (touch.sensor_id) {
> +       switch (touch->sensor_id) {
>         case 0:
>         case 2:
>                 w8001->pktlen =3D W8001_PKTLEN_TOUCH93;
> @@ -523,24 +482,6 @@ static int w8001_setup_touch(struct w8001 *w8001, ch=
ar *basename,
>
>         case 5:
>                 w8001->pktlen =3D W8001_PKTLEN_TOUCH2FG;
> -
> -               __set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
> -               error =3D input_mt_init_slots(dev, 2, 0);
> -               if (error) {
> -                       dev_err(&w8001->serio->dev,
> -                               "failed to initialize MT slots: %d\n", er=
ror);
> -                       return error;
> -               }
> -
> -               input_set_abs_params(dev, ABS_MT_POSITION_X,
> -                                       0, touch.x, 0, 0);
> -               input_set_abs_params(dev, ABS_MT_POSITION_Y,
> -                                       0, touch.y, 0, 0);
> -               input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
> -                                       0, MT_TOOL_MAX, 0, 0);
> -               input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res=
);
> -               input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res=
);
> -
>                 w8001_append_suffix(basename, " 2FG", basename_sz);
>                 if (w8001->max_pen_x && w8001->max_pen_y)
>                         w8001->id =3D 0xE3;
> @@ -550,13 +491,19 @@ static int w8001_setup_touch(struct w8001 *w8001, c=
har *basename,
>         }
>
>         w8001_append_suffix(basename, " Touchscreen", basename_sz);
> -
> -       return 0;
> +       return true;
>  }
>
> -static void w8001_set_devdata(struct input_dev *dev, struct w8001 *w8001=
,
> -                             struct serio *serio)
> +static struct input_dev *w8001_allocate_device(struct w8001 *w8001,
> +                                              const char *name)
>  {
> +       struct input_dev *dev;
> +
> +       dev =3D input_allocate_device();
> +       if (!dev)
> +               return NULL;
> +
> +       dev->name =3D name;
>         dev->phys =3D w8001->phys;
>         dev->id.bustype =3D BUS_RS232;
>         dev->id.product =3D w8001->id;
> @@ -565,28 +512,139 @@ static void w8001_set_devdata(struct input_dev *de=
v, struct w8001 *w8001,
>         dev->open =3D w8001_open;
>         dev->close =3D w8001_close;
>
> -       dev->dev.parent =3D &serio->dev;
> +       dev->dev.parent =3D &w8001->serio->dev;
> +
> +       __set_bit(INPUT_PROP_DIRECT, dev->propbit);
> +       input_set_capability(dev, EV_KEY, BTN_TOUCH);
>
>         input_set_drvdata(dev, w8001);
> +
> +       return dev;
> +}
> +
> +static int w8001_setup_pen(struct w8001 *w8001, const char *basename,
> +                          const struct w8001_coord *coord)
> +{
> +       struct input_dev *dev;
> +       int error;
> +
> +       snprintf(w8001->pen_name, sizeof(w8001->pen_name), "%s Pen", base=
name);
> +
> +       dev =3D w8001_allocate_device(w8001, w8001->pen_name);
> +       if (!dev)
> +               return -ENOMEM;
> +
> +       __set_bit(BTN_TOOL_PEN, dev->keybit);
> +       __set_bit(BTN_TOOL_RUBBER, dev->keybit);
> +       __set_bit(BTN_STYLUS, dev->keybit);
> +       __set_bit(BTN_STYLUS2, dev->keybit);
> +
> +       input_set_abs_params(dev, ABS_X, 0, coord->x, 0, 0);
> +       input_set_abs_params(dev, ABS_Y, 0, coord->y, 0, 0);
> +       input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
> +       input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
> +       input_set_abs_params(dev, ABS_PRESSURE, 0, coord->pen_pressure, 0=
, 0);
> +       if (coord->tilt_x && coord->tilt_y) {
> +               input_set_abs_params(dev, ABS_TILT_X, 0, coord->tilt_x, 0=
, 0);
> +               input_set_abs_params(dev, ABS_TILT_Y, 0, coord->tilt_y, 0=
, 0);
> +       }
> +
> +       scoped_guard(serio_pause_rx, w8001->serio)
> +               w8001->pen_dev =3D dev;
> +
> +       error =3D input_register_device(dev);
> +       if (error)
> +               goto err_unpublish_dev;
> +
> +       return 0;
> +
> +err_unpublish_dev:
> +       scoped_guard(serio_pause_rx, w8001->serio)
> +               w8001->pen_dev =3D NULL;
> +       input_free_device(dev);
> +       return error;
> +}
> +
> +static int w8001_setup_touch(struct w8001 *w8001, const char *basename,
> +                            const struct w8001_touch_query *touch)
> +{
> +       struct input_dev *dev;
> +       int error;
> +
> +       snprintf(w8001->touch_name, sizeof(w8001->touch_name), "%s Finger=
", basename);
> +
> +       dev =3D w8001_allocate_device(w8001, w8001->touch_name);
> +       if (!dev)
> +               return -ENOMEM;
> +
> +       input_set_abs_params(dev, ABS_X, 0, touch->x, 0, 0);
> +       input_set_abs_params(dev, ABS_Y, 0, touch->y, 0, 0);
> +       input_abs_set_res(dev, ABS_X, touch->panel_res);
> +       input_abs_set_res(dev, ABS_Y, touch->panel_res);
> +
> +       if (touch->sensor_id =3D=3D 5) {
> +               __set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
> +               error =3D input_mt_init_slots(dev, 2, 0);
> +               if (error) {
> +                       dev_err(&w8001->serio->dev,
> +                               "failed to initialize MT slots: %d\n", er=
ror);
> +                       goto err_free_dev;
> +               }
> +
> +               input_set_abs_params(dev, ABS_MT_POSITION_X, 0, touch->x,=
 0, 0);
> +               input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, touch->y,=
 0, 0);
> +               input_set_abs_params(dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MA=
X, 0, 0);
> +               input_abs_set_res(dev, ABS_MT_POSITION_X, touch->panel_re=
s);
> +               input_abs_set_res(dev, ABS_MT_POSITION_Y, touch->panel_re=
s);
> +       }
> +
> +       scoped_guard(serio_pause_rx, w8001->serio)
> +               w8001->touch_dev =3D dev;
> +
> +       error =3D input_register_device(dev);
> +       if (error)
> +               goto err_unpublish_dev;
> +
> +       return 0;
> +
> +err_unpublish_dev:
> +       scoped_guard(serio_pause_rx, w8001->serio)
> +               w8001->touch_dev =3D NULL;
> +err_free_dev:
> +       input_free_device(dev);
> +       return error;
>  }
>
>  /*
>   * w8001_disconnect() is the opposite of w8001_connect()
>   */
>
> +static void w8001_unregister_devices(struct w8001 *w8001)
> +{
> +       struct input_dev *pen_dev =3D NULL;
> +       struct input_dev *touch_dev =3D NULL;
> +
> +       scoped_guard(serio_pause_rx, w8001->serio) {
> +               swap(pen_dev, w8001->pen_dev);
> +               swap(touch_dev, w8001->touch_dev);
> +       }
> +
> +       if (pen_dev)
> +               input_unregister_device(pen_dev);
> +       if (touch_dev)
> +               input_unregister_device(touch_dev);
> +}
> +
>  static void w8001_disconnect(struct serio *serio)
>  {
>         struct w8001 *w8001 =3D serio_get_drvdata(serio);
>
> +       w8001_unregister_devices(w8001);
> +
>         serio_close(serio);
> +       serio_set_drvdata(serio, NULL);
>
> -       if (w8001->pen_dev)
> -               input_unregister_device(w8001->pen_dev);
> -       if (w8001->touch_dev)
> -               input_unregister_device(w8001->touch_dev);
>         kfree(w8001);
> -
> -       serio_set_drvdata(serio, NULL);
>  }
>
>  /*
> @@ -598,22 +656,17 @@ static void w8001_disconnect(struct serio *serio)
>  static int w8001_connect(struct serio *serio, struct serio_driver *drv)
>  {
>         struct w8001 *w8001;
> -       struct input_dev *input_dev_pen;
> -       struct input_dev *input_dev_touch;
> +       struct w8001_coord coord;
> +       struct w8001_touch_query touch;
>         char basename[64] =3D "Wacom Serial";
> -       int err, err_pen, err_touch;
> +       bool has_pen, has_touch;
> +       int err;
>
>         w8001 =3D kzalloc_obj(*w8001);
> -       input_dev_pen =3D input_allocate_device();
> -       input_dev_touch =3D input_allocate_device();
> -       if (!w8001 || !input_dev_pen || !input_dev_touch) {
> -               err =3D -ENOMEM;
> -               goto fail1;
> -       }
> +       if (!w8001)
> +               return -ENOMEM;
>
>         w8001->serio =3D serio;
> -       w8001->pen_dev =3D input_dev_pen;
> -       w8001->touch_dev =3D input_dev_touch;
>         mutex_init(&w8001->mutex);
>         init_completion(&w8001->cmd_done);
>         snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->ph=
ys);
> @@ -621,66 +674,44 @@ static int w8001_connect(struct serio *serio, struc=
t serio_driver *drv)
>         serio_set_drvdata(serio, w8001);
>         err =3D serio_open(serio, drv);
>         if (err)
> -               goto fail2;
> +               goto err_free_w8001;
>
> -       err =3D w8001_detect(w8001);
> +       err =3D w8001_command(w8001, W8001_CMD_STOP, false);
>         if (err)
> -               goto fail3;
> +               goto err_close_serio;
> +
> +       msleep(250);    /* wait 250ms before querying the device */
>
> -       /* For backwards-compatibility we compose the basename based on
> +       /*
> +        * For backwards-compatibility we compose the basename based on
>          * capabilities and then just append the tool type
>          */
> -       err_pen =3D w8001_setup_pen(w8001, basename, sizeof(basename));
> -       err_touch =3D w8001_setup_touch(w8001, basename, sizeof(basename)=
);
> -       if (err_pen && err_touch) {
> +       has_pen =3D w8001_detect_pen(w8001, basename, sizeof(basename), &=
coord);
> +       has_touch =3D w8001_detect_touch(w8001, basename, sizeof(basename=
), &touch);
> +       if (!has_pen && !has_touch) {
>                 err =3D -ENXIO;
> -               goto fail3;
> +               goto err_close_serio;
>         }
>
> -       if (!err_pen) {
> -               snprintf(w8001->pen_name, sizeof(w8001->pen_name),
> -                        "%s Pen", basename);
> -               input_dev_pen->name =3D w8001->pen_name;
> -
> -               w8001_set_devdata(input_dev_pen, w8001, serio);
> -
> -               err =3D input_register_device(w8001->pen_dev);
> +       if (has_pen) {
> +               err =3D w8001_setup_pen(w8001, basename, &coord);
>                 if (err)
> -                       goto fail3;
> -       } else {
> -               input_free_device(input_dev_pen);
> -               input_dev_pen =3D NULL;
> -               w8001->pen_dev =3D NULL;
> +                       goto err_close_serio;
>         }
>
> -       if (!err_touch) {
> -               snprintf(w8001->touch_name, sizeof(w8001->touch_name),
> -                        "%s Finger", basename);
> -               input_dev_touch->name =3D w8001->touch_name;
> -
> -               w8001_set_devdata(input_dev_touch, w8001, serio);
> -
> -               err =3D input_register_device(w8001->touch_dev);
> +       if (has_touch) {
> +               err =3D w8001_setup_touch(w8001, basename, &touch);
>                 if (err)
> -                       goto fail4;
> -       } else {
> -               input_free_device(input_dev_touch);
> -               input_dev_touch =3D NULL;
> -               w8001->touch_dev =3D NULL;
> +                       goto err_close_serio;
>         }
>
>         return 0;
>
> -fail4:
> -       if (w8001->pen_dev)
> -               input_unregister_device(w8001->pen_dev);
> -fail3:
> +err_close_serio:
> +       w8001_unregister_devices(w8001);
>         serio_close(serio);
> -fail2:
> +err_free_w8001:
>         serio_set_drvdata(serio, NULL);
> -fail1:
> -       input_free_device(input_dev_pen);
> -       input_free_device(input_dev_touch);
>         kfree(w8001);
>         return err;
>  }
> --
> 2.56.0.385.gd3acb90ef8-goog
>
>
