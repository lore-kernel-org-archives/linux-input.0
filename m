From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 01/63] Input: introduce input_mt_report_slot_inactive
Date: Fri, 16 Aug 2019 10:12:26 -0700
Message-ID: <20190816171226.GE121898@dtor-ws>
References: <20190816082952.17985-1-jiada_wang@mentor.com>
 <20190816082952.17985-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816082952.17985-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: nick@shmanahar.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

Hi Jiada,

On Fri, Aug 16, 2019 at 05:28:50PM +0900, Jiada Wang wrote:
> input_mt_report_slot_state() ignores the tool when the slot is closed.
> which has caused a bit of confusion.
> This patch introduces input_mt_report_slot_inactive() to report slot
> inactive state.
> replaces all input_mt_report_slot_state() with input_mt_report_slot_inactive()
> in case of close of slot, also some other related changes.

This seems to actually contain 2 changes:

- switching to use return value of input_mt_report_slot_state()
- actually introducing and using input_mt_report_slot_inactive()

Please split them.

>  
> +/**
> + * input_mt_report_slot_inactive() - report contact inactive state
> + * @dev: input device with allocated MT slots
> + *
> + * Reports the contact inactive state via ABS_MT_TRACKING_ID
> + *
> + */
> +void input_mt_report_slot_inactive(struct input_dev *dev)
> +{
> +	input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1);
> +}
> +EXPORT_SYMBOL(input_mt_report_slot_inactive);

I think this should be a static inline, there is no need to have out of
line implementation for a 1-liner.

Thanks.

-- 
Dmitry
