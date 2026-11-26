Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672416;
	b=Grs8dh8mg1tFF66P+9KnXhpBrMpaEcpAHs8UOFUbefyY6016yKgqE9EuTUkAjBM2ySYQ
	 gwZicjRHf9Ta8N+6jmfSUCzXnBRSEF439YQjowqJj+kEQPpOLfTOusZdBgdDJd9kKc7Aw
	 R97jg7ohD/IvLsTGX9iEZ7vbBOSQNpKkIhqNjUOIfvfaEZos/5doK8y6QfJ9+vLPYp/nq
	 Ak5BGleBbFGJaunzbGixxDMJzxdGGeJFWqYpOTe8hW7IIkTpKh614xkA+Efd5TKitE6Eh
	 LH7FhA8NZBSyDKOlxsmYJvU5Fgt0yVSZ/12NunvTwycKEJcZPberUhzfdzDSRYplrOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lpFzseZCmgifCh5/UFXRXHpcPAb0oN98JTOIhDikihg=;
	b=SLTqDFXDFl+d8fGy72xvU2rSCGrcLo6JkE1CZtiNzUO2zzu/Kn+aqP/xLL4joSCqGrlK
	 XAzwuahElGbW8T7/9t9IrpFuErA96yY8r8vYzrez5mIlnRBjb7SQ6DPpFT1YwG9R4ZF6A
	 keHGJ3TZkdLIXJhPx/0F5naor1bXtnzm6v7EZwhUwpwjAPyzxfuRDa4wXW8H6rHI9xsWu
	 uR3cVRVr0zquxqpYn7kkZQR7CG481SVuMTTHLWe8FosSGvNshK2+sQt8bMMlBJuqP7rBB
	 /yWe7Uf5Bk5LtrKMl5WNOZV7ZUc7OqcK9e+CZLnDO4pP1cvx2yNNiG5Eb0W0rpgDgjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgQNv3vI;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EE606A33E
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 05:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F0EE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgQNv3vI
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae58d17cd9so7355581c88.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 21:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795672415; x=1796277215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lpFzseZCmgifCh5/UFXRXHpcPAb0oN98JTOIhDikihg=;
        b=CgQNv3vIZ38uT//5KWEFIyh/My+ZwZYQxAxb6Y4mq9LhGxVUX9a4FZtDZCJEU7SOYK
         vrwWWGsp3FYvooYlGaIUOZ0aRDm5/SiKbKergmuP07h42UEqKnsbwSryOxMeH4ocuKZQ
         C0/9jdtHMg9QO0BqIS7FkYSCHEAqseF8ervNYHJOkIuVHH8ddKUergtQlZaFsTRWgx5M
         Ia4zgUK7vgnf4BHnnia1bvUjbfRcLEu/F7Lw/emS85d1koAlIgDoE5wUApuu5Ronx2+G
         vL/34CCJ9KIEph9J1YxJr+2TQ/XJLrogPBmT9fFWl1M9oc8RranCIUBxKtEqzmr4jOwM
         84Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672415; x=1796277215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lpFzseZCmgifCh5/UFXRXHpcPAb0oN98JTOIhDikihg=;
        b=LFHIFobAXUHsLm3agPpsfZF4XXVW2yLhuSgAe6l3ymJgE6vpXDnhkz98Bz1HBMHzES
         ugj+8WLkjaK9AmE8pmbP1Z76hEJm+7EO4cqD/IVRRfSe4VeD6XHibH0nAUdFe9/JKShd
         wj7Zh9uEjERF34/F7dn2F5xI8G4S/S/3dQyCyEgvVYDxZbiPe4NIbSzf5rRAwgddTCoD
         j1XYjAFYcDiTvXp6v9E6MtrWoBL7gHSMr6BjGjE06c7NM5hAVwFs/bWr6EX9zMuILoMb
         qGBN6y0ABUzs5e2LXaIkVMz5gHh//7v8L/dIduu/bngJvAFIw+cJ1XqiqNRdCk0q/5Yb
         gWTQ==
