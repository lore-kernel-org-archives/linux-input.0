From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v2] Input: Add direction to ff-memless
Date: Fri, 25 Dec 2009 01:37:09 +0200
Message-ID: <4B33FB25.6050709@iki.fi>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com> <1261573094-26837-1-git-send-email-ext-jari.vanhala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sinikuusama.dnainternet.net ([83.102.40.134]:45671 "EHLO
	sinikuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753669AbZLXXhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2009 18:37:11 -0500
In-Reply-To: <1261573094-26837-1-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jari Vanhala <ext-jari.vanhala@nokia.com>, linux-input@vger.kernel.org

On 23.12.2009 14:58, Jari Vanhala wrote:
> This adds simple direction calculation to effect
> combine. It's useful to decide motor direction for
> rumble (vibrator).
> 
> Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
> ---
>  drivers/input/ff-memless.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)

Acked-by: Anssi Hannula <anssi.hannula@iki.fi>

-- 
Anssi Hannula
