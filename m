From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix -Wunused-const-variable
Date: Thu, 13 Jun 2019 10:47:53 -0700
Message-ID: <CAKwvOdnjTxzXgPHQcC7K8N5YkTvh66sy86oorPJZc07b7UBhGw@mail.gmail.com>
References: <20190612235803.9290-1-nhuck@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612235803.9290-1-nhuck@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Huckleberry <nhuck@google.com>
Cc: nick@shmanahar.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 12, 2019 at 4:58 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Since mxt_video_fops is only used inside an ifdef. It should
> be moved inside the ifdef.

Thanks for the patch! I agree.  I think it would be better and clearer
to sink the definition of `mxt_video_fops` down closer to its use,
immediately before the definition of `mxt_video_device`.  Then it
would be closer to its use and it would also be within the existing
ifdef.

> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -256,6 +256,7 @@ enum v4l_dbg_inputs {
>         MXT_V4L_INPUT_MAX,
>  };
>
> +#ifdef CONFIG_TOUCHSCREEN_ATMEL_MXT_T37
>  static const struct v4l2_file_operations mxt_video_fops = {
>         .owner = THIS_MODULE,
>         .open = v4l2_fh_open,
> @@ -265,6 +266,7 @@ static const struct v4l2_file_operations mxt_video_fops = {
>         .mmap = vb2_fop_mmap,
>         .poll = vb2_fop_poll,
>  };
> +#endif

-- 
Thanks,
~Nick Desaulniers
