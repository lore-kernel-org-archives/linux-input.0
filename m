From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] input: gpio_keys_polled: Add support for abs/rel
 axis
Date: Sun, 20 Sep 2015 16:16:21 -0400
Message-ID: <55FF1415.1040509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbbITUQ1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Sep 2015 16:16:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

<I seem to have deleted the original mail without reply-ing, so from a threaded mailer pov this is a top-post, sorry>

Hi,

Dmitry Torokhov wrote:

 > > +	for_each_set_bit(i, input->relbit, REL_CNT) {
 > > +		if (!test_bit(i, bdev->rel_axis_seen))
 > > +			input_event(input, EV_REL, i, 0);
 > > +	}
 >
 > I wonder if this should be written as
 >
 >	for_each_set_bit(i, bdev->rel_axis_seen, REL_CNT)
 >		input_event(input, EV_REL, i, 0);
 >
 > i.e. the 2nd bit test is not really needed because we should not see
 > unsupported bits in "seen" axes.

Yes that makes sense, I'll make this change, re-test and post a new version.

 > > +		if (fwnode_property_read_u32(child, "linux,input-value",
 > > +					     (u32 *)&button->value))
 > > +			button->value = 1;
 >
 > Umm, we need negative values too... but there is no
 > fwnode_property_read_s32 :(. We need to document in the bindings that
 > value is treated as signed so that users can still achieve the needed
 > effect.

Right, I was looking how to deal with this, and the generic fwnode
interface has no s32 version, but the devicetree  linux/of.h code has:

static inline int of_property_read_s32(const struct device_node *np,
                                        const char *propname,
                                        s32 *out_value)
{
         return of_property_read_u32(np, propname, (u32*) out_value);
}

So this seemed like the best way to deal with this. You're right that
the devicetree binding docs should explicitly state that negative
numbers are allowed though, I will update the dt-bindings doc
patch accordingly.

Regards,

Hans

