From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] input: Deprecate real timestamps beyond year 2106
Date: Tue, 13 Sep 2016 16:59:28 +0200
Message-ID: <295456784.VzTNlDXujm@wuerfel>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com> <1473775805-2242-4-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59048 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbcIMO7d (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:59:33 -0400
In-Reply-To: <1473775805-2242-4-git-send-email-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, y2038@lists.linaro.org

On Tuesday, September 13, 2016 7:10:04 AM CEST Deepa Dinamani wrote:
> struct timeval is not y2038 safe.
> All usage of timeval in the kernel will be replaced by
> y2038 safe structures.
> 
> struct input_event maintains time for each input event.
> Real time timestamps are not ideal for input as this
> time can go backwards as noted in the patch a80b83b7b8
> by John Stultz. Hence, having the input_event.time fields
> only big enough for monotonic and boot times are
> sufficient.
> 
> Leave the original input_event as is. This is to maintain
> backward compatibility with existing userspace interfaces
> that use input_event.
> Introduce a new replacement struct raw_input_event.
> This replaces timeval with struct input_timeval. This structure
> maintains time in __kernel_ulong_t or compat_ulong_t to allow
> for architectures to override types as in the case of x32.
> 
> The change requires any userspace utilities reading or writing
> from event nodes to update their reading format to match
> raw_input_event.The changes to the popular libraries will be
> posted along with the kernel changes.
> The driver version is also updated to reflect the change in
> event format.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Looks very nice!

Two small suggestions from my side:

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index e794f7b..1379899 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -21,7 +21,23 @@
>  /*
>   * The event structure itself
>   */
> +struct input_timeval {
> +	__kernel_ulong_t tv_sec;
> +	__kernel_ulong_t tv_usec;
> +};
> +
> +struct raw_input_event {
> +	struct input_timeval time;
> +	__u16 type;
> +	__u16 code;
> +	__s32 value;
> +};

Maybe a comment here that this is intentionally "unsigned" so we
can count until 2106 instead of 2038.

> +/* Userspace structure.
> + * Definition maintained here for userspace that is not yet updated to use
> + * struct raw_input_event.
> + * Not to be used anywhere within the kernel.
> + */
>  struct input_event {
>  	struct timeval time;
>  	__u16 type;
> @@ -29,11 +45,32 @@ struct input_event {
>  	__s32 value;
>  };
>  
> +static inline void
> +raw_input_to_input_event(struct raw_input_event *raw, struct input_event *ev)
> +{
> +	ev->time.tv_sec = raw->time.tv_sec;
> +	ev->time.tv_usec = raw->time.tv_usec;
> +	ev->type = raw->type;
> +	ev->code = raw->code;
> +	ev->value = raw->value;
> +}
> +
> +static inline void
> +input_to_raw_event(struct input_event *ev, struct raw_input_event *raw)
> +{
> +	raw->time.tv_sec = ev->time.tv_sec;
> +	raw->time.tv_usec = ev->time.tv_usec;
> +	raw->type = ev->type;
> +	raw->code = ev->code;
> +	raw->value = ev->value;
> +}

Here, an "#ifndef __KERNEL__" guard might help to enforce what you
write in the comment.

	Arnd

