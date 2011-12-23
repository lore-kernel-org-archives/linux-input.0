From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: add support of Atmel multitouch
 panels
Date: Fri, 23 Dec 2011 10:54:02 -0800
Message-ID: <4EF4CE4A.1020907@gmail.com>
References: <1324651260-4067-1-git-send-email-benjamin.tissoires@gmail.com> <1324651260-4067-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56318 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab1LWSxZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Dec 2011 13:53:25 -0500
In-Reply-To: <1324651260-4067-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/23/2011 06:40 AM, Benjamin Tissoires wrote:
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/Kconfig          |    1 +
>  drivers/hid/hid-ids.h        |    3 +++
>  drivers/hid/hid-multitouch.c |    5 +++++
>  3 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 5d6eb4e..e95b07c 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -335,6 +335,7 @@ config HID_MULTITOUCH
>  	  Say Y here if you have one of the following devices:
>  	  - 3M PCT touch screens
>  	  - ActionStar dual touch panels
> +	  - Atmel panels
>  	  - Cando dual touch panels
>  	  - Chunghwa panels
>  	  - CVTouch panels

I'm guessing this is different than the Atmel maXTouch chips. If so, can
you figure out a model name so people aren't confused on which driver to
use?

-- Chase