X-Forwarded-Encrypted: i=1; AL+hErHqSGOAsLdKzeo72Q6vSUku2C2zuYG7oInScCU+nUJpYWOXnblG9BtcFwYfhj9/fzqe9pyfIJ4nUK0hgQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+C/9ky0jLkihn+Ke8DtiwIXaplrxB+xUGYvMMxWd/bainCyIEu
	BHmq1WobU+bUR0dd/YMHI+ch7ddxQU7oMZMYLOHrTHXlyDzhPc7tNYGx
X-Gm-Gg: AZFdTZfeddjIxyBoN+mqslJYyNbDygUFuZixfYV7fdtEiwqRuIIszCfHLeugRrJbbmL
	S+zWAvpfQD36IMXvr+xkhHXL/cCO+hig9OzEfILfgjizMZYDz6zQdi/2iLZ1mpUhFAMCIyO2MUJ
	q05W2p+0NB95VWM7VSHqw+bcyy4m/ZCgG1liyoHUCZFWwkEqVM9pEGPagytvGtW0Vy0XWi+60CW
	3bv+UDE4d0hDr5pE10/eYiPhZIH1Q7OCiPy1Qn4IUQBUGgq1EjQ32e0dYL+J+6YYIAyUOtbwWH3
	/GmacvwXe8Ox39vk4IcnkyCkaOpkOJDXk+Mv82KElhWBF01LlMAeTf4G7BtuBvqtBhG4dU3VQIq
	sHqmqOdKSu5FunTXdb9c0yXKX1J/CcM5wkyK+Ln+rBdTRhzor6U2fSFthUrIrWXiyc6HoZpX0+K
	jSPj+nx5uLBXgIdDbZLnAgRGShVwBJnjav0JdCGxa7aWjowNvXRe50iRDbGu8u9YdT59lBeUAux
	NHDfA9VzGOxkdntqSMy1u/lB3u+PTOYjlEf1E7FPYeOQwG0q1JFDzVGH/YvbGLJbW0SkL4rV8o8
	zWO/ynN0ZXE2vPOVQzD7ur+trbSwNyTOhFchQbWFLEU56iIqaKj+t0OrdXVobdkXvNHUc7c=
X-Received: by 2002:a05:7301:fc18:b0:36f:2e77:93e2 with SMTP id 5a478bee46e88-38570f27031mr20026087eec.28.1795672415063;
        Wed, 25 Nov 2026 21:53:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm61272151eec.28.2026.11.25.21.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:53:34 -0800 (PST)
Date: Wed, 25 Nov 2026 21:53:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Siarhei Vishniakou <svv@google.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Input: add ABS_TWIST event code
Message-ID: <awfJCmpYAxF5uUfm@google.com>
References: <20261126024337.4168845-1-svv@google.com>
 <20261126024337.4168845-2-svv@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126024337.4168845-2-svv@google.com>

On Wed, Nov 25, 2026 at 06:43:35PM -0800, Siarhei Vishniakou wrote:
> Some styli can report the rotation along their long ("barrel") axis.
> This is typically referred to as "twist".
> 
> Unlike ABS_MT_ORIENTATION (which describes the 2D alignment of the
> contact ellipse on the surface, analogous to stylus azimuth/tilt
> projected onto the surface), twist captures the roll of a tool around
> its own longitudinal axis independently of tilt or azimuth.
> 
> In the HID usage pages, twist is already supported as HID_DG_TWIST
> (0x000d0041). However, this usage is not reported to userspace via the
> evdev interface today, since there is no MSC_SCAN equivalent for axes.
> 
> Peripheral OEMs get around this today by mapping this axis to other axes
> like ABS_Z or ABS_RZ. This is not a valid way to report twist.
> 
> As a result, userspace programs that would like to support twist must
> account for the various ways specific OEMs map this, since there is no
> generic axis for this.
> 
> Unify this behaviour by introducing a new axis, ABS_TWIST (0x1d). This
> axis applies to single-pointer devices (such as styli), as opposed to
> per-slot multi-touch devices (which would use an ABS_MT_* axis).
> 
> Document ABS_TWIST in event-codes.rst with its value semantics:
> clockwise-increasing when viewed down the tool's major axis toward the
> surface, 0 aligned toward the top (-Y, north) of the interaction surface
> matching HID_DG_TWIST, supporting either non-negative [0, maximum] or
> signed [minimum, maximum] full-revolution ranges, and resolution in
> units/radian.
> 
> Signed-off-by: Siarhei Vishniakou <svv@google.com>
> ---
> Changes since v1:
> - Moved ABS_TWIST directly below ABS_SND_PROFILE in event-codes.rst
>   (Dmitry).
> - Expanded event-codes.rst documentation with precise value semantics:
>   clockwise-increasing direction viewed down the barrel toward the
>   surface, 0 aligned toward the top (-Y, north) of the surface,
>   non-negative [0, 360) and signed [-180, 180) ranges, wraparound
>   behavior, and distinction from ABS_MT_ORIENTATION (Dmitry).

