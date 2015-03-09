From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v3][RFC] add raw video stream support for Samsung SUR40
Date: Mon, 09 Mar 2015 11:09:01 +0100
Message-ID: <54FD713D.5050401@xs4all.nl>
References: <1423063842-6902-1-git-send-email-floe@butterbrot.org> <54DB4295.1080307@butterbrot.org> <54E1D71C.2000003@xs4all.nl> <54E7AB1E.3000401@butterbrot.org> <54E85C48.6070907@xs4all.nl> <54F98E51.8040204@butterbrot.org> <54F993ED.2060701@xs4all.nl> <54FB5715.2090103@butterbrot.org> <54FB6636.6050308@xs4all.nl> <54FD6CAD.9030600@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <54FD6CAD.9030600@butterbrot.org>
Sender: linux-media-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-input <linux-input@vger.kernel.org>, LMML <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Florian,

On 03/09/2015 10:49 AM, Florian Echtler wrote:
> On 07.03.2015 21:57, Hans Verkuil wrote:
>> This will wait until start_streaming was called before it starts processing
>> video (and start_streaming is only called if at least 3 buffers have been
>> queued).
>>
>> Right now the first buffer can be returned without STREAMON actually having
>> been called. That's certainly wrong.
>>
>> Whether that is the cause of this bug I do not know, but fix this first.
> OK, I've fixed this, will be included in the next patch submission.
> Unfortunately still getting the same error from v4l2-compliance.
> 
>> If this doesn't solve it, then please do another run but this time use
>>
>> echo 10 >/sys/class/video4linux/videoX/dev_debug
>>
>> so I see the (D)QBUF ioctls as well. Otherwise use the same procedure as
>> before.
> See attachments - syslog with dev_debug=10, core.debug=1 and output from
> v4l2-compliance -s.
> 
> *fingers crossed even more* ;-)

OK, the cause of this failure is this message:

Mar  9 10:39:08 sur40 kernel: [ 1093.200960] sur40 2-1:1.0: error in usb_sg_wait

So you need to print the error message here (sgr.status) so that I can see what
it is.

The error almost certainly comes from usb_submit_urb(). That function does some
checks on the sgl:

       } else if (urb->num_sgs && !urb->dev->bus->no_sg_constraint &&
                        dev->speed != USB_SPEED_WIRELESS) {
                struct scatterlist *sg;
                int i;

                for_each_sg(urb->sg, sg, urb->num_sgs - 1, i)
                        if (sg->length % max)
                                return -EINVAL;
        }

I wonder it the code gets there. Perhaps a printk just before the return -EINVAL
might help here (also print the 'max' value).

So you will have to debug a bit here, trying to figure out which test in the usb
code causes the usb_sg_wait error.

Regards,

	Hans
