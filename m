From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH] Documentation: input: ff: fix small typos
Date: Fri, 19 Jan 2018 09:33:54 -0800
Message-ID: <20180119173354.qkzlfsddnmx6her3@dtor-ws>
References: <20180118214903.21017-1-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46628 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755899AbeASRd6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 12:33:58 -0500
Content-Disposition: inline
In-Reply-To: <20180118214903.21017-1-jean-francois.tetu@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Jean-Fran=E7ois_T=EAtu?= <jean-francois.tetu@savoirfairelinux.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 04:49:03PM -0500, Jean-François Têtu wrote:
> Fix small typos in the Instructions and Uploading sections. Fix a typo in
> the start/stop effect example usage code.
> 
> Signed-off-by: Jean-François Têtu <jean-francois.tetu@savoirfairelinux.com>

Applied, thank you.

> ---
>  Documentation/input/ff.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
> index 26d461998e08..0c02e87ee86d 100644
> --- a/Documentation/input/ff.rst
> +++ b/Documentation/input/ff.rst
> @@ -31,7 +31,7 @@ To enable force feedback, you have to:
>  
>  Before you start, let me WARN you that some devices shake violently during the
>  initialisation phase. This happens for example with my "AVB Top Shot Pegasus".
> -To stop this annoying behaviour, move you joystick to its limits. Anyway, you
> +To stop this annoying behaviour, move your joystick to its limits. Anyway, you
>  should keep a hand on your device, in order to avoid it to break down if
>  something goes wrong.
>  
> @@ -121,7 +121,7 @@ uploaded, but not played.
>  The content of effect may be modified. In particular, its field "id" is set
>  to the unique id assigned by the driver. This data is required for performing
>  some operations (removing an effect, controlling the playback).
> -This if field must be set to -1 by the user in order to tell the driver to
> +The "id" field must be set to -1 by the user in order to tell the driver to
>  allocate a new effect.
>  
>  Effects are file descriptor specific.
> @@ -178,7 +178,7 @@ Control of playing is done with write(). Below is an example:
>  	stop.code = effect.id;
>  	stop.value = 0;
>  
> -	write(fd, (const void*) &play, sizeof(stop));
> +	write(fd, (const void*) &stop, sizeof(stop));
>  
>  Setting the gain
>  ----------------
> -- 
> 2.15.1
> 

-- 
Dmitry
