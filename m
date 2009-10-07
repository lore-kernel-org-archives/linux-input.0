From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/6] Haptic: Documentation for haptic class
Date: Wed, 7 Oct 2009 12:35:09 +0530
Message-ID: <5d5443650910070005t48b894ddoc08788c1b14e76a4@mail.gmail.com>
References: <20091007061754.GA7588@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f202.google.com ([209.85.221.202]:44642 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZJGHFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2009 03:05:46 -0400
In-Reply-To: <20091007061754.GA7588@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Kyungmin,

On Wed, Oct 7, 2009 at 11:47 AM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> Describe the haptic class and how to use
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
> +To use simple. it provides the oneshot mode. Give millisecond time t=
o this
> +property. It working at given time with pre-defined level.

nit-pick: "To make it simple, it provides the one shot mode. Provide
milliseconds time to
this property, and it will be working for the given time with the
pre-defined level."

Please check if my above statement looks better.

> +Of course, you can adjust the level by setting level property
> +
> +# echo ${millisecond} > /sys/class/haptic/<device>/oneshot
> +
> +# echo ${level} > /sys/class/haptic/<device>/level
> +
> +Also you can enable/disable by setting enable property
> +
> +# echo 1 > /sys/class/haptic/<device>/level =A0 =A0-> Enable
> +# echo 0 > /sys/class/haptic/<device>/level =A0 =A0-> Disable
> --
> 1.5.3.3
>
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
