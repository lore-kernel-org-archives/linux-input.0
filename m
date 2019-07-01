From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - fix -Wunused-const-variable
Date: Mon, 1 Jul 2019 01:19:55 -0700
Message-ID: <20190701081955.GF172968@dtor-ws>
References: <CAKwvOdnjTxzXgPHQcC7K8N5YkTvh66sy86oorPJZc07b7UBhGw@mail.gmail.com>
 <20190613182326.237391-1-nhuck@google.com>
 <CAKwvOd=252Ak-VQ20XtsGaRXEfraxtNTNjhjYfdrsWv_7OHsoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOd=252Ak-VQ20XtsGaRXEfraxtNTNjhjYfdrsWv_7OHsoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Huckleberry <nhuck@google.com>, nick@shmanahar.org, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 13, 2019 at 11:26:41AM -0700, Nick Desaulniers wrote:
> On Thu, Jun 13, 2019 at 11:24 AM 'Nathan Huckleberry' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > Changes from v1 -> v2
> > * Moved definition of mxt_video_fops into existing ifdef
> 
> Thanks for the v2.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied, thank you.

> 
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -256,16 +256,6 @@ enum v4l_dbg_inputs {
> >         MXT_V4L_INPUT_MAX,
> >  };
> >
> > -static const struct v4l2_file_operations mxt_video_fops = {
> > -       .owner = THIS_MODULE,
> > -       .open = v4l2_fh_open,
> > -       .release = vb2_fop_release,
> > -       .unlocked_ioctl = video_ioctl2,
> > -       .read = vb2_fop_read,
> > -       .mmap = vb2_fop_mmap,
> > -       .poll = vb2_fop_poll,
> > -};
> > -
> >  enum mxt_suspend_mode {
> >         MXT_SUSPEND_DEEP_SLEEP  = 0,
> >         MXT_SUSPEND_T9_CTRL     = 1,
> > @@ -2218,6 +2208,16 @@ static int mxt_init_t7_power_cfg(struct mxt_data *data)
> >  }
> >
> >  #ifdef CONFIG_TOUCHSCREEN_ATMEL_MXT_T37
> > +static const struct v4l2_file_operations mxt_video_fops = {
> > +       .owner = THIS_MODULE,
> > +       .open = v4l2_fh_open,
> > +       .release = vb2_fop_release,
> > +       .unlocked_ioctl = video_ioctl2,
> > +       .read = vb2_fop_read,
> > +       .mmap = vb2_fop_mmap,
> > +       .poll = vb2_fop_poll,
> > +};
> > +
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
Dmitry
