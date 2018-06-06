From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [RFC/PATCH] Input: make input_report_slot_state() return boolean
Date: Wed, 6 Jun 2018 16:45:43 +0200
Message-ID: <CAO-hwJ++CB6xy9jwRmBz1Gj0LjF368D8w5nYiqkObo5Xy3g84g@mail.gmail.com>
References: <20180605171604.GA221901@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605171604.GA221901@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 5, 2018 at 7:16 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Let's make input_report_slot_state() return boolean representing whether
> the contact is active or not. This will allow writing code like:
>
>         if (input_mt_report_slot_state(input, obj->mt_tool,
>                                         obj->type != RMI_2D_OBJECT_NONE) {
>
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
>                 ...
>         }
>
> instead of:
>
>         input_mt_report_slot_state(input, obj->mt_tool,
>                                    obj->type != RMI_2D_OBJECT_NONE);
>         if (obj->type != RMI_2D_OBJECT_NONE) {
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
>                 input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
>                 ...
>         }
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me as well.

In case you still need it:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redaht.com>

Cheers,
Benjamin
