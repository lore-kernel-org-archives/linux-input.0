From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] input_event: Provide override for sparc64
Date: Tue, 15 Jan 2019 22:19:27 +0100
Message-ID: <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com>
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181229183514.24644-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, y2038 Mailman List <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

On Sat, Dec 29, 2018 at 7:35 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:

>         struct timeval time;
>  #define input_event_sec time.tv_sec
>  #define input_event_usec time.tv_usec
>  #else
>         __kernel_ulong_t __sec;
> +#ifdef CONFIG_SPARC64
> +       unsigned int __usec;
> +#else
>         __kernel_ulong_t __usec;
> +#endif
>  #define input_event_sec  __sec
>  #define input_event_usec __usec
>  #endif

Sorry for not having looked at this earlier, I just realized that this
is a mistake
in user space: uapi headers are not allowed to reference CONFIG_* symbols,
since the headers are supposed to be configuration independent and the
CONFIG_* namespace might clash with user space identifiers.

The correct check appears to be

#if defined(__sparc__) && defined(__arch64__)

      Arnd
