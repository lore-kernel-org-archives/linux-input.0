From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/6] input: Add a detailed multi-touch finger data report protocol (rev2)
Date: Mon, 27 Apr 2009 18:50:49 -0400
Message-ID: <266E0723-B689-4472-8A2F-D93FC6819E04@gmail.com>
Mime-Version: 1.0 (iPhone Mail 5H11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:24988 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbZD0Wvi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2009 18:51:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Henrik,

On Wed, Jan 28, 2009 at 11:23:49AM +0100, Henrik Rydberg wrote:
> +
> +#define ABS_MT_TOUCH        0x30    /* Diameter of touching circle */
> +#define ABS_MT_TOUCH_MAJOR    0x30    /* Major axis of touching  
> ellipse */

It looks like we are overriding the same event code to trasnmit 2
slightly different kinds of data. I Am concerned that people would get
confused, maybe we should get rid of ABS_MT_TOUCH and either require
drvices always transmit ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR or
document that for curcular objects ABS_MT_TOUCH_MINOR may be omitted.

> +#define ABS_MT_TOUCH_MINOR    0x31    /* Minor axis of touching  
> ellipse */
> +#define ABS_MT_WIDTH        0x32    /* Diameter of approaching  
> circle */
> +#define ABS_MT_WIDTH_MAJOR    0x32    /* Major axis of approaching  
> ellipse */
> +#define ABS_MT_WIDTH_MINOR    0x33    /* Minor axis of approaching  
> ellipse */

Same here...

> +#define ABS_MT_ORIENTATION    0x34    /* Ellipse orientation */
> +#define ABS_MT_POSITION_X    0x35    /* Center X ellipse position */
> +#define ABS_MT_POSITION_Y    0x36    /* Center Y ellipse position */
> +#define ABS_MT_TOOL_TYPE    0x37    /* Type of touching device */
> +#define ABS_MT_BLOB_ID        0x38    /* Group a set of packets as  
> a blob */
> +
> #define ABS_MAX            0x3f
> #define ABS_CNT            (ABS_MAX+1)
>
> @@ -744,6 +758,14 @@ struct input_absinfo {
> #define BUS_ATARI        0x1B
>
> /*
> + * MT_TOOL types
> + */
> +#define MT_TOOL_FINGER        0
> +#define MT_TOOL_PEN        1
> +#define MT_TOOL_MAX        9
> +#define MT_TOOL_CNT        (MT_TOOL_MAX + 1)

MT_TOOL_FINGER/MT_TOOL_PEN are documented values of ABS_MT_TOOL_TYPE, so
I don't understand why we need MT_TOOL_MAX/MT_TOOL_CNT definitions.

Thanks.

-- 
Dmitry
