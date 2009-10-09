From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/6] Haptic: Documentation for haptic class (v2)
Date: Fri, 9 Oct 2009 14:59:59 +0530
Message-ID: <5d5443650910090229t6787c762qbcf854c970e117fa@mail.gmail.com>
References: <20091009090120.GA24935@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:64680 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760343AbZJIJbG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 05:31:06 -0400
In-Reply-To: <20091009090120.GA24935@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Kyungmin,

On Fri, Oct 9, 2009 at 2:31 PM, Kyungmin Park <kyungmin.park@samsung.co=
m> wrote:
> Describe the haptic class and how to use
>
> Changelog v1:
> =A0 =A0 =A0 =A0Apply comments and feedbacks
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0Documentation/haptic-class.txt | =A0 20 ++++++++++++++++++++
> =A01 files changed, 20 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/haptic-class.txt
>
> diff --git a/Documentation/haptic-class.txt b/Documentation/haptic-cl=
ass.txt
> new file mode 100644
> index 0000000..6bee82a
> --- /dev/null
> +++ b/Documentation/haptic-class.txt
> @@ -0,0 +1,20 @@
> +
> +Haptic handling under Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +In its simplest form, the haptic class just allows control of Haptic=
s from
> +userspace. Haptic appears in /sys/class/haptic/. The maximum level o=
f the
> +haptic is defined in max_level file.
> +
> +The interface is pretty simple - it provides oneshot mode where user
> +can specify duration of the effect (in milliseconds) and desired lev=
el
> +Of course, you can adjust the level by setting level property
> +
> +# echo ${millisecond} > /sys/class/haptic/<device>/oneshot
> +
> +# echo ${level} > /sys/class/haptic/<device>/level
> +
> +You can also enable or disable haptics devices by manipulating 'enab=
le' attribute:
> +
> +# echo 1 > /sys/class/haptic/<device>/enable =A0 -> Enable
> +# echo 0 > /sys/class/haptic/<device>/enable =A0 -> Disable
> --
> 1.5.3.3
>
>

Reviewed-by: Trilok Soni <soni.trilok@gmail.com>

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
