From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: MT - Add support for balanced slot assignment
Date: Thu, 22 Jan 2015 12:02:52 -0800
Message-ID: <20150122200252.GE18153@dtor-ws>
References: <1421956345-1546-1-git-send-email-rydberg@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:50695 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbbAVUC5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 15:02:57 -0500
Content-Disposition: inline
In-Reply-To: <1421956345-1546-1-git-send-email-rydberg@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 22, 2015 at 08:52:25PM +0100, Henrik Rydberg wrote:
>  int input_mt_assign_slots(struct input_dev *dev, int *slots,
> -			  const struct input_mt_pos *pos, int num_pos)
> +			  const struct input_mt_pos *pos, int num_pos,
> +			  int dmax)

Should dmax be unsigned and do we really need to treat 0 specially or we
could use UNIT_MAX as "don't care" value?

>  {
>  	struct input_mt *mt = dev->mt;
> +	int mu = 2 * dmax * dmax;

For my education, what does "mu" stand for? Ideally, if someone could create a
write-up on the contact matching that would be most awesome.

Thanks.

-- 
Dmitry
