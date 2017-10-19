From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] media: input: Convert timers to use timer_setup()
Date: Thu, 19 Oct 2017 15:45:38 -0700
Message-ID: <CAGXu5j+sV7PyOE4Zr-osWFmXZBU-i3A2pd4gQUpZiZYhP9d11w@mail.gmail.com>
References: <20171016231443.GA100011@beast> <20171019223246.2wsgr6in7oigq6da@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20171019223246.2wsgr6in7oigq6da@dtor-ws>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Geliang Tang <geliangtang@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 19, 2017 at 3:32 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Oct 16, 2017 at 04:14:43PM -0700, Kees Cook wrote:
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly.
>>
>> One input_dev user hijacks the input_dev software autorepeat timer to
>> perform its own repeat management. However, there is no path back to the
>> existing status variable, so add a generic one to the input structure and
>> use that instead.
>
> That is too bad and it should not be doing this. I'd rather av7110 used
> its own private timer for that.

Yeah, that was a pretty weird case. I couldn't see how to avoid it,
though. I didn't see a way to hook the autorepeat, but I'm not too
familiar with the code here.

(I am finding such bizarre stuff with this refactoring...)

-Kees

-- 
Kees Cook
Pixel Security
