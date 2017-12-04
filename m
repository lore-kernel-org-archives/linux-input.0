From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/4] input: Deprecate real timestamps beyond year 2106
Date: Mon, 4 Dec 2017 15:29:01 +0100
Message-ID: <CAK8P3a1QYnRe3qYv7sTLCZ7dJMEdw=VVb+Kjv6iMCprbhj-Y7w@mail.gmail.com>
References: <20171204005545.23325-1-deepa.kernel@gmail.com> <20171204005545.23325-4-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204005545.23325-4-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 4, 2017 at 1:55 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> struct timeval is not y2038 safe.
> All usage of timeval in the kernel will be replaced by
> y2038 safe structures.
> The change is also necessary as glibc is introducing support
> for 32 bit applications to use 64 bit time_t. Without this
> change, many applications would incorrectly interpret values
> in the struct input_event.
> More details about glibc at
> https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .
>
> struct input_event maintains time for each input event.
> Real time timestamps are not ideal for input as this
> time can go backwards as noted in the patch a80b83b7b8
> by John Stultz. Hence, having the input_event.time fields
> only big enough for monotonic and boot times are
> sufficient.
>
> The change leaves the representation of struct input_event as is
> on 64 bit architectures. But uses 2 unsigned long values on 32 bit
> machines to support real timestamps until year 2106.
> This intentionally breaks the ABI on 32 bit architectures and
> compat handling on 64 bit architectures.
> This is as per maintainer's preference to introduce compile time errors
> rather than run into runtime incompatibilities.
>
> The change requires any 32 bit userspace utilities reading or writing
> from event nodes to update their reading format to match the new
> input_event. The changes to the popular libraries will be posted once
> we agree on the kernel change.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

This all looks good, I just have one small request:

> -
>  struct input_event {
> +#if __BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)
>         struct timeval time;
> +#define input_event_sec time.tv_sec
> +#define input_event_usec time.tv_usec
> +#else
> +       __kernel_ulong_t __sec;
> +       __kernel_ulong_t __usec;
> +#define input_event_sec  __sec
> +#define input_event_usec __usec
> +#endif

As we are getting closer to removing references to 'struct timeval'
from the kernel, could you rephrase that conditional to

#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)

so that we always see the second path in kernel sources?

It won't change the behavior of the patch, but it means we don't
have to patch it again soon afterwards.

I think we need to remove the 'timeval' definition from linux/time.h
since it might otherwise conflict with an incompatible user space
definition from sys/time.h, if an application includes both and gets
built with __USE_TIME_BITS64.

        Arnd