I'd like Peter (CCed) to take a look at this too...

> 
>  Documentation/input/event-codes.rst    | 23 +++++++++++++++++++++++
>  drivers/hid/hid-debug.c                |  1 +
>  include/uapi/linux/input-event-codes.h |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index 77a6c9b3956d..4f03dcacbd55 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -247,6 +247,29 @@ A few EV_ABS codes have special meanings:
>      An event is emitted only when the selected profile changes,
>      indicating the newly selected profile value.
>  
> +* ABS_TWIST:
> +
> +  - Used to describe the rotation of a tool (such as a stylus) around its own
> +    major (barrel) axis. Unlike ABS_MT_ORIENTATION (which describes the 2D
> +    orientation of a contact ellipse on the surface), ABS_TWIST reports the
> +    tool's roll around its longitudinal axis independently of tilt or azimuth.
> +  - Values increase for clockwise rotation and decrease for counter-clockwise
> +    rotation when viewed looking down the tool's major axis toward the
> +    interaction surface (e.g., from the eraser end of a stylus toward the tip).
> +  - A value of 0 corresponds to the tool's neutral reference orientation (e.g.,
> +    its primary barrel button or flat edge) facing toward the top (-Y, north)
> +    of the interaction surface.
> +  - The range reported in struct input_absinfo may be either non-negative or
> +    signed. A non-negative range ([0, maximum]) covers [0, 360) degrees.
> +    A signed range ([minimum, maximum]) is centered at 0 and covers
> +    [-180, 180) degrees.
> +  - Unless the hardware only supports a restricted angular range, the
> +    [minimum, maximum] range spans one full revolution and wraps between
> +    maximum and minimum.
> +  - If the resolution is non-zero, the twist data is in units/radian. If the
> +    resolution is zero, userspace may assume the full [minimum, maximum] range
> +    represents one full revolution.
> +
>  * ABS_MT_<name>:
>  
>    - Used to describe multitouch input events. Please see
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index f44e6e708404..2e9ff8a3b2cf 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -3518,6 +3518,7 @@ static const char *absolutes[ABS_CNT] = {
>  	[ABS_HAT3Y] = "Hat 3Y",		[ABS_PRESSURE] = "Pressure",
>  	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
>  	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
> +	[ABS_TWIST] = "Twist",
>  	[ABS_VOLUME] = "Volume",	[ABS_PROFILE] = "Profile",
>  	[ABS_SND_PROFILE] = "SoundProfile",
>  	[ABS_MISC] = "Misc",
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 4217950e5d16..d4ed115fdeca 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -892,6 +892,7 @@
>  #define ABS_TILT_X		0x1a
>  #define ABS_TILT_Y		0x1b
>  #define ABS_TOOL_WIDTH		0x1c
> +#define ABS_TWIST		0x1d
>  
>  #define ABS_VOLUME		0x20
>  #define ABS_PROFILE		0x21

-- 
Dmitry
