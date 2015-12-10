From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3] Input: xpad - Fix double URB submission races
Date: Wed, 9 Dec 2015 22:45:44 -0800
Message-ID: <20151210064544.GA35875@dtor-ws>
References: <1447714033-13809-1-git-send-email-labbott@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447714033-13809-1-git-send-email-labbott@fedoraproject.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Laura Abbott <labbott@fedoraproject.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Laura,

On Mon, Nov 16, 2015 at 02:47:13PM -0800, Laura Abbott wrote:
> +static int __xpad_submit_urb(struct usb_xpad *xpad,
> +			unsigned char odata[XPAD_PKT_LEN], int transfer_length,
> +			int type, bool safe_submit)
> +{
> +	int ret;
> +
> +	if (safe_submit || xpad->submit_state == OUT_IRQ_AVAILABLE) {
> +		memcpy(xpad->odata, odata, transfer_length);
> +		xpad->irq_out->transfer_buffer_length = transfer_length;
> +		ret = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
> +		xpad->submit_state = OUT_IRQ_QUEUE_EMPTY;
> +		xpad->out_submitter = type;
> +	} else {
> +		/*
> +		 * The goal here is to prevent starvation of any other type.
> +		 * If this type matches what is being submitted and there is
> +		 * another type in the queue, don't ovewrite it
> +		 */
> +		if (xpad->submit_state != OUT_IRQ_QUEUE_EMPTY &&
> +		    xpad->out_submitter == type &&
> +		    xpad->queue_submitter != type) {
> +			ret = -EBUSY;
> +			goto out;

No, we do not want to return "busy" here. We should save the most
up-to-date request of given type and re-submit it when URB is no longer
busy.

I CCed you on another patch addressing the same issue, please take a
look when you have a chance.

Thanks.

-- 
Dmitry
