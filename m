From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] Haptic: Documentation for haptic class
Date: Wed, 7 Oct 2009 09:49:44 -0700
Message-ID: <20091007164944.GC12053@core.coreip.homeip.net>
References: <20091007061754.GA7588@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:43174 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571AbZJGQud (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2009 12:50:33 -0400
Content-Disposition: inline
In-Reply-To: <20091007061754.GA7588@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com

On Wed, Oct 07, 2009 at 03:17:54PM +0900, Kyungmin Park wrote:
> Describe the haptic class and how to use
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Documentation/haptic-class.txt |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/haptic-class.txt
> 
> diff --git a/Documentation/haptic-class.txt b/Documentation/haptic-class.txt
> new file mode 100644
> index 0000000..6bee82a
> --- /dev/null
> +++ b/Documentation/haptic-class.txt
> @@ -0,0 +1,20 @@
> +
> +Haptic handling under Linux
> +========================
> +
> +In its simplest form, the haptic class just allows control of Haptics from
> +userspace. Haptic appears in /sys/class/haptic/. The maximum level of the
> +haptic is defined in max_level file.
> +
> +To use simple. it provides the oneshot mode. Give millisecond time to this
> +property. It working at given time with pre-defined level.
> +Of course, you can adjust the level by setting level property

"The interface is pretty simple - it provides oneshot mode where user
can specify duration of the effect (in milliseconds) and desired level":

> +
> +# echo ${millisecond} > /sys/class/haptic/<device>/oneshot
> +
> +# echo ${level} > /sys/class/haptic/<device>/level
> +
> +Also you can enable/disable by setting enable property
> +

"You can also enable or disable haptics devices by manipulating 'enable'
attribute:"

> +# echo 1 > /sys/class/haptic/<device>/level	-> Enable
					^^^^^^ enable
> +# echo 0 > /sys/class/haptic/<device>/level	-> Disable
					^^^^^^

-- 
Dmitry
